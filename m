Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbSKRVkY>; Mon, 18 Nov 2002 16:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbSKRVkW>; Mon, 18 Nov 2002 16:40:22 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51719
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264857AbSKRVkS>; Mon, 18 Nov 2002 16:40:18 -0500
Subject: Re: [patch] ALSA compiler warnings fixes
From: Robert Love <rml@tech9.net>
To: Jeff Garzik <jgarzik@pobox.com>, perex@suse.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3DD95535.8010707@pobox.com>
References: <1037652811.8374.138.camel@phantasy>
	 <3DD95535.8010707@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037656046.1374.2.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 18 Nov 2002 16:47:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-18 at 16:01, Jeff Garzik wrote:

> ALSA has an active maintainer, you should at least CC them on
>  patches to their subsystem...

It is hard to tell, they are off on their own list with their own CVS...

Here it is again.  Is this OK with you guys?  It fixes a bunch of
warnings in my compile.

	Robert Love


Fix numerous ALSA core compiler warnings of the type "unused variable foo"

 include/sound/core.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -urN linux-2.5.48/include/sound/core.h linux/include/sound/core.h
--- linux-2.5.48/include/sound/core.h	2002-11-17 23:29:57.000000000 -0500
+++ linux/include/sound/core.h	2002-11-18 15:51:59.000000000 -0500
@@ -177,11 +177,11 @@
 	wake_up(&card->power_sleep);
 }
 #else
-#define snd_power_lock(card) do { ; } while (0)
-#define snd_power_unlock(card) do { ; } while (0)
-#define snd_power_wait(card) do { ; } while (0)
-#define snd_power_get_state(card) SNDRV_CTL_POWER_D0
-#define snd_power_change_state(card, state) do { ; } while (0)
+#define snd_power_lock(card)		do { (void)(card); } while (0)
+#define snd_power_unlock(card)		do { (void)(card); } while (0)
+#define snd_power_wait(card)		do { (void)(card); } while (0)
+#define snd_power_get_state(card)	SNDRV_CTL_POWER_D0
+#define snd_power_change_state(card, state)	do { (void)(card); } while (0)
 #endif
 
 /* device.c */



