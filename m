Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWCaGPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWCaGPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWCaGPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:15:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:6953 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751027AbWCaGPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:15:07 -0500
X-IronPort-AV: i="4.03,148,1141632000"; 
   d="scan'208"; a="18065264:sNHT927472490"
Message-Id: <200603310614.k2V6Ehg30012@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "'Christoph Lameter'" <clameter@sgi.com>,
       "Zoltan Menyhart" <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Synchronizing Bit operations V2
Date: Thu, 30 Mar 2006 22:15:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZUhjITxjcXqXHOQoerYCZ4doKUoQAA48vg
In-Reply-To: <442C99A1.6060901@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, March 30, 2006 6:53 PM
> >>smp_mb__before_clear_bit()
> >>clear_bit(...)(
> > 
> > Sorry, you totally lost me.  It could me I'm extremely slow today.  For
> > option (1), on ia64, clear_bit has release semantic already.  The comb
> > of __before_clear_bit + clear_bit provides the required ordering.  Did
> > I miss something?  By the way, we are talking about detail implementation
> > on one specific architecture.  Not some generic concept that clear_bit
> > has no ordering stuff in there.
> > 
> 
> The memory ordering that above combination should produce is a
> Linux style smp_mb before the clear_bit. Not a release.

Whoever designed the smp_mb_before/after_* clearly understand the
difference between a bidirectional smp_mb() and a one-way memory
ordering.  If smp_mb_before/after are equivalent to smp_mb, what's
the point of introducing another interface?

- Ken
