Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUGCUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUGCUui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUGCUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 16:50:38 -0400
Received: from gprs214-161.eurotel.cz ([160.218.214.161]:55169 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265257AbUGCUug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 16:50:36 -0400
Date: Sat, 3 Jul 2004 22:50:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@ucw.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: current BK compilation failure on ppc32
Message-ID: <20040703205023.GF31892@elf.ucw.cz>
References: <20040703185606.GA4718@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703185606.GA4718@lst.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> kernel/power/smp.c: In function `smp_pause':
> kernel/power/smp.c:24: error: storage size of `ctxt' isn't known
> kernel/power/smp.c:24: warning: unused variable `ctxt'
> 
> kernel/power/smp.c seems to be inherently swsusp-specific but is
> compiled for CONFIG_PM. (Same seems to be true for amny other files
> in kernel/power/, but as they compile it only causes bloat..)

Patch is good, thanks and sorry for breakage.
								Pavel

> --- 1.10/kernel/power/Makefile	2004-07-02 07:23:47 +02:00
> +++ edited/kernel/power/Makefile	2004-07-03 22:07:29 +02:00
> @@ -1,5 +1,7 @@
>  obj-y				:= main.o process.o console.o pm.o
> +ifeq ($(CONFIG_SOFTWARE_SUSPEND), y)
>  obj-$(CONFIG_SMP)		+= smp.o
> +endif
>  obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
>  obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
>  

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
