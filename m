Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316777AbSFDUKr>; Tue, 4 Jun 2002 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316759AbSFDUKq>; Tue, 4 Jun 2002 16:10:46 -0400
Received: from naur.csee.wvu.edu ([157.182.194.28]:54739 "EHLO
	naur.csee.wvu.edu") by vger.kernel.org with ESMTP
	id <S316755AbSFDUKo>; Tue, 4 Jun 2002 16:10:44 -0400
Subject: Reg. sparc64 linker error
From: Shanti Katta <katta@csee.wvu.edu>
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Jun 2002 16:14:26 -0400
Message-Id: <1023221667.12878.68.camel@indus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am trying to port user-mode-linux(uml) to Sparc64 arch. I am running a
custom built 2.4.18 kernel on debian (sid), Ultra 1 system. I have also
created static links sparc64-linux-ld and sparc64-linux-as. When I build
the uml sources, I am getting the following linker error:

gcc-3.0  -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -U__sparc64__
-Usparc64 -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow
-ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs -D__arch_um__ -DSUBARCH=\"sparc64\" -DNESTING=0
-D_LARGEFILE64_SOURCE  -I/home/shanti/UML/UMLSparc64/arch/um/include
-D_GNU_SOURCE -c -o unmap.o unmap.c
ld -r -o unmap_fin.o unmap.o -lc -L/usr/lib
ld: warning: sparc:v9 architecture of input file `unmap.o' is
incompatible with sparc output
ld: BFD 2.12.90.0.1 20020307 Debian/GNU Linux assertion fail
../../bfd/elflink.h:2817
ld: final link failed: Bad value

I am using gcc-3.0 with binuitls 2.12.90.0.0.1-5. When I tried using gcc
with egcs64, it gave me a bunch of parse errors. Hence, I switched to
gcc-3.0. But now, I have this linker error. Any pointers in this
direction would be appreciated.




