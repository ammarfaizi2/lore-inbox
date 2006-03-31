Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWCaDLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWCaDLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWCaDLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:11:06 -0500
Received: from mga03.intel.com ([143.182.124.21]:72 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751210AbWCaDLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:11:04 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17191312:sNHT15134021"
Message-Id: <200603310311.k2V3B3g28498@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Zoltan Menyhart'" <Zoltan.Menyhart@bull.net>,
       "'Boehm, Hans'" <hans.boehm@hp.com>,
       "'Grundler, Grant G'" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 19:11:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUcG9WMh3BLIibTrewWhknqyBf9QAAEGzA
In-Reply-To: <Pine.LNX.4.64.0603301907070.3145@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 7:09 PM
> I was referring to the LOCK prefix. Doesnt that insure the processor to 
> go into a special state and make the bus go into a special state that 
> implies a barrier?

Yes, that's why on i386 both smp_mb__before_clear_bit() and 
smp_mb__after_clear_bit() are noop.
