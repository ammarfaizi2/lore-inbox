Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319420AbSH2V4Y>; Thu, 29 Aug 2002 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319404AbSH2Vz1>; Thu, 29 Aug 2002 17:55:27 -0400
Received: from smtpout.mac.com ([204.179.120.86]:9941 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319408AbSH2Vyl>;
	Thu, 29 Aug 2002 17:54:41 -0400
Message-Id: <200208292159.g7TLx4KN026825@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 40/41 sound/oss/gus_card.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/gus_card.c	Sat Apr 20 18:25:20 2002
+++ linux-2.5-cli-oss/sound/oss/gus_card.c	Wed Aug 14 22:52:36 2002
@@ -123,8 +123,6 @@
 	unsigned char src;
 	extern int gus_timer_enabled;
 
-	sti();
-
 #ifdef CONFIG_SOUND_GUSMAX
 	if (have_gus_max) {
 		struct address_info *hw_config = dev_id;

