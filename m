Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTBRAYO>; Mon, 17 Feb 2003 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTBRAYN>; Mon, 17 Feb 2003 19:24:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39953 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267043AbTBRAYM>; Mon, 17 Feb 2003 19:24:12 -0500
Date: Tue, 18 Feb 2003 00:34:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: 2.5.62: Cross-building broken
Message-ID: <20030218003410.A27937@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cross-building ARM from HPPA:

$ make config CROSS_COMPILE=/home/rmk/bin/arm-linux- ARCH=arm
make: Entering directory `/home/rmk/v2.5/linux-rpc'
make -f scripts/Makefile.build obj=scripts
  gcc -Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall
 -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common
 -mshort-load-bytes -msoft-float -Wa,-mno-fpu -Uarm -nostdinc -iwithprefix
 include    -DKBUILD_BASENAME=empty -DKBUILD_MODNAME=empty -c -o
 scripts/empty.o scripts/empty.c
make: Leaving directory `/home/rmk/v2.5/linux-rpc'
cc1: Invalid option `short-load-bytes'
make[1]: *** [scripts/empty.o] Error 1
make: *** [scripts] Error 2

We seem to be using the wrong compiler here, or the wrong CFLAGS.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

