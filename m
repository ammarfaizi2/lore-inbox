Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWCaCoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWCaCoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 21:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWCaCoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 21:44:34 -0500
Received: from mga03.intel.com ([143.182.124.21]:40363 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751191AbWCaCod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 21:44:33 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17182869:sNHT1303067038"
Message-Id: <200603310244.k2V2iQg28203@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 18:45:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUbBRx1vz5K0SWTY+Ui73TZutghAAAEYkQ
In-Reply-To: <Pine.LNX.4.64.0603301835140.2884@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 6:38 PM
> > > Neither one is correct because there will always be one combination of 
> > > clear_bit with these macros that does not generate the required memory 
> > > barrier.
> > 
> > Can you give an example?  Which combination?
> 
> For Option(1)
> 
> smp_mb__before_clear_bit()
> clear_bit(...)(

Sorry, you totally lost me.  It could me I'm extremely slow today.  For
option (1), on ia64, clear_bit has release semantic already.  The comb
of __before_clear_bit + clear_bit provides the required ordering.  Did
I miss something?  By the way, we are talking about detail implementation
on one specific architecture.  Not some generic concept that clear_bit
has no ordering stuff in there.

- Ken
