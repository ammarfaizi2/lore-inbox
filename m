Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVACHks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVACHks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 02:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVACHks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 02:40:48 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:61579 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S261215AbVACHkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 02:40:42 -0500
Date: Mon, 3 Jan 2005 03:51:05 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.6.{9,10}: VIA DRM undefined symbols
Message-ID: <20050103035105.GA7231@hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just tried to use the kernel via module for my CLE266 and get a
whole load of undefined symbols:


Jan  3 03:08:11 mercury kernel: Uniform CD-ROM driver Revision: 3.20
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_sg_alloc
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_sg_free
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_irq_by_busid
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_control
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_driver_register_fns
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_sg_cleanup
Jan  3 03:12:48 mercury kernel: via: Unknown symbol DRM_FIND_MAP
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_wait_vblank
Jan  3 03:12:48 mercury kernel: via: Unknown symbol viadrv_irq_uninstall

Looking back, this seems to have appeared in 2.6.9 with the introduction
of the capabilities bitmask. The via driver appears not to have been
converted.

I am still trying to understand the new structure. What else does the
missing viadrv_driver_register_fns need to set apart from
dev->driver_features?

Thanks

Mark
