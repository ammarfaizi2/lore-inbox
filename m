Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284197AbRLFTvJ>; Thu, 6 Dec 2001 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284171AbRLFTut>; Thu, 6 Dec 2001 14:50:49 -0500
Received: from pD9530ACB.dip.t-dialin.net ([217.83.10.203]:25180 "HELO
	pc1.geisel.info") by vger.kernel.org with SMTP id <S282684AbRLFTug>;
	Thu, 6 Dec 2001 14:50:36 -0500
Date: Thu, 6 Dec 2001 20:50:25 +0100
From: devnull@geisel.info
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre5 "make bzImage" fails
Message-ID: <20011206195025.GA9599@geisel.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.23.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I switched from 2.4.16 to 2.4.17-pre5 without changing config and now 
"make bzImage" fails with the following error:

----------------------------------------------------------------------------
tmppiggy=_tmp_$$piggy; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
objcopy -O binary -R .note -R .comment -S /usr/src/linux/vmlinux
$tmppiggy; \
gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
echo "SECTIONS { .data : { input_len = .; LONG(input_data_end -
input_data) input_data = .; *(.data) input_data_end = .; }}" >
$tmppiggy.lnk; \
ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T
$tmppiggy.lnk; \
rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
gcc -D__ASSEMBLY__ -D__KERNEL__ -I/usr/src/linux/include -traditional -c
head.S
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon  -c misc.c
ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
piggy.o
ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
ld: final link failed: Bad value
make[2]: *** [bvmlinux] Error 1
make[2]: Leaving directory directory
»/usr/src/linux/arch/i386/boot/compressed«
make[1]: *** [compressed/bvmlinux] Error 2
make[1]: Leaving directory directory
»/usr/src/linux/arch/i386/boot«
make: *** [bzImage] Error 2
----------------------------------------------------------------------------

Thanks for your support.
Dominik Geisel

-- 
The best we can hope for concerning the people at large is that they be
properly armed.
-Alexander Hamilton, The Federalist Papers at 184-188
9D84 35D7 07D8 6C3A 5D64  8F6E EAB5 159D E521 5E2D
