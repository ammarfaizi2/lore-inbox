Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSLKGu2>; Wed, 11 Dec 2002 01:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSLKGu1>; Wed, 11 Dec 2002 01:50:27 -0500
Received: from mailnw.centurytel.net ([209.206.160.237]:44422 "EHLO
	mailnw.centurytel.net") by vger.kernel.org with ESMTP
	id <S266964AbSLKGu0>; Wed, 11 Dec 2002 01:50:26 -0500
Message-ID: <3DF752B9.5020201@centurytel.net>
Date: Wed, 11 Dec 2002 07:59:05 -0700
From: eric lin <fsshl@centurytel.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Weir <rweir@softhome.net>
CC: debian-user@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: from intel onboard Lan and audo to install 2.4.50
References: <3DF549BC.8050806@centurytel.net> <20021210152801.GB25341@thebox.home.local>
In-Reply-To: <20021210152801.GB25341@thebox.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>>some say newest kernel 2.5.50 can solve all above hardware(intel board 
>>on board LAN and audio ) problem, so I download full tar.gz, choose what 
>>my hardware fit
>>make install
> 
> 
> Use make-kpkg in the kernel-package package.

I did,
but it terminate with error

  gcc -Wp,-MD,drivers/pci/.quirks.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-Iarch/i386/mach-generic -Iarch/i386/mach-defaults -nostdinc 
-iwithprefix include    -DKBUILD_BASENAME=quirks -DKBUILD_MODNAME=quirks 
   -c -o drivers/pci/quirks.o drivers/pci/quirks.c
drivers/pci/quirks.c: In function `quirk_ioapic_rmw':
drivers/pci/quirks.c:354: `sis_apic_bug' undeclared (first use in this 
function)
drivers/pci/quirks.c:354: (Each undeclared identifier is reported only once
drivers/pci/quirks.c:354: for each function it appears in.)
make[3]: *** [drivers/pci/quirks.o] Error 1
make[2]: *** [drivers/pci] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/home/fsshl/linux-2.5.50'
make: *** [stamp-build] Error 2
www:/home/fsshl/linux-2.5.50#

if someone know it be modifed, please drop me a note where I can get the
fixed source.
it's on 2.5.50.ac-1 patched 2.5.50 from kernel.org
hihgly apprecaite
> 
> 
>>error happen, I justify one of it, first one, in 
>>linux-2.4.50/include/asm-i386/io_apic.h
>>containing sis_apic_bug  not include its .h file
> 
> 
> As Colin already said, if you can't handle this, you shouldn't be using
> 2.5 kernels.  Some of them don't build, and many (most) have serious
> bugs that could cause data loss.  If you want to go ahead with this,
> you'll have to get help from lkml, but be prepared to be thoroughly
> roasted.
> 
> 
>>also I have difficult(unsuccess) patch 2.5.50
>>I did
>>gzip -cd patch-2.5.50-ac1.gz  | patch -p0
> 
>                                           ^
> s/0/1/                                          
> 
> -rob


-- 
Sincere Eric
www.linuxspice.com
linux pc for sale

