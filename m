Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281342AbRKMAsj>; Mon, 12 Nov 2001 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281326AbRKMAsa>; Mon, 12 Nov 2001 19:48:30 -0500
Received: from c1765315-a.mckiny1.tx.home.com ([65.10.75.71]:260 "EHLO
	aruba.maner.org") by vger.kernel.org with ESMTP id <S281342AbRKMAsQ> convert rfc822-to-8bit;
	Mon, 12 Nov 2001 19:48:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Compile error 2.4.15-pre4 on alpha
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Date: Mon, 12 Nov 2001 18:48:15 -0600
content-class: urn:content-classes:message
Message-ID: <C033B4C3E96AF74A89582654DEC664DB5576@aruba.maner.org>
Thread-Topic: Compile error 2.4.15-pre4 on alpha
Thread-Index: AcFr3MNOOABrq8D5RTKuHvkjvUM3QQ==
From: "Donald Maner" <donjr@maner.org>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm compiling on a PC164SX, and I'm getting this at the end.  I'm
pretty sure the math stuff doesn't have anything to do w/ it, but just
incase:

make[2]: Entering directory
`/usr/users/donjr/linux-2.4.15-pre4/arch/alpha/math-emu'
gcc -D__KERNEL__ -I/usr/users/donjr/linux-2.4.15-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6    -c -o math.o math.c
math.c: In function `alpha_fp_emul':
math.c:204: warning: right shift count is negative
math.c:204: warning: left shift count >= width of type
math.c:220: warning: left shift count is negative
math.c:238: warning: statement with no effect
math.c:258: warning: right shift count >= width of type
math.c:258: warning: right shift count >= width of type
math.c:262: warning: right shift count >= width of type
math.c:262: warning: right shift count >= width of type
math.c:270: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:270: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:277: warning: statement with no effect
math.c:99: warning: `SR_c' might be used uninitialized in this function
math.c:99: warning: `SR_s' might be used uninitialized in this function
math.c:99: warning: `SR_e' might be used uninitialized in this function
math.c:99: warning: `SR_f' might be used uninitialized in this function
math.c:100: warning: `DR_c' might be used uninitialized in this function
math.c:100: warning: `DR_s' might be used uninitialized in this function
math.c:100: warning: `DR_e' might be used uninitialized in this function
math.c:100: warning: `DR_f' might be used uninitialized in this function
gcc  -D__KERNEL__ -I/usr/users/donjr/linux-2.4.15-pre4/include  -c -o
qrnnd.o qrnnd.S
rm -f math-emu.o
ld  -r -o math-emu.o math.o qrnnd.o
make[2]: Leaving directory
`/usr/users/donjr/linux-2.4.15-pre4/arch/alpha/math-emu'
make[1]: Leaving directory
`/usr/users/donjr/linux-2.4.15-pre4/arch/alpha/math-emu'
gcc -E -D__KERNEL__ -I/usr/users/donjr/linux-2.4.15-pre4/include -xc -P
arch/alpha/vmlinux.lds.in -o arch/alpha/vmlinux.lds
ld -static -T arch/alpha/vmlinux.lds -N  arch/alpha/kernel/head.o
init/main.o init/version.o \
        --start-group \
        arch/alpha/kernel/kernel.o arch/alpha/mm/mm.o kernel/kernel.o
mm/mm.o fs/fs.o ipc/ipc.o arch/alpha/math-emu/math-emu.o \
         drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
drivers/net/net.o drivers/media/media.o drivers/ide/idedriver.o
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o
drivers/video/video.o drivers/md/mddev.o \
        net/network.o \
        /usr/users/donjr/linux-2.4.15-pre4/arch/alpha/lib/lib.a
/usr/users/donjr/linux-2.4.15-pre4/lib/lib.a
/usr/users/donjr/linux-2.4.15-pre4/arch/alpha/lib/lib.a \
        --end-group \
        -o vmlinux
fs/fs.o: In function `cpuinfo_open':
fs/fs.o(.text+0x2cf88): undefined reference to `cpuinfo_op'
make: *** [vmlinux] Error 1
