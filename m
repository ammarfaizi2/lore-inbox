Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131023AbQL3Lsj>; Sat, 30 Dec 2000 06:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbQL3Ls2>; Sat, 30 Dec 2000 06:48:28 -0500
Received: from inje.iskon.hr ([213.191.128.16]:29191 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S131023AbQL3LsO>;
	Sat, 30 Dec 2000 06:48:14 -0500
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [patch] gemtek radio obvious fix
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 30 Dec 2000 12:16:18 +0100
Message-ID: <87lmsygnwd.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: 24012.6/drivers/media/radio/radio-gemtek.c
--- 24012.6/drivers/media/radio/radio-gemtek.c Thu, 14 Dec 2000 00:08:47 +0100 zcalusic (linux/P/d/1_radio-gemt 1.1.2.2.3.1 644)
+++ 24012.7(w)/drivers/media/radio/radio-gemtek.c Sat, 30 Dec 2000 12:06:56 +0100 zcalusic (linux/P/d/1_radio-gemt 1.1.2.2.3.2 644)
@@ -265,7 +265,7 @@
 		return -EINVAL;
 	}
 
-	if (request_region(io, 4, "gemtek")) 
+	if (!request_region(io, 4, "gemtek")) 
 	{
 		printk(KERN_ERR "gemtek: port 0x%x already in use\n", io);
 		return -EBUSY;

-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
