Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVFKSa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVFKSa5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 14:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVFKSa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 14:30:57 -0400
Received: from mxsf13.cluster1.charter.net ([209.225.28.213]:30641 "EHLO
	mxsf13.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261774AbVFKSaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 14:30:52 -0400
X-IronPort-AV: i="3.93,191,1115006400"; 
   d="scan'208"; a="365393795:sNHT16069140"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
Organization: University of Georgia
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Date: Sat, 11 Jun 2005 14:31:52 +0000
User-Agent: KMail/1.8
References: <200506071836.12076.martin@cs.uga.edu> <m1wtp1ch07.fsf@muc.de>
In-Reply-To: <m1wtp1ch07.fsf@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506111431.52944.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it has or the strange software memhole (what is that?)
> From your oopses i more suspect it is hardware actually:
> > Jun  7 14:11:27 optimator Unable to handle kernel paging request at
> > 00000000000025b0 RIP: Jun  7 14:11:27 optimator
> > <ffffffff8016797a>{pte_alloc_map+170}
>
> It crashes on first accessing newly allocated memory for page tables.

> Most likely something is wrong with your memory or memory map.
> Maybe it is related to your "discrete mtrr mapping" or your "software
> memhole" whatever they are? I would suggest to try without these.


	There are three options for Memhole mapping in my BIOS:  Disabled, Hardware, 
and Software.  I really don't know why there would be a "software" option, or 
what it does.  Also, I'm not sure what the difference between continuous and 
discrete MTRR mapping is.  The BIOS says it has to do with some linux 
kernels, but I haven't found any reliable information about it.

I disabled Memhole mapping and PREEMPT entirely.  I'll try to stress test out 
some more oopses.  I'll also memtest86 all of the memory.

Thanks for the help,
Jake Martin
