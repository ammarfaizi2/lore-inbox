Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbSJBVSv>; Wed, 2 Oct 2002 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbSJBVRs>; Wed, 2 Oct 2002 17:17:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32275 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262604AbSJBVR2>;
	Wed, 2 Oct 2002 17:17:28 -0400
Date: Wed, 2 Oct 2002 23:22:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: tim <tim@holymonkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: include/asm/irq_vectors.h not found
Message-ID: <20021002232220.A2244@mars.ravnborg.org>
Mail-Followup-To: tim <tim@holymonkey.com>,
	linux-kernel@vger.kernel.org
References: <20021002135939.129a6a5f.tim@holymonkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021002135939.129a6a5f.tim@holymonkey.com>; from tim@holymonkey.com on Wed, Oct 02, 2002 at 01:59:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 01:59:39PM -0700, tim wrote:
> when installing dri drivers for my gfx card (r200-20020927-linux.i386) i get the following error during kernel module compilation:
> 
> cc -O2 -Wall -Wwrite-strings -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wnested-externs -Wpointer-arith -D__KERNEL__ -DMODULE -fomit-frame-pointer -DCONFIG_AGP -DCONFIG_AGP_MODULE -DCONFIG_DRM_SIS -DMODVERSIONS -include /lib/modules/2.5.39/build/include/linux/modversions.h -DEXPORT_SYMTAB -I/lib/modules/2.5.39/build/include -c radeon_drv.c -o radeon_drv.o
> In file included from /lib/modules/2.5.39/build/include/linux/irq.h:19,
>                  from /lib/modules/2.5.39/build/include/asm/hardirq.h:6,
>                  from /lib/modules/2.5.39/build/include/linux/interrupt.h:44,
>                  from drm_os_linux.h:3,
>                  from drmP.h:75,
>                  from radeon_drv.c:32:
> /lib/modules/2.5.39/build/include/asm/irq.h:16: irq_vectors.h: No such file or directory
> make: *** [radeon_drv.o] Error 1

Try changing the line in irq.h from:
#include "irq_vectors.h"
to
#include <irq_vectors.h>

This should make it locate the file in arch/i386/mach-generic/irq_vectors.h

	Sam
