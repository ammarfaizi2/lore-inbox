Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267414AbUIFDmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267414AbUIFDmP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUIFDmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:42:14 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:60830 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267414AbUIFDmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:42:12 -0400
Date: Mon, 6 Sep 2004 04:42:11 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] DRM remove DMA/IRQ macros..
In-Reply-To: <20040905203622.32f75496.davem@davemloft.net>
Message-ID: <Pine.LNX.4.58.0409060440320.22266@skynet>
References: <Pine.LNX.4.58.0409051015570.14009@skynet>
 <20040905203622.32f75496.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Dave, I'll look into it, I've no way to build or test the ffb (I'm
not even sure the user space code works anymore), so I rely on feedback
for it from others..

Dave.

On Sun, 5 Sep 2004, David S. Miller wrote:

> On Sun, 5 Sep 2004 10:21:34 +0100 (IST)
> Dave Airlie <airlied@linux.ie> wrote:
>
> > 	The attached patch dumps the DMA/IRQ macros, I've realised I one
> > more to go after this for some macros from the ffb driver,
>
>
> Speaking of the ffb driver, you broke the build of
> it pretty seriously 2 days ago, please fix.  Thanks.
>
> drivers/char/drm/ffb_drv.c: At top level:
> drivers/char/drm/ffb_drv.c:296: warning: `ffb_presetup' defined but not used
> drivers/char/drm/ffb_drv.c:179: warning: `ffb_count_card_instances' defined but not used
>   CC [M]  drivers/char/drm/ffb_context.o
> drivers/char/drm/ffb_context.c: In function `ffb_driver_presetup':
> drivers/char/drm/ffb_context.c:559: warning: implicit declaration of function `ffb_presetup'
> drivers/char/drm/ffb_context.c:560: error: `_ret' undeclared (first use in this function)
> drivers/char/drm/ffb_context.c:560: error: (Each undeclared identifier is reported only once
> drivers/char/drm/ffb_context.c:560: error: for each function it appears in.)
> drivers/char/drm/ffb_context.c: In function `ffb_driver_postcleanup':
> drivers/char/drm/ffb_context.c:570: error: `ffb_position' undeclared (first use in this function)
> drivers/char/drm/ffb_context.c: In function `ffb_driver_kernel_context_switch_unlock':
> drivers/char/drm/ffb_context.c:580: error: `lock' undeclared (first use in this function)
> drivers/char/drm/ffb_context.c: At top level:
> drivers/char/drm/ffb_context.c:591: warning: static declaration for `ffb_driver_register_fns' follows non-static
> drivers/char/drm/ffb_context.c: In function `ffb_driver_register_fns':
> drivers/char/drm/ffb_context.c:593: warning: assignment from incompatible pointer type
> drivers/char/drm/ffb_context.c:596: warning: assignment from incompatible pointer type
> drivers/char/drm/ffb_context.c: At top level:
> drivers/char/drm/ffb_context.c:591: warning: `ffb_driver_register_fns' defined but not used
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

