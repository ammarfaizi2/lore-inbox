Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSAPS0q>; Wed, 16 Jan 2002 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286188AbSAPS0h>; Wed, 16 Jan 2002 13:26:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:13586 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286215AbSAPS0T>; Wed, 16 Jan 2002 13:26:19 -0500
Date: Wed, 16 Jan 2002 15:13:23 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile error in 2.4.18-pre3 (radeonfb.c as module)
In-Reply-To: <200201160718.g0G7IAE09882@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.21.0201161512200.27966-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've included the missing defines on radeonfb.h on my tree.

-pre5 will have that fixed. 

On Wed, 16 Jan 2002, Denis Vlasenko wrote:

> make -C video modules
> make[2]: Entering directory `/.share/usr/src/linux-2.4.18-pre3/drivers/video'
> gcc -D__KERNEL__ -I/.share/usr/src/linux-2.4.18-pre3/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i386 -DMODULE -DMODVERSIONS -include 
> /.share/usr/src/linux-2.4.18-pre3/include/linux/modversions.h  
> -DKBUILD_BASENAME=radeonfb  -c -o radeonfb.o radeonfb.c
> radeonfb.c: In function `radeon_save_state':
> radeonfb.c:2283: `TMDS_TRANSMITTER_CNTL' undeclared (first use in this 
> function)
> radeonfb.c:2283: (Each undeclared identifier is reported only once
> radeonfb.c:2283: for each function it appears in.)
> radeonfb.c: In function `radeon_load_video_mode':
> radeonfb.c:2560: `TMDS_RAN_PAT_RST' undeclared (first use in this function)
> radeonfb.c:2561: `ICHCSEL' undeclared (first use in this function)
> radeonfb.c:2561: `TMDS_PLLRST' undeclared (first use in this function)
> radeonfb.c: In function `radeon_write_mode':
> radeonfb.c:2650: `TMDS_TRANSMITTER_CNTL' undeclared (first use in this 
> function)
> radeonfb.c:2655: `LVDS_STATE_MASK' undeclared (first use in this function)
> radeonfb.c: At top level:
> radeonfb.c:2957: warning: `fbcon_radeon8' defined but not used
> make[2]: *** [radeonfb.o] Error 1
> make[2]: Leaving directory `/.share/usr/src/linux-2.4.18-pre3/drivers/video'
> make[1]: *** [_modsubdir_video] Error 2
> make[1]: Leaving directory `/.share/usr/src/linux-2.4.18-pre3/drivers'
> make: *** [_mod_drivers] Error 2

