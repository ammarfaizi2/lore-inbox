Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUHBOQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUHBOQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265232AbUHBOQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:16:55 -0400
Received: from producto-valvo.com ([216.82.101.38]:57871 "EHLO
	pv.producto-valvo.com") by vger.kernel.org with ESMTP
	id S265226AbUHBOQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:16:38 -0400
Date: Mon, 2 Aug 2004 10:16:30 -0400 (EDT)
From: war <war@pv.producto-valvo.com>
To: linux-kernel@vger.kernel.org
Cc: support@highpoint-tech.com
Subject: HPT 366 - Why does HPT's driver freeze the kernel (2.4.26)?
Message-ID: <20040802101407.M10023@pv.producto-valvo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# make
gcc -DHIGHPOINT -DDRIVER_VERSION=\"1.31\" -DMODVERSIONS -DMODULE -DLINUX
-D__KER
NEL__=1 -DCONFIG_PCI -D__BOOT_KERNEL_SMP=0 -D__BOOT_KERNEL_UP=1
-D__MODULE_KERNE
L_i686=1  -DDPLL_SWITCH -DFORCE_133 -DDRIVER_REBUILD  -DSUPPORT_ARRAY
-DSUPPORT_
IOCTL -DSUPPORT_ALARM -O2 -I/usr/src/linux/include
-I/usr/src/linux/include/asm-
i386 -I/usr/src/linux/drivers/scsi -Wall -Wstrict-prototypes
-fomit-frame-pointe
r  -c hpt.c
hpt.c: In function `hpt_copy_array_info':
hpt.c:2948: warning: int format, long unsigned int arg (arg 3)
as -o baseproc.o baseproc.s
ld -m elf_i386 -r hpt37x2lib.o hpt.o baseproc.o -o hpt37x2.o

# insmod hpt37x2.o
hpt37x2.o: unresolved symbol scsi_unregister_module
hpt37x2.o: unresolved symbol scsi_register
hpt37x2.o: unresolved symbol scsi_register_module
hpt37x2.o: unresolved symbol scsi_unregister
hpt37x2.o:
Hint: You are trying to load a module without a GPL compatible license
       and it has unresolved symbols.  The module may be trying to access
       GPLONLY symbols but the problem is more likely to be a coding or
       user error.  Contact the module supplier for assistance, only they
       can help you.

# modprobe scsi_mod
# insmod hpt37x2.o
<freeze>

Read from remote host testhpt: Operation timed out
Connection to testhpt closed.

Any ideas?
If I load the kernel's driver for the HPT3xxx card, it loads, but then it
does not see any drives.

The card and driver(s) included with RedHat 7.3 worked perfectly, but it
seems that any other distribution (current) has serious problem.

Can anyone suggest what is going wrong?

Must it be booted ONLY with an initrd to properly setup the drives, or?
What is the problem with this card?

