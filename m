Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314358AbSEBLSR>; Thu, 2 May 2002 07:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314362AbSEBLSQ>; Thu, 2 May 2002 07:18:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:58111 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314358AbSEBLSQ>; Thu, 2 May 2002 07:18:16 -0400
Date: Thu, 2 May 2002 12:51:51 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>, Maksim Krasnyanskiy <maxk@qualcomm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.12-dj1
In-Reply-To: <20020501203612.GA4167@suse.de>
Message-ID: <Pine.NEB.4.40.0205021248290.14217-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002, Dave Jones wrote:

>...
> o   Bluetooth update.				(Maksim (Max) Krasnyanskiy)
>...

"dev_list" is now defined in two files and I got the following compile
error when building a kernel with all Bluetooth drivers compiled
statically into the kernel:

<--  snip  -->

...
make[3]: Entering directory
`/home/bunk/linux/kernel-2.5/linux-2.5.12/drivers/bluetooth'
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hci_usb  -c
-o hci_usb.o hci_usb.c
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hci_vhci  -c
-o hci_vhci.o hci_vhci.c
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hci_ldisc  -c
-o hci_ldisc.o hci_ldisc.c
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=hci_h4  -c -o
hci_h4.o hci_h4.c
ld -m elf_i386 -r -o hci_uart.o hci_ldisc.o hci_h4.o
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=dtl1_cs  -c
-o dtl1_cs.o dtl1_cs.c
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=bluecard_cs
-c -o bluecard_cs.o bluecard_cs.c
rm -f bluetooth.o
ld -m elf_i386  -r -o bluetooth.o hci_usb.o hci_vhci.o hci_uart.o
dtl1_cs.o bluecard_cs.o
bluecard_cs.o(.data+0x40): multiple definition of `dev_list'
dtl1_cs.o(.data+0x40): first defined here
make[3]: *** [bluetooth.o] Error 1
make[3]: Leaving directory `/home/bunk/linu

<-- snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


