Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUB1SpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 13:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUB1SpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 13:45:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:8603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbUB1So5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 13:44:57 -0500
Date: Sat, 28 Feb 2004 10:41:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-Id: <20040228104105.5a699d32.rddunlap@osdl.org>
In-Reply-To: <40408852.8040608@helsinki.fi>
References: <40408852.8040608@helsinki.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004 14:23:46 +0200 Kliment Yanev <Kliment.Yanev@helsinki.fi> wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| I was attempting to compile the nokia c110 linux driver, meant for 2.4
| kernels, on 2.6.3. Unsurprisingly, it gave me some errors. I suspect
| that the modification to the source would not be too difficult, it just
| seems to use some deprecated functions. I would be very willing to fix
| it myself, however, I am not familiar with the kernel code at all. Here
| are the errors the compile gives. Do you think you could point me in the
| right direction? Below is the source of the file causing the errors as well.
| 
| gcc output starts here:
| 
| set -e; for d in src dctl; do make -C $d ; done
| make[1]: Entering directory `/home/kliment/Desktop/nokia_c110/src'
| gcc -O2 -Wall -Wstrict-prototypes -fomit-frame-pointer -pipe
| - -D__KERNEL__ -DMODULE -I../include -I/usr/src/linux/include     -c  dllc.c
| In file included from /usr/src/linux/include/asm/processor.h:18,
| ~                 from /usr/src/linux/include/asm/thread_info.h:13,
| ~                 from /usr/src/linux/include/linux/thread_info.h:21,
| ~                 from /usr/src/linux/include/linux/spinlock.h:12,
| ~                 from /usr/src/linux/include/linux/capability.h:45,
| ~                 from /usr/src/linux/include/linux/sched.h:7,
| ~                 from /usr/src/linux/include/linux/module.h:10,
| ~                 from nokia_info.h:42,
| ~                 from dllc.c:29:
| /usr/src/linux/include/asm/system.h: In function `__set_64bit_var':
| /usr/src/linux/include/asm/system.h:193: warning: dereferencing
| type-punned pointer will break strict-aliasing rules
| /usr/src/linux/include/asm/system.h:193: warning: dereferencing
| type-punned pointer will break strict-aliasing rules
| In file included from /usr/src/linux/include/linux/irq.h:20,
| ~                 from /usr/src/linux/include/asm/hardirq.h:6,
| ~                 from /usr/src/linux/include/linux/interrupt.h:11,
| ~                 from nokia_info.h:52,
| ~                 from dllc.c:29:
| /usr/src/linux/include/asm/irq.h:16:25: irq_vectors.h: No such file or
| directory
| In file included from /usr/src/linux/include/asm/hardirq.h:6,
| ~                 from /usr/src/linux/include/linux/interrupt.h:11,
| ~                 from nokia_info.h:52,
| ~                 from dllc.c:29:
| /usr/src/linux/include/linux/irq.h: At top level:
| /usr/src/linux/include/linux/irq.h:70: error: `NR_IRQS' undeclared here
| (not in a function)
| In file included from /usr/src/linux/include/linux/irq.h:72,
| ~                 from /usr/src/linux/include/asm/hardirq.h:6,
| ~                 from /usr/src/linux/include/linux/interrupt.h:11,
| ~                 from nokia_info.h:52,
| ~                 from dllc.c:29:
| /usr/src/linux/include/asm/hw_irq.h:28: error: `NR_IRQ_VECTORS'
| undeclared here (not in a function)
| /usr/src/linux/include/asm/hw_irq.h:31: error: `NR_IRQS' undeclared here
| (not in a function)
| In file included from nokia_info.h:89,
| ~                 from dllc.c:29:
| nokia_priv.h:43:1: warning: "HZ" redefined
| In file included from /usr/src/linux/include/linux/sched.h:4,
| ~                 from /usr/src/linux/include/linux/module.h:10,
| ~                 from nokia_info.h:42,
| ~                 from dllc.c:29:
| /usr/src/linux/include/asm/param.h:5:1: warning: this is the location of
| the previous definition
| dllc.c: In function `dllc_devopen':
| dllc.c:156: warning: `MOD_INC_USE_COUNT' is deprecated (declared at
| /usr/src/linux/include/linux/module.h:488)
| dllc.c: In function `dllc_devstop':
| dllc.c:169: warning: `MOD_DEC_USE_COUNT' is deprecated (declared at
| /usr/src/linux/include/linux/module.h:500)
| make[1]: *** [dllc.o] Error 1
| make[1]: Leaving directory `/home/kliment/Desktop/nokia_c110/src'
| make: *** [all] Error 2
| 
| gcc errors end here
| dllc.c starts here:
[snip]

What is this driver for?  Where can I find it?

All those errors should go away if you build the module correctly.
Please read Documentation/kbuild/m*.txt or see LWN.net article
on building modules:
  http://lwn.net/Articles/21823/

--
~Randy
