Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282821AbRLGJXZ>; Fri, 7 Dec 2001 04:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282819AbRLGJXP>; Fri, 7 Dec 2001 04:23:15 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:36035 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S282821AbRLGJW5>; Fri, 7 Dec 2001 04:22:57 -0500
Subject: Re: make xconfig fails
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C1068BB.6070100@xmission.com>
In-Reply-To: <3C1068BB.6070100@xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 10:22:06 +0100
Message-Id: <1007716926.742.0.camel@nc1701d>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember this happening when DISPLAY variable is not set or X11 server
doesn't allow connections.
(run 'xhost +localhost' as the user of the display, and "export
DISPLAY="localhost:0.0"' as root)

George

On Fri, 2001-12-07 at 07:59, Ben Carrell wrote:
> Is anyone else experiencing errors like the below when trying to run 
> 'make xconfig'.   I have tcl/tk install fine, I'm not sure what else to 
> check...please help :)
> 
> root@london:/usr/src/linux# make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.16/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> echo "set defaults \"arch/i386/defconfig\"" >> kconfig.tk
> echo "set ARCH \"i386\"" >> kconfig.tk
> cat tail.tk >> kconfig.tk
> chmod 755 kconfig.tk
> make[1]: Leaving directory `/usr/src/linux-2.4.16/scripts'
> wish -f scripts/kconfig.tk
> Application initialization failed: unknown color name "Black"
> Error in startup script: can't invoke "button" command: application has 
> been destroyed
>     while executing
> "button .ref"
>     (file "scripts/kconfig.tk" line 51)
> make: *** [xconfig] Error 1
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen Sawinski
Max-Planck-Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-309
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 848
Mobile: +49-171-532 5302

