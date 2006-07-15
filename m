Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945959AbWGOXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945959AbWGOXtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946020AbWGOXtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 19:49:03 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:23676 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1945959AbWGOXtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 19:49:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sERlrtHWb4kmvQikbb3vKIwVZoBx1QDuoBN6o8c+/iebfwU2x7ru1x+6b/w13eYPBGo7bhWpnJeMlfsSHmCKE4RWcj8PcMXnx4qFCYYrqOeImjZ41ji0i/Hm9tK8W9ilLRAmu5yETb+RkEmj4Ir0LGgmPMmfdmj1/mL3QdjC69I=
Message-ID: <44B97EF6.50202@gmail.com>
Date: Sat, 15 Jul 2006 17:49:10 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] drivers/char/scx200_gpio.c: make code static
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003536.GH3633@stusta.de>
In-Reply-To: <20060715003536.GH3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch makes needlessly global code static.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>   
Nak on 1st 2 chunks - exported vtable is now used, an should (hopefully)
serve as a universal gpio interface.
Here it is again, with the 2 chunks stripped.

---

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Jim Cromie  <jim.cromie@gmail.com>
---

$ diffstat fxd1/scx200_gpio.c-make-code-static.eml
 scx200_gpio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


--- linux-2.6.18-rc1-mm2-full/drivers/char/scx200_gpio.c.old	2006-07-14 22:31:22.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/drivers/char/scx200_gpio.c	2006-07-14 22:31:44.000000000 +0200
@@ -69,7 +68,7 @@
 	.release = scx200_gpio_release,
 };
 
-struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
+static struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
 
 static int __init scx200_gpio_init(void)
 {




