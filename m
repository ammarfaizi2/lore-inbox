Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311455AbSCNA2t>; Wed, 13 Mar 2002 19:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311457AbSCNA16>; Wed, 13 Mar 2002 19:27:58 -0500
Received: from moutvdomng1.kundenserver.de ([212.227.126.181]:22006 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S311449AbSCNA0Z>; Wed, 13 Mar 2002 19:26:25 -0500
Message-ID: <3C8FEE05.597A84C@ngforever.de>
Date: Wed, 13 Mar 2002 17:25:41 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: A Guy Called Tyketto <tyketto@wizard.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: make xconfig croaks in with sound/core/Config.in
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Might be interesting to know what's already in the kconfig.tk - you
might find the file written up to the crashing point

Thunder

A Guy Called Tyketto wrote:

>         Short, but sweet:
> 
> root@bellicha:/usr/src/linux# head -10 Makefile
> VERSION = 2
> PATCHLEVEL = 5
> SUBLEVEL = 6
> EXTRAVERSION =
> 
> KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
> 
> ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
> s/arm.*/arm/ -e s/sa110/arm/)
> KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//")
> 
> root@bellicha:/usr/src/linux# make xconfig &
> [2] 32520
> root@bellicha:/usr/src/linux# rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.5.5/scripts'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
> tkparse.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
> gcc -o tkparse tkparse.o tkcond.o tkgen.o
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate condition
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.5/scripts'
> make: *** [xconfig] Error 2
> 
> [2]+  Exit 2                  make xconfig
> 
>                                                         BL.
> 


-- 
begin-base64 755 -
IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
====
Extract this and see what will happen if you execute my
signature. Just save it to file and do a
> uudecode $file | perl
