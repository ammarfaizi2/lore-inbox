Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVAMXBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVAMXBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVAMW6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:58:35 -0500
Received: from smtp0.libero.it ([193.70.192.33]:4771 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S261804AbVAMWxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:53:31 -0500
Message-ID: <41E6525E.6030200@gmail.com>
Date: Thu, 13 Jan 2005 11:50:06 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: dri-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] Compile bug in Direct Rendering Manager (kernel 2.6.11-rc1)
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

While compiling kernel 2.6.11-rc1, make exits with a lot of errors concerning
Direct Rendering Manager. Here is some info I've grabbed:

[...]
CC [M]  drivers/char/drm/gamma_drv.o
drivers/char/drm/gamma_drv.c:39:22: drm_auth.h: No such file or directory
drivers/char/drm/gamma_drv.c:40:28: drm_agpsupport.h: No such file or directory
drivers/char/drm/gamma_drv.c:41:22: drm_bufs.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:42:
drivers/char/drm/gamma_context.h: In function `gamma_context_switch_complete':
drivers/char/drm/gamma_context.h:193: error: structure has no member named
`next_buffer'
drivers/char/drm/gamma_context.h:193: error: structure has no member named
`next_buffer'
drivers/char/drm/gamma_context.h:194: warning: implicit declaration of function
`gamma_lock_free'
drivers/char/drm/gamma_context.h: In function `gamma_alloc_queue':
drivers/char/drm/gamma_context.h:267: warning: implicit declaration of function
`gamma_alloc'
drivers/char/drm/gamma_context.h:267: warning: assignment makes pointer from
integer without a cast
drivers/char/drm/gamma_context.h:278: warning: implicit declaration of function
`gamma_realloc'
drivers/char/drm/gamma_context.h:281: warning: assignment makes pointer from
integer without a cast
drivers/char/drm/gamma_context.h: In function `gamma_rmctx':
drivers/char/drm/gamma_context.h:475: warning: implicit declaration of function
`gamma_free_buffer'
drivers/char/drm/gamma_drv.c:43:21: drm_dma.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:44:
drivers/char/drm/gamma_old_dma.h: In function `gamma_clear_next_buffer':
drivers/char/drm/gamma_old_dma.h:40: error: structure has no member named
`next_buffer'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:41: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:42: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h:44: error: structure has no member named
`next_queue'
drivers/char/drm/gamma_old_dma.h: In function `gamma_dma_enqueue':
drivers/char/drm/gamma_old_dma.h:173: warning: assignment makes pointer from
integer without a cast
drivers/char/drm/gamma_old_dma.h:233: warning: implicit declaration of function
`gamma_free'
drivers/char/drm/gamma_old_dma.h: In function `gamma_dma_get_buffers':
drivers/char/drm/gamma_old_dma.h:281: warning: implicit declaration of function
`gamma_order'
drivers/char/drm/gamma_drv.c:45:26: drm_drawable.h: No such file or directory
drivers/char/drm/gamma_drv.c:46:21: drm_drv.h: No such file or directory
drivers/char/drm/gamma_drv.c:48:22: drm_fops.h: No such file or directory
drivers/char/drm/gamma_drv.c:49:22: drm_init.h: No such file or directory
drivers/char/drm/gamma_drv.c:50:23: drm_ioctl.h: No such file or directory
drivers/char/drm/gamma_drv.c:51:21: drm_irq.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:52:
drivers/char/drm/gamma_lists.h: In function `gamma_waitlist_create':
drivers/char/drm/gamma_lists.h:40: warning: assignment makes pointer from
integer without a cast
drivers/char/drm/gamma_drv.c:53:22: drm_lock.h: No such file or directory
In file included from drivers/char/drm/gamma_drv.c:55:
drivers/char/drm/drm_memory.h: At top level:
drivers/char/drm/drm_memory.h:67: error: redefinition of `drm_lookup_map'
drivers/char/drm/drm_memory.h:67: error: `drm_lookup_map' previously defined here
drivers/char/drm/drm_memory.h:85: error: redefinition of `agp_remap'
drivers/char/drm/drm_memory.h:85: error: `agp_remap' previously defined here
drivers/char/drm/drm_memory.h:125: error: redefinition of `drm_follow_page'
drivers/char/drm/drm_memory.h:125: error: `drm_follow_page' previously defined here
drivers/char/drm/drm_memory.h:153: error: redefinition of `drm_ioremap'
drivers/char/drm/drm_memory.h:153: error: `drm_ioremap' previously defined here
drivers/char/drm/drm_memory.h:165: error: redefinition of `drm_ioremap_nocache'
drivers/char/drm/drm_memory.h:165: error: `drm_ioremap_nocache' previously
defined here
drivers/char/drm/drm_memory.h:176: error: redefinition of `drm_ioremapfree'
drivers/char/drm/drm_memory.h:176: error: `drm_ioremapfree' previously defined here
drivers/char/drm/gamma_drv.c:56:22: drm_proc.h: No such file or directory
drivers/char/drm/gamma_drv.c:57:20: drm_vm.h: No such file or directory
drivers/char/drm/gamma_drv.c:58:22: drm_stub.h: No such file or directory
drivers/char/drm/gamma_drv.c:59:25: drm_scatter.h: No such file or directory
make[3]: *** [drivers/char/drm/gamma_drv.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

[...]
CONFIG_DRM=m
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
[...]

Linux gandalf 2.6.10 #2 Wed Jan 12 18:32:56 CET 2005 i686 GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Kbd                    [opzione...]
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   042



Regards,

					Luca

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQEVAwUBQeZSXhZrwl7j21nOAQI4WQf/VxwPkv0nh0nXIDqxflIKHbcT3WM6z/Lu
7bV765QOnvDs+YNLrHyWNoePOP5MeDozNxSDbba9GKJUoiGoFiAhNfgqJHXYVFjq
TDpEnVVF1gREsl2IzJv7EI1rqaSn86vOwZzqgEudxnwyOWSlnlVKZ8ux0TnqhWL7
KVJ2xKqN8vx1k1CGg7o//r2/YZUFUbsBo+FHfsPumbdjYyQokK4tUGBsti+etOuh
DKTw39pdv9n2GfTIzQWy7AhvNWG2I8n9mT/iGsz4crBaemI4BwwhjlqMr5yQGVL0
UoMuRVVOzqjFnf0B3Mj6E7pMlYk9Rv3Q+MRekFVtfJyhu762tLKDZg==
=J7gM
-----END PGP SIGNATURE-----

