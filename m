Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbSIVJGw>; Sun, 22 Sep 2002 05:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276878AbSIVJGw>; Sun, 22 Sep 2002 05:06:52 -0400
Received: from smtpout.mac.com ([204.179.120.85]:35292 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276877AbSIVJGv>;
	Sun, 22 Sep 2002 05:06:51 -0400
Date: Sat, 21 Sep 2002 22:31:47 +0200
Subject: [PATCH] 2/11 sound/oss replace cli() 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <2664E0B9-CDA1-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/dmasound/dmasound.h	Sat Apr 20 18:25:19 
2002
+++ linux-2.5-cli-oss/sound/oss/dmasound/dmasound.h	Mon Sep  9 01:27:04 
2002
@@ -166,6 +166,7 @@
      int treble;
      int gain;
      int minDev;		/* minor device number currently open */
+    spinlock_t lock;
  };

  extern struct sound_settings dmasound;

