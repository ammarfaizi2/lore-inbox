Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTKJNha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTKJNh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:37:29 -0500
Received: from du117001.wb3.ptd.net ([204.186.117.1]:41600 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263479AbTKJNh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:37:27 -0500
Date: Mon, 10 Nov 2003 08:37:16 -0500
From: Stan Benoit <sab7@mail.ptd.net>
To: linux-kernel@vger.kernel.org
Subject: sparc 20 problem ver test9
Message-ID: <20031110083716.A32096@mail.ptd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

System:
SPARC Station 20
Processor(s):
SuperSPARC II
Kernel: linux-2.6.0-test9
GCC: 2.95.3

1. make mrproper OK
2. make menuconfig OK
3. make


  CC      init/main.o
In file included from include/asm-generic/local.h:7,
                 from include/asm/local.h:4,
                 from include/linux/module.h:19,
                 from init/main.c:15:
include/asm/hardirq.h: In function `irqs_running':
include/asm/hardirq.h:134: `smp_num_cpus' undeclared (first use in this function)
include/asm/hardirq.h:134: (Each undeclared identifier is reported only once
include/asm/hardirq.h:134: for each function it appears in.)
include/asm/hardirq.h:135: `__brlock_array' undeclared (first use in this function)
include/asm/hardirq.h:135: `BR_GLOBALIRQ_LOCK' undeclared (first use in this function)
include/asm/hardirq.h: In function `release_irqlock':
include/asm/hardirq.h:147: warning: implicit declaration of function `br_write_unlock'
include/asm/hardirq.h:147: `BR_GLOBALIRQ_LOCK' undeclared (first use in this function)
In file included from init/main.c:33:
include/linux/kernel_stat.h: In function `kstat_irqs':
include/linux/kernel_stat.h:47: warning: implicit declaration of function `cpu_possible'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

shouldn't this be pointing to:

include/asm-sparc/hardirg.h  ???


Thanks,


-- 
Stan Benoit<sab7@mail.ptd.net>
Mondo Dev/Testing 
http://www.mondorescue.org
Testing:
http://www.nakedsoul.org/~troff

