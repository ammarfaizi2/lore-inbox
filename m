Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVAXLRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVAXLRT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 06:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVAXLRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:17:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37385 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261491AbVAXLRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:17:15 -0500
Date: Mon, 24 Jan 2005 12:17:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc2-mm1: v4l-saa7134-module compile error
Message-ID: <20050124111713.GF3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc1-mm2:
>...
> +v4l-saa7134-module.patch
> 
>  v4l updates.
>...

This patch broke compilation with CONFIG_MODULES=n:

<--  snip  -->

...
  CC      drivers/media/video/saa7134/saa7134-core.o
drivers/media/video/saa7134/saa7134-core.c: In function `pending_call':
drivers/media/video/saa7134/saa7134-core.c:234: error: `MODULE_STATE_LIVE' undeclared (first use in this function)
drivers/media/video/saa7134/saa7134-core.c:234: error: (Each undeclared identifier is reported only once
drivers/media/video/saa7134/saa7134-core.c:234: error: for each function it appears in.)
drivers/media/video/saa7134/saa7134-core.c: In function `request_module_depend':
drivers/media/video/saa7134/saa7134-core.c:251: error: dereferencing pointer to incomplete type
drivers/media/video/saa7134/saa7134-core.c:252: error: `MODULE_STATE_COMING' undeclared (first use in this function)
drivers/media/video/saa7134/saa7134-core.c:259: error: `MODULE_STATE_LIVE' undeclared (first use in this function)
make[4]: *** [drivers/media/video/saa7134/saa7134-core.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

