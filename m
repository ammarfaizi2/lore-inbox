Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUDSTJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUDSTJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 15:09:23 -0400
Received: from mta.hosting-seguridad.com ([63.246.136.14]:35817 "EHLO
	mta.hosting-seguridad.com") by vger.kernel.org with ESMTP
	id S261725AbUDSTJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 15:09:19 -0400
From: Roman Medina <roman@rs-labs.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.26 doesn't compile? ("error: `__cmpxchg' previously defined here")
Date: Mon, 19 Apr 2004 21:09:19 +0200
Message-ID: <lq8880hq37q1b4ffpmn7idvj8gcqps5iqo@4ax.com>
References: <31145.194.224.100.28.1082362588.squirrel@194.224.100.28> <20040419102710.06bcdf9a.rddunlap@osdl.org>
In-Reply-To: <20040419102710.06bcdf9a.rddunlap@osdl.org>
X-Mailer: Forte Agent 2.0/32.646
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 10:27:10 -0700, you wrote:

>| make[3]: Entering directory `/usr/src/linux-2.4.26/drivers/char/drm'
>| gcc -D__KERNEL__ -I/usr/src/linux-2.4.26/include -Wall -Wstrict-prototypes
>| -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
>| -pipe -mpreferred-stack-boundary=2 -march=i386 -DMODULE -DMODVERSIONS
>| -include /usr/src/linux-2.4.26/include/linux/modversions.h  -nostdinc
>| -iwithprefix include -DKBUILD_BASENAME=gamma_drv  -c -o gamma_drv.o
>| gamma_drv.c
>| In file included from gamma_drv.c:34:
>| drmP.h:180: error: redefinition of `__cmpxchg'
>| /usr/src/linux-2.4.26/include/asm/system.h:245: error: `__cmpxchg'
>| previously defined here
>| make[3]: *** [gamma_drv.o] Error 1
>| make[3]: Leaving directory `/usr/src/linux-2.4.26/drivers/char/drm'
>| make[2]: *** [_modsubdir_drm] Error 2
>| make[2]: Leaving directory `/usr/src/linux-2.4.26/drivers/char'
>| make[1]: *** [_modsubdir_char] Error 2
>| make[1]: Leaving directory `/usr/src/linux-2.4.26/drivers'
>| make: *** [_mod_drivers] Error 2
>| 
>| Any ideas?
>
>Sure, build for more than CONFIG_M386=y.
>I.e., build for a Pentium III etc. and it should work.

Thanks a lot, Randy. It worked :-) But I'm wondering why the same
config compiled perfectly on 2.4.25 and backwards. Which changes
affect this issue?

 Saludos,
 --Roman

--
PGP Fingerprint:
09BB EFCD 21ED 4E79 25FB  29E1 E47F 8A7D EAD5 6742
[Key ID: 0xEAD56742. Available at KeyServ]

