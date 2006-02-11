Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWBKVwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBKVwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWBKVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:52:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1294 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750723AbWBKVwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:52:40 -0500
Date: Sat, 11 Feb 2006 22:52:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: old patches in -mm
Message-ID: <20060211215238.GF30922@stusta.de>
References: <43EE415F.2000805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EE415F.2000805@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 08:56:15PM +0100, Xose Vazquez Perez wrote:
> hi,
> 
> There are 35 patches(not included reiser4 and post-halloween-doc) older
> than 2 months that still are not in mainline. Forgotten or experimental ?
>...
> acx1xx-allow-modular-build.patch
> acx1xx-wireless-driver-spy_offset-went-away.patch
> acx1xx-wireless-driver-usb-is-bust.patch
> acx-should-select-not-depend-on-fw_loader.patch
> acx-update-2.patch
> acx-update.patch

They do all depend on acx1xx-wireless-driver.patch.

>...
> dlm-build-fix-2.patch
> dlm-build-fix.patch
> dlm-communication-fix-lowcomms-race.patch
> dlm-core-locking-resend-lookups.patch
> dlm-device-interface-dlm-force-unlock.patch
> dlm-device-interface-fix-device-refcount.patch
> dlm-recovery-clear-new_master-flag.patch
> dlm-recovery-make-code-static.patch
> dlm-use-configfs-fix-2.patch
> dlm-use-configfs-fix.patch

They do all depend on DLM which is only in -mm.

>...
> drivers-net-wireless-tiacx-add-missing-include-linux-vmallocha.patch

Depends on acx1xx-wireless-driver.patch.

> export-file_ra_state_init-again.patch

This is currently not even used in -mm - it should be dropped since 
recreating this patch is trivial.

> fbdev-update-framebuffer-feature-list.patch
> firestream-warnings.patch
> fs-asfs-make-code-static.patch

Depends on asfs-filesystem-driver.patch.

>...
> remove-checkconfigpl.patch

This patch is broken - the purpose of this patch was to remove 
checkconfig.pl, but it seems the part to remove checkconfig.pl was lost 
somewhere through Andrew's scripts.

> slab-cache-shrinker-statistics-fix.patch

Bug fix that should go into 2.6.16 - but a static inline in slab.h would 
be the better solution.

> tiacx-usb_driver-build-fix.patch

Depends on acx1xx-wireless-driver.patch.

> -thanks-

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

