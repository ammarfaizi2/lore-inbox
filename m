Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318990AbSHFFId>; Tue, 6 Aug 2002 01:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318991AbSHFFId>; Tue, 6 Aug 2002 01:08:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42441 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318990AbSHFFIc>;
	Tue, 6 Aug 2002 01:08:32 -0400
Date: Mon, 05 Aug 2002 21:58:17 -0700 (PDT)
Message-Id: <20020805.215817.05805181.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: rohit.seth@intel.com, frankeh@watson.ibm.com, torvalds@transmeta.com,
       gh@us.ibm.com, Martin.Bligh@us.ibm.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15695.22556.128499.64377@napali.hpl.hp.com>
References: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
	<15695.22556.128499.64377@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 5 Aug 2002 22:01:16 -0700
   
   In my opinion, this is perhaps the strongest argument *for* a separate
   "giant page" syscall interface.  It will be very hard (perhaps
   impossible) to optimize superpages to work efficiently when the ratio
   of superpage/basepage grows huge (as, by definition, the kernel would
   manage them as a set of basepages).

Actually, this is one of the reasons there was a lot of research into
using sub-page clustering for large mappings in the TLB.  Basically
how this worked is that for a superpage, you could stick multiple
sub-mappings into the entry such that you didn't need a fully
physically contiguous superpage.

It's talked about in one of the Talluri papers.
