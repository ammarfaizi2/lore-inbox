Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278300AbRJMOS4>; Sat, 13 Oct 2001 10:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278302AbRJMOSr>; Sat, 13 Oct 2001 10:18:47 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:51954 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S278300AbRJMOSn>; Sat, 13 Oct 2001 10:18:43 -0400
Date: Sat, 13 Oct 2001 15:19:13 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.12 boots on sparc! :o) 
Message-ID: <Pine.LNX.4.33.0110131518440.1249-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just figured out that if you enable SMP when building kernels, it boots.
Non-SMP kernels will not boot at all, it hangs on this SS20.

Modules don't appear to be compiled properly - here's some output. Does
anyone knows why this is so and what needs to be fixed to get them to
work? I'd happily fix them if I knew why.

I prefer to use modules for some of the least often used parts to save on
memory.

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.12; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/block/loop.o
depmod:         .div
depmod:         .urem
depmod:         .umul
depmod:         .udiv
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/char/lp.o
depmod:         .div
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/net/bsd_comp.o
depmod:         .udiv
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/net/ppp_deflate.o
depmod:         .urem
depmod:         .umul
depmod:         .udiv
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/net/ppp_generic.o
depmod:         .udiv
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/parport/parport.o
depmod:         .div
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/sbus/audio/audio.o
depmod:         .div
depmod:         .umul
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/sbus/audio/dbri.o
depmod:         .div
depmod:         .umul
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/scsi/sg.o
depmod:         .div
depmod:         .udiv
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/drivers/scsi/st.o
depmod:         .div
depmod:         .urem
depmod:         .umul
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/fs/efs/efs.o
depmod:         .div
depmod:         .umul
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/fs/fat/fat.o
depmod:         .div
depmod:         .urem
depmod:         .umul
depmod:         .udiv
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/fs/openpromfs/openpromfs.o
depmod:         .div
depmod:         .urem
depmod:         .udiv
depmod:         .rem
depmod: *** Unresolved symbols in /lib/modules/2.4.12/kernel/fs/vfat/vfat.o
depmod:         .div
depmod:         .rem


-- 
Top posters will be automatically killfiled.

http://www.tahallah.demon.co.uk

-
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

