Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276985AbSIVJMN>; Sun, 22 Sep 2002 05:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276975AbSIVJLO>; Sun, 22 Sep 2002 05:11:14 -0400
Received: from smtpout.mac.com ([204.179.120.87]:26313 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S276985AbSIVJJd>;
	Sun, 22 Sep 2002 05:09:33 -0400
Date: Sat, 21 Sep 2002 22:44:08 +0200
Subject: [PATCH] 10/11 sound/oss replace cli()
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Linus Torvalds <torvalds@transmeta.com>
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E072C09A-CDA2-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.36/sound/oss/v_midi.h	2002-04-20 18:25:21.000000000 +0200
+++ linux-2.5-cli-oss/sound/oss/v_midi.h	2002-08-13 15:55:26.000000000 
+0200
@@ -3,7 +3,7 @@

  	/* State variables */
   	   int opened;
-
+	   spinlock_t lock;
  	
  	/* MIDI fields */
  	   int my_mididev;

