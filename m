Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319421AbSH2V4Z>; Thu, 29 Aug 2002 17:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319408AbSH2Vza>; Thu, 29 Aug 2002 17:55:30 -0400
Received: from smtpout.mac.com ([204.179.120.86]:5845 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319407AbSH2Vyc>;
	Thu, 29 Aug 2002 17:54:32 -0400
Message-Id: <200208292158.g7TLwtKN026794@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 39/41 sound/oss/nm256.h - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/nm256.h	Sat Apr 20 18:25:20 2002
+++ linux-2.5-cli-oss/sound/oss/nm256.h	Tue Aug 13 14:04:59 2002
@@ -1,6 +1,7 @@
 #ifndef _NM256_H_
 #define _NM256_H_
 
+#include <linux/spinlock.h>
 #include "ac97.h"
 
 /* The revisions that we currently handle.  */
@@ -33,6 +34,8 @@
     int dev_for_play;
     int dev_for_record;
 
+	spinlock_t lock;
+	
     /* The mixer device. */
     int mixer_oss_dev;
 

