Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTIEOig (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbTIEOig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:38:36 -0400
Received: from web60109.mail.yahoo.com ([216.109.118.88]:12371 "HELO
	web60109.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263052AbTIEOid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:38:33 -0400
Message-ID: <20030905143818.54049.qmail@web60109.mail.yahoo.com>
Date: Fri, 5 Sep 2003 07:38:18 -0700 (PDT)
From: j d <jpd_hp_linux_kernel@yahoo.com>
Reply-To: dead_email@nospam-mail.org
Subject: 2.6-test4: mpspec.h:6:25: mach_mpspec.h: Missing file
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Date: Fri, 05 Sep 2003 09:25:42 -0500

> From: jpd_hp_linux_kernel@yahoo.com
> Subject: 2.6-test4: mpspec.h:6:25: mach_mpspec.h:
> Missing file
> 
> Hi.
> I'm trying to build a (add-on) module
> on a machine booted from a 2.6-test4 kernel,
> And keep running into this error. I've
> included a sample program , and gcc command
> line.
> 
> I built the kernel:
> 
> make defconfig;
> 
> It is a 2W SMP (Compaq ML850)
> couple minor modes like enet & SCSI device
> make
> My general question is, should I include the
> 
>
-I/work/src/<build>/include/asm-i386/mach-generic/mach_mpspec.h
> 
> in my gcc command line or is my build area incorrect
> is
> some way that the correct mpspec.h file can't be
> found
> ?
> 
> Thx. JD.
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! SiteBuilder - Free, easy-to-use web site
> design software
> http://sitebuilder.yahoo.com
> > In file included from
> /work/src/linux-2.6.0-test4/include/asm/smp.h:18,
>                  from
> /work/src/linux-2.6.0-test4/include/linux/smp.h:17,
>                  from
>
/work/src/linux-2.6.0-test4/include/linux/topology.h:33,
>                  from
>
/work/src/linux-2.6.0-test4/include/linux/mmzone.h:294,
>                  from
> /work/src/linux-2.6.0-test4/include/linux/gfp.h:4,
>                  from
> /work/src/linux-2.6.0-test4/include/linux/slab.h:15,
>                  from test.c:8:
>
/work/src/linux-2.6.0-test4/include/asm/mpspec.h:6:25:
> mach_mpspec.h: No such file or directory
> /work/src/linux-2.6.0-test4/include/asm/mpspec.h:8:
> `MAX_MP_BUSSES' undeclared here (not in a function)
> 
> 
> 
>  gcc -g -D__KERNEL__ -DMODULE
> -I/work/src/linux-2.6.0-test4/include \
> 	-I/work/src/linux-2.6.0-test4/drivers/scsi -c
> test.c
> 
> //  -- snip sample 
> 
> #include <linux/version.h>	// 2.6 ++
> #include <linux/config.h>	// 2.6 ++
> #include <linux/kernel.h>
> #include <linux/types.h>
> #include <linux/spinlock.h>
> #include <asm/io.h>
> #include <asm/system.h>
> #include <linux/slab.h>
> #include <linux/interrupt.h>  
> 
> #define MEMORY_TABLE_SIZE	512
> 
> void *
> my_kmalloc(unsigned int size, char *id)
> {
> 	char *ptr ;
> 	if ((ptr =
> 	     kmalloc(size,
> 		     (in_interrupt()? GFP_ATOMIC : GFP_KERNEL)))
> == NULL) {
> 		kprintf("Cannot allocate %u bytes for %s\n", size,
> id);
> 	}
> }
> 
> 
> 
> 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
