Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292893AbSB0XQ7>; Wed, 27 Feb 2002 18:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293044AbSB0XQn>; Wed, 27 Feb 2002 18:16:43 -0500
Received: from www.transvirtual.com ([206.14.214.140]:48144 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293048AbSB0XPx>; Wed, 27 Feb 2002 18:15:53 -0500
Date: Wed, 27 Feb 2002 15:15:35 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Miles Lane <miles@megapathdsl.net>
cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.5-dj2 -- serial.c:649: too many arguments to function
 `handle_sysrq'
In-Reply-To: <3C7D5ED5.2030500@megapathdsl.net>
Message-ID: <Pine.LNX.4.10.10202271506460.13029-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 27 Feb 2002, Miles Lane wrote:

> 2.5.5-dj2 + nls.patch + migrate.diff + console_8.diff + roberto 
> nibaldo's patches:
> 
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -pipe -mpreferred-stack-boundary=2 -march=athlon 
> -DKBUILD_BASENAME=serial  -DEXPORT_SYMTAB -c serial.c
> serial.c: In function `receive_chars':
> serial.c:649: too many arguments to function `handle_sysrq'
> make[3]: *** [serial.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/drivers/char'

My fault :-( I cleaned up sysrq a little bit in relationship to the VT
system. The change effected more drivers than I thought. Try
console_8.diff again. I put a new version of the patch up. 

http://www.transvirtual.com/~jsimmons/console/console_8.diff

I'm glad people are testing it out before it goes into the dj tree. I will
post other patches before I send them in to be included into the dj tre
since now we are getting into changes that effect alot of drivers. 

For example fg_console will be going away very soon!!!! This willeffect
alot of drivers.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

