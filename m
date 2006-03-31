Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWCaA7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCaA7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCaA7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:59:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:50620 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751083AbWCaA7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:59:08 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="17434804:sNHT18264869"
Message-Id: <200603310059.k2V0x7g26953@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 16:59:52 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUXT4nYOxIpW/+TCuP3tK8FtFGuAAAGbPA
In-Reply-To: <Pine.LNX.4.64.0603301650220.2068@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Thursday, March 30, 2006 4:51 PM
> > > It precise the uncleanness in ia64 that such semantics are attached to 
> > > these bit operations which may lead people to depend on those. We need to 
> > > either make these explicit or not depend on them.
> > 
> > I know, I'm saying since it doesn't make any difference from API point of
> > view whether it is acq, rel, or no ordering, then just make them rel as a
> > "preferred" Operation on ia64.
> 
> That would make the behavior of clear_bit different from other bitops and 
> references to volatile pointers. I'd like to have this as consistent as 
> possible.

Yeah, but we just agreed that caller shouldn't be thinking clear_bit has
memory ordering at all.

- Ken
