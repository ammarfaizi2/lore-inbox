Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSLIGrc>; Mon, 9 Dec 2002 01:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSLIGrc>; Mon, 9 Dec 2002 01:47:32 -0500
Received: from f32.law9.hotmail.com ([64.4.9.32]:49160 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262913AbSLIGrb>;
	Mon, 9 Dec 2002 01:47:31 -0500
X-Originating-IP: [66.92.149.185]
From: "William Knop" <w_knop@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.50-ac1 mpparse -> gcc 3.0.1 segfault
Date: Mon, 09 Dec 2002 01:55:08 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F32fiSBtAM9r5h1inen000214bb@hotmail.com>
X-OriginalArrivalTime: 09 Dec 2002 06:55:08.0780 (UTC) FILETIME=[E97532C0:01C29F4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
The machine I'm working on has SMP enabled (dual 2GHZ P4 Xeon), although 
I've tried it on a different box with dual P3s and it's still a no go. It 
didn't happen on 2.5.50-vanilla, so far as I can tell (it had other compile 
errors wrt intermezzo, but it got past mpparse). Attached at the bottom is 
the make output. Any info on similar occurrences or a fix would be 
appreciated.

Thanks,
William Knop
Language Technologies Institute
Carnegie Mellon University


  gcc -Wp,-MD,arch/i386/kernel/.trampoline.o.d -D__ASSEMBLY__ -D__KERNEL__ 
-Iinclude -Iarch/i386/mach-generic -Iarch/i386/mach-defaults -nostdinc 
-iwithprefix include  -traditional  -c -o arch/i386/kernel/trampoline.o 
arch/i386/kernel/trampoline.S
  gcc -Wp,-MD,arch/i386/kernel/.mpparse.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-Iarch/i386/mach-generic -Iarch/i386/mach-defaults -nostdinc -iwithprefix 
include    -DKBUILD_BASENAME=mpparse -DKBUILD_MODNAME=mpparse   -c -o 
arch/i386/kernel/mpparse.o arch/i386/kernel/mpparse.c
arch/i386/kernel/mpparse.c:46: Internal error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
make[1]: *** [arch/i386/kernel/mpparse.o] Error 1
make: *** [arch/i386/kernel] Error 2



_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

