Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133016AbRAFUr0>; Sat, 6 Jan 2001 15:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132977AbRAFUrS>; Sat, 6 Jan 2001 15:47:18 -0500
Received: from [156.46.206.66] ([156.46.206.66]:24335 "EHLO eagle.netwrx1.com")
	by vger.kernel.org with ESMTP id <S132900AbRAFUrK>;
	Sat, 6 Jan 2001 15:47:10 -0500
From: "George R. Kasica" <georgek@netwrx1.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.0 make bzImage failure - Followup
Date: Sat, 06 Jan 2001 14:47:09 -0600
Organization: Netwrx Consulting Inc.
Reply-To: georgek@netwrx1.com
Message-ID: <q11f5tg6b07jatkjona1ah4pbish0s95bd@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well....got 2.2.18 to work again here but now when I try to make 2.4.0
I get 

        drivers/block/block.o drivers/char/char.o drivers/misc/misc.o
drivers/ne
t/net.o drivers/media/media.o  drivers/parport/driver.o
drivers/scsi/scsidrv.o d
rivers/cdrom/driver.o drivers/pci/driver.o drivers/video/video.o \
        net/network.o \
        /usr/src/linux-2.4.0/arch/i386/lib/lib.a
/usr/src/linux-2.4.0/lib/lib.a
/usr/src/linux-2.4.0/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[R
L]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux-2.4.0/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
bbootsect.o: file not recognized: File format not recognized
make[1]: *** [bbootsect] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.0/arch/i386/boot'
make: *** [bzImage] Error 2

I'm running the following:

 [root@eagle linux]# gcc -v
Reading specs from
/usr/local/lib/gcc-lib/i686-pc-linux-gnu/2.95.2/specs
gcc version 2.95.2 19991024 (release)

[root@eagle linux]# make -v
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
Built for i686-pc-linux-gnu
Copyright (C) 1988, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 2000
        Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

Report bugs to <bug-make@gnu.org>.

[root@eagle linux]# lilo -v
LILO version 21.6-1, Copyright (C) 1992-1998 Werner Almesberger
Linux Real Mode Interface library Copyright (C) 1998 Josh Vanderhoof
Development beyond version 21 Copyright (C) 1999-2000 John Coffman
Released 16-Dec-2000 and compiled at 12:26:34 on Jan  6 2001.

ALSO:

[root@eagle linux]# ld -v
GNU ld version 2.10.1 (with BFD 2.10.1)


===[George R. Kasica]===        +1 262 513 8503
President                       +1 206 374 6482 FAX 
Netwrx Consulting Inc.          Waukesha, WI USA 
http://www.netwrx1.com
georgek@netwrx1.com
ICQ #12862186
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
