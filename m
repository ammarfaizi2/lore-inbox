Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292481AbSB0OK0>; Wed, 27 Feb 2002 09:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292464AbSB0OKQ>; Wed, 27 Feb 2002 09:10:16 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:44484 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292481AbSB0OJ6>; Wed, 27 Feb 2002 09:09:58 -0500
Date: Wed, 27 Feb 2002 15:57:23 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Brett <brett@bad-sports.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5-dj2 opl3sa2 as module compile failure
In-Reply-To: <Pine.LNX.4.44.0202271321230.29386-100000@bad-sports.com>
Message-ID: <Pine.LNX.4.44.0202271458400.16294-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Brett wrote:

> 
> Hey,
> 
> something fun for you all...

Here you go, don't know how that slipped by ^_^

Regards,
	Zwane

Diffed against 2.5.5-dj2

--- linux-2.5.5-pre1/sound/oss/opl3sa2.c.orig	Wed Feb 27 15:43:25 2002
+++ linux-2.5.5-pre1/sound/oss/opl3sa2.c	Wed Feb 27 15:45:12 2002
@@ -1140,11 +1140,11 @@
 
 	for(card = 0; card < opl3sa2_cards_num; card++) {
 #ifdef CONFIG_PM
-		if (opl3sa2_data[card].pmdev)
-			pm_unregister(opl3sa2_data[card].pmdev);
+		if (opl3sa2_state[card].pmdev)
+			pm_unregister(opl3sa2_state[card].pmdev);
 #endif
-	        if(cfg_mpu[card].slots[1] != -1) {
-			unload_opl3sa2_mpu(&cfg_mpu[card]);
+	        if(opl3sa2_state[card].cfg_mpu.slots[1] != -1) {
+			unload_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
 		}
 		unload_opl3sa2_mss(&opl3sa2_state[card].cfg_mss);
 		unload_opl3sa2(&opl3sa2_state[card].cfg, card);

