Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTGLE24 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbTGLE24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 00:28:56 -0400
Received: from sps.nus.edu.sg ([137.132.69.89]:62980 "HELO sps.nus.edu.sg")
	by vger.kernel.org with SMTP id S267561AbTGLE2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 00:28:46 -0400
Date: Sat, 12 Jul 2003 12:36:56 +0800 (SGT)
From: Didier Casse <didierbe@sps.nus.edu.sg>
To: linux-kernel@vger.kernel.org
Subject: Bug in redhat 9 kernel-> problems with cpufreq.c during recompilation
In-Reply-To: <Pine.LNX.4.44.0307121057360.26536-100000@kepler.sps.nus.edu.sg>
Message-ID: <Pine.LNX.4.44.0307121224480.26761-100000@kepler.sps.nus.edu.sg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
         I tried to patch my Linux kernel 2.4.20-8 i686 i386 GNU/Linux (on 
redhat 9)  with the linux-ppscsi patch so that I can add my parallel port 
scanner to my pc. 

I started as follows in the /usr/src/linux-2.4.20-8/ directory

step 1. patch -p1 < linux.ppscsi.patch
step 2. make menuconfig to ensure SCSI suppoer and parallel port support
step 3. make dep
step 4. make bzImage
step 5. make modules

then error occures at step 5 as shown below:

+--------------------------------------------------------------------+
/usr/src/linux-2.4.20-8/include/linux/dcache.h: In function `dget':
/usr/src/linux-2.4.20-8/include/linux/dcache.h:254: warning: implicit 
declaration of function `__out_of_line_bug_R8b0fd3c5'
cpufreq.c: In function `cpufreq_parse_policy':
cpufreq.c:111: warning: implicit declaration of function 
`sscanf_R859204af'
cpufreq.c: In function `cpufreq_proc_read':
cpufreq.c:225: warning: implicit declaration of function 
`sprintf_R1d26aa98'
cpufreq.c: In function `cpufreq_proc_init':
cpufreq.c:327: warning: implicit declaration of function 
`printk_R1b7d4074'
cpufreq.c: In function `cpufreq_restore_Re39890df':
cpufreq.c:1109: warning: implicit declaration of function 
`panic_R01075bf0'
cpufreq.c: At top level:
cpufreq.c:192: warning: `cpufreq_setup' defined but not used
make[1]: *** [cpufreq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20-8/kernel'
make: *** [_mod_kernel] Error 2
+--------------------------------------------------------------------+

Can anybody help me out with this thing as i really need to get that
scanner going? I have no clue how to solve this type of error and
everybody on the redhat mailing list is clueless too!  Thanks for helping 
out.

regards,

Didier

---
PhD student

Singapore Synchrotron Light Source (SSLS)
5 Research Link,
Singapore 117603

Email: slsbdfc@nus.edu.sg or didierbe@sps.nus.edu.sg
Website: http://ssls.nus.edu.sg




