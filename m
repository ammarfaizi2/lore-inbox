Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSKNRdd>; Thu, 14 Nov 2002 12:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSKNRdd>; Thu, 14 Nov 2002 12:33:33 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265063AbSKNRdc>;
	Thu, 14 Nov 2002 12:33:32 -0500
Date: Thu, 14 Nov 2002 09:40:06 -0800
From: Dave Olien <dmo@osdl.org>
To: Adam Voigt <adam@cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 "DAC960" Compile Error
Message-ID: <20021114094005.A22605@acpi.pdx.osdl.net>
References: <1037293958.16834.12.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037293958.16834.12.camel@beowulf.cryptocomm.com>; from adam@cryptocomm.com on Thu, Nov 14, 2002 at 12:12:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can get a working DAC960 driver at

	http://www.osdl.org/archive/dmo

There are patches here for numerous versions of Linux.

On Thu, Nov 14, 2002 at 12:12:38PM -0500, Adam Voigt wrote:
> Kernel being Compiled: 2.5.47
> Distro: Redhat 8
> GCC: 3.2-7
> 
> 2.5.47 Compile with mostly default options, stops compiling in the
> make phase with:
> 
> gcc -Wp,-MD,drivers/block/.DAC960.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DMODULE -include include/linux/modversions.h  
> -DKBUILD_BASENAME=DAC960   -c -o drivers/block/DAC960.o
> drivers/block/DAC960.c
> In file included from drivers/block/DAC960.c:49:
> drivers/block/DAC960.h:2572:2: #error I am a non-portable driver, please
> convert me to use the Documentation/DMA-mapping.txt interfaces
> In file included from drivers/block/DAC960.c:49:
> drivers/block/DAC960.h: In function `DAC960_BA_WriteHardwareMailbox':
> drivers/block/DAC960.h:2846: warning: implicit declaration of function
> `Virtual_to_Bus32'
> drivers/block/DAC960.c: In function `DAC960_V2_GeneralInfo':
> drivers/block/DAC960.c:656: warning: implicit declaration of function
> `Virtual_to_Bus64'
> drivers/block/DAC960.c: In function `DAC960_V1_ProcessCompletedCommand':
> drivers/block/DAC960.c:3102: warning: implicit declaration of function
> `Bus32_to_Virtual'
> drivers/block/DAC960.c:3102: warning: passing arg 2 of
> `__constant_memcpy' makes pointer from integer without a cast
> drivers/block/DAC960.c:3102: warning: passing arg 2 of `__memcpy' makes
> pointer
> from integer without a cast
> drivers/block/DAC960.c:3107: warning: passing arg 2 of
> `__constant_memcpy' makes pointer from integer without a cast
> drivers/block/DAC960.c:3107: warning: passing arg 2 of `__memcpy' makes
> pointer
> from integer without a cast
> drivers/block/DAC960.c: In function `DAC960_P_InterruptHandler':
> drivers/block/DAC960.c:5038: warning: passing arg 1 of
> `DAC960_P_To_PD_TranslateEnquiry' makes pointer from integer without a
> cast
> drivers/block/DAC960.c:5044: warning: passing arg 1 of
> `DAC960_P_To_PD_TranslateDeviceState' makes pointer from integer without
> a cast
> make[2]: *** [drivers/block/DAC960.o] Error 1
> make[1]: *** [drivers/block] Error 2
> make: *** [drivers] Error 2
> 
> -- 
> Adam Voigt (adam@cryptocomm.com)
> The Cryptocomm Group
> My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc


