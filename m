Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSD2Nek>; Mon, 29 Apr 2002 09:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312687AbSD2Nej>; Mon, 29 Apr 2002 09:34:39 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:60938 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S312681AbSD2Nei>;
	Mon, 29 Apr 2002 09:34:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Compile failure: 2.4.19-pre7-ac3
Date: Mon, 29 Apr 2002 15:34:54 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020429133438Z312681-22652+2736@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

reverted -ac2
patched to -ac3
make mrproper
put .config back
make oldconfig
make dep
make bzImage

make[3]: Entering directory 
`/home/rudmer/src/kernel/linux-2.4.19-pre7-ac3/fs/ext2'
gcc -D__KERNEL__ -I/home/rudmer/src/kernel/linux-2.4.19-pre7-ac3/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4    -nostdinc -I 
/usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/include -DKBUILD_BASENAME=balloc  
-c -o balloc.o balloc.c
balloc.c: In function `ext2_new_block':
balloc.c:524: warning: long unsigned int format, unsigned int arg (arg 4)
balloc.c:397: label `io_error' used but not defined
balloc.c:383: label `out' used but not defined
{standard input}: Assembler messages:
{standard input}:0: Warning: end of file not at end of a line; newline 
inserted
{standard input}:513: Error: unknown pseudo-op: `.p2a'
gcc: Internal compiler error: program cc1 got fatal signal 11
make[3]: *** [balloc.o] Error 1
make[3]: Leaving directory 
`/home/rudmer/src/kernel/linux-2.4.19-pre7-ac3/fs/ext2'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory 
`/home/rudmer/src/kernel/linux-2.4.19-pre7-ac3/fs/ext2'
make[1]: *** [_subdir_ext2] Error 2
make[1]: Leaving directory `/home/rudmer/src/kernel/linux-2.4.19-pre7-ac3/fs'
make: *** [_dir_fs] Error 2
rudmer:~/src/kernel/linux-2.4.19-pre7-ac3 # cpp0: output pipe has been closed

ok a sig 11 from the compiler normally means some hardware failure, but i 
have never had any problems with this compiler on this machine and it has 
probably got something to do with the error.
Starting from 2.4.18 patched to 2.4.19-pre7 patched to -ac3 results in the 
same error.

	Rudmer
