Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966509AbWKTTcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966509AbWKTTcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966506AbWKTTcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:32:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21156 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966493AbWKTTcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:32:04 -0500
Date: Mon, 20 Nov 2006 19:31:36 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
cc: Richard Purdie <rpurdie@rpsys.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
       Lennart Poettering <mzxreary@0pointer.de>,
       Andriy Skulysh <askulysh@image.kiev.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
       Holger Macht <hmacht@suse.de>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
In-Reply-To: <20061110000829.GA9021@khazad-dum.debian.net>
Message-ID: <Pine.LNX.4.64.0611201928310.17639@pentafluge.infradead.org>
References: <20061105225429.GE14295@khazad-dum.debian.net>
 <1162773394.5473.18.camel@localhost.localdomain> <20061110000829.GA9021@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following in-tree (latest linux-2.6 git tree) drivers are desktop/laptop
> devices and likely do not want the "dim and power off backlight on
> backlight_device_unregister" behavior:
> 
> drivers/video/aty/*
> drivers/video/riva/fbdev.c
> drivers/video/nvidia/nv_backlight.c
> drivers/misc/msi-laptop.c

...
 
> I have CC'ed the relevant people (please forgive me any ommissions) for the
> drivers listed above, so they can chime in if their driver should retain the
> "dim and power off backlight on backlight_device_unregister" behaviour.

Hm. In the case of some drivers the hardware state on x86 is set back to 
text mode in some cases. So do we in that case dim the backlight?

