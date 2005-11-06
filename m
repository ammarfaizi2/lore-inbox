Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVKFATX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVKFATX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVKFATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:19:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:62686 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932235AbVKFATW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:19:22 -0500
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20051105234938.GA18608@hansmi.ch>
References: <20051105234938.GA18608@hansmi.ch>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 11:17:44 +1100
Message-Id: <1131236265.5229.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-06 at 00:49 +0100, Michael Hanselmann wrote:
> This patch adds the framebuffer mode required for an Apple PowerBook G4
> Titanium.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> ---
> --- linux-2.6.14/drivers/video/modedb.c.orig	2005-11-05 22:29:02.000000000 +0100
> +++ linux-2.6.14/drivers/video/modedb.c	2005-11-05 22:31:15.000000000 +0100
> @@ -251,6 +251,10 @@ static const struct fb_videomode modedb[
>  	NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
>  	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>  	FB_VMODE_NONINTERLACED
> +    }, {
> +	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
> +	"mac21", 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
> +	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
>      },
>  };

Please, re-do it without the "mac21" name, just leave NULL there.

Ben.


