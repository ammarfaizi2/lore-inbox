Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbTBRNln>; Tue, 18 Feb 2003 08:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBRNln>; Tue, 18 Feb 2003 08:41:43 -0500
Received: from [81.2.122.30] ([81.2.122.30]:52741 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267805AbTBRNll>;
	Tue, 18 Feb 2003 08:41:41 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302181349.h1IDnX6w001233@darkstar.example.net>
Subject: Re: 2.5.62: Cross-building broken
To: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2003 13:49:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de
In-Reply-To: <20030218003410.A27937@flint.arm.linux.org.uk> from "Russell King" at Feb 18, 2003 12:34:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cross-building ARM from HPPA:
> 
> $ make config CROSS_COMPILE=/home/rmk/bin/arm-linux- ARCH=arm
> make: Entering directory `/home/rmk/v2.5/linux-rpc'
> make -f scripts/Makefile.build obj=scripts
>   gcc -Wp,-MD,scripts/.empty.o.d -D__KERNEL__ -Iinclude -Wall
>  -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common
>  -mshort-load-bytes -msoft-float -Wa,-mno-fpu -Uarm -nostdinc -iwithprefix
>  include    -DKBUILD_BASENAME=empty -DKBUILD_MODNAME=empty -c -o
>  scripts/empty.o scripts/empty.c
> make: Leaving directory `/home/rmk/v2.5/linux-rpc'
> cc1: Invalid option `short-load-bytes'
> make[1]: *** [scripts/empty.o] Error 1
> make: *** [scripts] Error 2
> 
> We seem to be using the wrong compiler here, or the wrong CFLAGS.

Hmmm, cross compiling for Sparc works:

make config CROSS_COMPILE=/usr/local/bin/sparc-linux- ARCH=sparc
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/kconfig scripts/kconfig/conf
make[1]: `scripts/kconfig/conf' is up to date.
./scripts/kconfig/conf arch/sparc/Kconfig
#
# using defaults found in arch/sparc/defconfig
#
*
* Linux Kernel Configuration
*
*
* Code maturity level options
*
Prompt for development and/or incomplete code/drivers (EXPERIMENTAL) [Y/n/?] 

John.
