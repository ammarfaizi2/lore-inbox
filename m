Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWCaDOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWCaDOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWCaDOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:14:09 -0500
Received: from mga03.intel.com ([143.182.124.21]:57490 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751223AbWCaDOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:14:08 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17192274:sNHT14949228"
Message-Id: <200603310314.k2V3E6g28521@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 19:14:51 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUcOq3zmzy2yEaTL6XZJMfzv7kWwAAC0GA
In-Reply-To: <Pine.LNX.4.64.0603301909590.3145@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 7:12 PM
> > The use of
> >         smp_mb__before_clear_bit();
> >         clear_bit( ... );
> > 
> > is: all memory operations before this call will be visible before
> > the clear_bit().  To me, that's release semantics.
> 
> What of it? Release semantics are not a full fence or memory barrier.

The API did not require a full fence.  It is defined as a one way fence.
