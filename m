Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWHMVAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWHMVAR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWHMVAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:00:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2318 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751463AbWHMVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:00:13 -0400
Date: Sun, 13 Aug 2006 23:00:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Shem Multinymous <multinymous@gmail.com>
Cc: linux-kernel@vger.kernel.org, khali@linux-fr.org,
       lm-sensors@lm-sensors.org
Subject: [-mm patch] make drivers/hwmon/hdaps.c:transform_axes() static
Message-ID: <20060813210012.GK3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
> +hdaps-unify-and-cache-hdaps-readouts.patch
>...
>  HDAPS driver updates

transform_axes() isn't a good name for a global function.

Thankfully, it can simply made static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm1/drivers/hwmon/hdaps.c.old	2006-08-13 17:45:34.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/hwmon/hdaps.c	2006-08-13 17:45:50.000000000 +0200
@@ -85,7 +85,7 @@
 static u64 last_mouse_jiffies = INITIAL_JIFFIES;
 
 /* Some models require an axis transformation to the standard reprsentation */
-void transform_axes(int *x, int *y)
+static void transform_axes(int *x, int *y)
 {
 	if (hdaps_invert) {
 		*x = -*x;

