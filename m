Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUKIVY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUKIVY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUKIVY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:24:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60173 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261685AbUKIVYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:24:06 -0500
Date: Tue, 9 Nov 2004 22:23:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: [2.6 patch] remove stale bttv_parse prototype
Message-ID: <20041109212334.GC5892@stusta.de>
References: <20041109074909.3f287966.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109074909.3f287966.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 07:49:09AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc1-mm3:
>...
> +v4l-bttv-update.patch
>...
>  v4l updates
>...


This patch removes bttv_parse but not it's prototype from bttv.h

Trivial fix:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full/drivers/media/video/bttv.h.old	2004-11-09 22:09:15.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/media/video/bttv.h	2004-11-09 22:09:25.000000000 +0100
@@ -230,9 +230,6 @@
 extern void tea5757_set_freq(struct bttv *btv, unsigned short freq);
 extern void bttv_tda9880_setnorm(struct bttv *btv, int norm);
 
-/* kernel cmd line parse helper */
-extern int bttv_parse(char *str, int max, int *vals);
-
 /* extra tweaks for some chipsets */
 extern void bttv_check_chipset(void);
 extern int bttv_handle_chipset(struct bttv *btv);


