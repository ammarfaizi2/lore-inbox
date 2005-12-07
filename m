Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVLGUKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVLGUKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVLGUKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:10:52 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:38093 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750832AbVLGUKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:10:51 -0500
Message-ID: <4397418E.3070400@droids-corp.org>
Date: Wed, 07 Dec 2005 21:09:50 +0100
From: Olivier MATZ <zer0@droids-corp.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
References: <4395F405.9010107@droids-corp.org> <200512062211.40142.arnd@arndb.de> <43971BD5.6040601@droids-corp.org> <20051207191030.GA7585@mars.ravnborg.org>
In-Reply-To: <20051207191030.GA7585@mars.ravnborg.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> If you look at the commandline passed to gcc you will notice -include
> include/linux/autoconf.h which tell gcc to pull in autoconf.h.
> So it is no longer required to include config.h.

I'm not sure. On my 2.6.14.3, this is a compilation line :

gcc -m32 -Wp,-MD,kernel/.sys.o.d  -nostdinc -isystem
/usr/lib/gcc-lib/i486-linux-gnu/3.3.6/include -D__KERNEL__ -Iinclude
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -ffreestanding -Os     -fno-omit-frame-pointer
-fno-optimize-sibling-calls -g -pipe -msoft-float
-mpreferred-stack-boundary=2  -march=i686 -mregparm=3
-Iinclude/asm-i386/mach-default      -DKBUILD_BASENAME=sys
-DKBUILD_MODNAME=sys -c -o kernel/.tmp_sys.o kernel/sys.c

Moreover, if I try to compile a C file which only define a variable and
assign it to a CONFIG_XXX, it doesn't work. Did I do something wrong ?

Olivier
