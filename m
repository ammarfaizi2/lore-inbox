Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUJLRjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUJLRjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJLRib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:38:31 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:43913 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266519AbUJLRdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:33:46 -0400
Date: Tue, 12 Oct 2004 19:33:44 +0200
To: linux-kernel@vger.kernel.org
Cc: debian-alpha@lists.debian.org
Subject: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041012173344.GA21846@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel Gurus!

[debian/woody on alpha sx165/lx164, gcc-3.3.4]

We need to netboot our alphas (because booting from the SCSI controllers
is not an option, they are not supported by the SRM console) and I try
to make a bootp image of our kernel.

When doing this on our alpha the
	make bootimage
and the 
	make bootpfile
both bail out with:
make[1]: Entering directory `/usr/src/linux-2.4.27/arch/alpha/boot'
tools/objstrip -v /usr/src/linux-2.4.27/vmlinux vmlinux.nh
tools/objstrip: extracting 0xfffffc0000310000-0xfffffc00005cfef8 (at
2000)
tools/objstrip: copying 2883320 byte from /usr/src/linux-2.4.27/vmlinux
tools/objstrip: zero-filling bss and aligning to 0 with 393432 bytes
echo "#define KERNEL_SIZE `ls -l vmlinux.nh | awk '{print $5}'`" >
ksize.hT
cmp -s ksize.hT ksize.h || mv -f ksize.hT ksize.h
rm -f ksize.hT
ld -static -T bootloader.lds  head.o main.o
/usr/src/linux-2.4.27/arch/alpha/lib/lib.a
/usr/src/linux-2.4.27/lib/lib.a
/usr/src/linux-2.4.27/arch/alpha/lib/lib.a -o bootloader
/usr/src/linux-2.4.27/lib/lib.a(vsprintf.o): In function `vsnprintf':
vsprintf.o(.text+0xcd4): undefined reference to `printk'
vsprintf.o(.text+0xcdc): undefined reference to `printk'
/usr/src/linux-2.4.27/lib/lib.a(dump_stack.o): In function `dump_stack':
dump_stack.o(.text+0x10): undefined reference to `printk'
dump_stack.o(.text+0x1c): undefined reference to `printk'
make[1]: *** [bootloader] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.27/arch/alpha/boot'
make: *** [bootimage] Error 2

and similar with bootpfile

Is there a way around this, we definitely need the bootp image.

Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCREEB (n.)
To make the noise of a nylon anorak rubbing against a pair of corduroy
trousers.
			--- Douglas Adams, The Meaning of Liff
