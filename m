Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269624AbUHZUis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269624AbUHZUis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUHZU3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:29:31 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:11409 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269509AbUHZUYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:24:41 -0400
From: jmerkey@comcast.net
To: William Lee Irwin III <wli@holomorphy.com>,
       Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Date: Thu, 26 Aug 2004 20:24:38 +0000
Message-Id: <082620042024.23755.412E47050006895C00005CCB2200751150970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why should Linux, which supports multiple executable formats, tie itself to ELF exclusively?
I doubt I am going to need to run ORACLE or some other piggish app on my embedded
linux system, but I would like to have more kernel address space for drivers and other
appliance type features.  What do you plan to do when the driver base becomes as 
large as the one in WIndows 2000/XP and you don't have enough memory to load all 
the drivers.  Right now, iptables barfs even with 3GB of address space when you load up about a  dozen virtual network interfaces ?  Microsoft had this same problem (only at a much
sooner juncture in their platform evolution) and went to VM support in the kernel itself to increase virtual address space for kernel apps, file systems, and drivers when thye hit the 
wall.    It's coming time to start thinking about it.  

Jeff


> At some point in the past, I wrote:
> William> ELF ABI violation. "...the reserved area shall not
> William> consume more than 1GB of the address space."
> 
> On Wed, Aug 25, 2004 at 09:46:43PM -0700, Roland Dreier wrote:
> > Agreed, but I do like running with PAGE_OFFSET == 0xB0000000 on my
> > main box, which has 1 GB of RAM.  I can avoid highmem and still use
> > the last 128 MB of RAM.  It takes me about 3 seconds to edit
> > <asm/page.h> when I build a new kernel so I'm not arguing for merging
> > this, though.
> 
> Though asinine, the ABI spec is set in stone.
> 
> 
> -- wli
