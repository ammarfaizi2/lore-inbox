Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268173AbTBNDrT>; Thu, 13 Feb 2003 22:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268174AbTBNDrT>; Thu, 13 Feb 2003 22:47:19 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:21725 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S268173AbTBNDrS>; Thu, 13 Feb 2003 22:47:18 -0500
Message-ID: <3E4C68F5.8070208@bogonomicon.net>
Date: Thu, 13 Feb 2003 21:56:37 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4-ac4 make xconfig fails
References: <3E4C6314.4070105@bellini.mit.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also see this, Debian testing based system, but I usually menuconfig 
myself.

Looks like a parameter was forgotten.  I see a number of dep_tristate 
lines with three parameters and the one it is choking on has only two.

dep_tristate '  ATI Radeon' CONFIG_DRM_RADEON     <<< chokes this line
dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP


ghugh Song wrote:
> This is what I get on SuSE-8.1 box:
> 
> # make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.21-pre4-ac4/scripts'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
> tkparse.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o 
> tkcond.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o 
> tkgen.c
> gcc -o tkparse tkparse.o tkcond.o tkgen.o
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/char/drm/Config.in: 11: can't handle 
> dep_bool/dep_mbool/dep_tristate condition
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.21-pre4-ac4/scripts'
> make: *** [xconfig] Error 2
> 
> 
> 
> Apparently, some people successfully went throught this procedure.
> 
> Best regards,
> 
> G. Hugh Song
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


