Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945942AbWGOAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945942AbWGOAhx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945952AbWGOAhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:37:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40457 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945948AbWGOAho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:37:44 -0400
Date: Sat, 15 Jul 2006 02:37:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/char/pc8736x_gpio.c: remove unused static functions
Message-ID: <20060715003743.GQ3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc1-mm1:
>...
> +gpio-drop-vtable-members-gpio_set_high-gpio_set_low.patch
>...
>  Misc fixes and updates and cleanups.
>...

This patch removes two no longer used static functions fixing the 
following gcc warnings:

<--  snip  -->

...
  CC      drivers/char/pc8736x_gpio.o
drivers/char/pc8736x_gpio.c:192: warning: #pc8736x_gpio_set_high# defined but not used
drivers/char/pc8736x_gpio.c:197: warning: #pc8736x_gpio_set_low# defined but not used
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/pc8736x_gpio.c |   10 ----------
 1 file changed, 10 deletions(-)

--- linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c.old	2006-07-15 01:38:59.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/char/pc8736x_gpio.c	2006-07-15 01:39:10.000000000 +0200
@@ -188,16 +188,6 @@
 	pc8736x_gpio_shadow[port] = val;
 }
 
-static void pc8736x_gpio_set_high(unsigned index)
-{
-	pc8736x_gpio_set(index, 1);
-}
-
-static void pc8736x_gpio_set_low(unsigned index)
-{
-	pc8736x_gpio_set(index, 0);
-}
-
 static int pc8736x_gpio_current(unsigned minor)
 {
 	int port, bit;

