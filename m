Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTDCTdO 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263472AbTDCTdO 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:33:14 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25793 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263452AbTDCTbu 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 14:31:50 -0500
Date: Thu, 3 Apr 2003 14:43:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] update $ARCH to match syscalls return long
Message-ID: <20030403144317.C1437@devserv.devel.redhat.com>
References: <20030403113249.7d672386.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030403113249.7d672386.rddunlap@osdl.org>; from rddunlap@osdl.org on Thu, Apr 03, 2003 at 11:32:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 3 Apr 2003 11:32:49 +0000
> From: "Randy.Dunlap" <rddunlap@osdl.org>

> --- ./arch/sparc/kernel/sys_sparc.c%SCPRL	Mon Mar 24 14:00:17 2003
> +++ ./arch/sparc/kernel/sys_sparc.c	Thu Apr  3 10:39:42 2003
> @@ -269,11 +269,11 @@
>  	return do_mmap2(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
>  }
>  
> -extern int sys_remap_file_pages(unsigned long start, unsigned long size,
> +extern long sys_remap_file_pages(unsigned long start, unsigned long size,
>  				unsigned long prot, unsigned long pgoff,
>  				unsigned long flags);

I know for a fact that a global sys_remap_file_pages prototype
exists (in mm.h). It's better not to change it to match, but remove
extra copies from .c files. The sparc had it for about a week
(Rob Radez fixed it).

-- Pete
