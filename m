Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312509AbSCUVe2>; Thu, 21 Mar 2002 16:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312511AbSCUVeT>; Thu, 21 Mar 2002 16:34:19 -0500
Received: from smtp2.libero.it ([193.70.192.52]:59872 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S312509AbSCUVeD> convert rfc822-to-8bit;
	Thu, 21 Mar 2002 16:34:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: petali grigi <lk_ml@libero.it>
Reply-To: merlim@libero.it
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre4: Compiler crash in i386/kernel/mpparse.c
Date: Thu, 21 Mar 2002 22:36:28 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203212233.07125.lk_ml@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc crashes compiling arch/i386/kernel/mpparse.c  line 41

gcc version 3.0.2 20010905 (Red Hat Linux 7.1 3.0.1-3) 
(the one shipped with RH 7.2)

gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon    -DKBUILD_BASENAME=mpparse  
-c -o mpparse.o mpparse.c
mpparse.c:41: Internal error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

matteo merli
matteo@petaligrigi.net
