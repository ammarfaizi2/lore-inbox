Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUFGWU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUFGWU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265096AbUFGWU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:20:58 -0400
Received: from user2.empirix.com ([12.104.12.2]:11971 "EHLO
	empwilex1.empirix.com") by vger.kernel.org with ESMTP
	id S265094AbUFGWUw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:20:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.4.22 Patch for problem solved in 2.4.1
Date: Mon, 7 Jun 2004 18:20:50 -0400
Message-ID: <2A9AA9C52024F94A96634E39B9858FF166B884@empwilex1.empirix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.22 Patch for problem solved in 2.4.1
Thread-Index: AcRM3bJauhfbkJbIR4SItey/I2MhzQ==
From: "Dunn, Charles" <CDunn@Empirix.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all and I apologize in advance for dragging up old skeletons.. I
am developing a kernel module and need to compile a version of the
2.4.22 kernel with SMP (NO Athlon support required) and KDB.. 

In trying to compile it I get the error that was much discussed on this
list in January and February of 2001.. The error text is included at the
end of this message for reference..

This is the infamous "current is undefined". There was a final patch
generated and distributed to this list as part of this posting:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0102.1/0588.html


Regrettably, because this patch was for 2.4.1, and I am trying to build
2.4.22 (Mandrake 9.2) the patch does not apply cleanly.. I have been
unable to find a patch for any version other than 2.4.1 in the archives.


Anyone know of a version of this patch for 2.4.22 (or at least close)
kernels? I certainly do not want to try and duplicate the work done by
Tom Leete and company on this as I do not have the Linux kernel
experience, and need to get this going quickly...

There was a great deal of discussion about whether this was related to
Athlon support or not, and I thought the conclusion was that it is NOT
related, yet the final fix was entitled Athlon-SMP final... I do not
need Athlon support as I am running on only P3 and P4 processors. (No
SMP on P3, just used as initial testbed). So a simple solution that
means leaving Athlon support out is AOK for my situation.

Any further information about patching this in 2.4.22 is greatly
appreciated! Many thanks to Tom Leete and all the other folks who did
the original work to fix this!

Charlie Dunn


The compilation error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.22-10mdk/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i586
-fno-optimize-sibling-calls   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=cpufreq  -DEXPORT_SYMTAB -c cpufreq.c -o cpufreq.o
In file included from
/usr/src/linux-2.4.22-10mdk/include/linux/irq.h:69,
                 from
/usr/src/linux-2.4.22-10mdk/include/asm/hardirq.h:6,
                 from
/usr/src/linux-2.4.22-10mdk/include/linux/interrupt.h:52,
                 from cpufreq.c:21:
/usr/src/linux-2.4.22-10mdk/include/asm/hw_irq.h: In function
`x86_do_profile':
/usr/src/linux-2.4.22-10mdk/include/asm/hw_irq.h:206: error: `current'
undeclared (first use in this function)
/usr/src/linux-2.4.22-10mdk/include/asm/hw_irq.h:206: error: (Each
undeclared identifier is reported only once
/usr/src/linux-2.4.22-10mdk/include/asm/hw_irq.h:206: error: for each
function it appears in.)
make[2]: *** [cpufreq.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.22-10mdk/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.22-10mdk/kernel'
make: *** [_dir_kernel] Error 2

