Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289854AbSAPEV4>; Tue, 15 Jan 2002 23:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290352AbSAPEVs>; Tue, 15 Jan 2002 23:21:48 -0500
Received: from gherkin.frus.com ([192.158.254.49]:4736 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S289854AbSAPEVg>;
	Tue, 15 Jan 2002 23:21:36 -0500
Message-Id: <m16QhZs-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: [PATCH] 2.5.2: emu10k1 fixup
To: torvalds@transmeta.com
Date: Tue, 15 Jan 2002 22:21:32 -0600 (CST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a *small* (avoiding the obvious pun) patch for the emu10k1
driver that changes MINOR() to minor() in the affected files.  Apply
to the 2.5.2 kernel source tree.


--- linux/drivers/sound/emu10k1/audio.c.orig	Thu Oct 11 06:51:46 2001
+++ linux/drivers/sound/emu10k1/audio.c	Sat Jan  5 17:55:56 2002
@@ -1098,7 +1098,7 @@
 
 static int emu10k1_audio_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 	struct emu10k1_wavedevice *wave_dev;
--- linux/drivers/sound/emu10k1/midi.c.orig	Thu Oct 11 06:51:46 2001
+++ linux/drivers/sound/emu10k1/midi.c	Sat Jan  5 17:59:03 2002
@@ -87,7 +87,7 @@
 
 static int emu10k1_midi_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct emu10k1_mididevice *midi_dev;
 	struct list_head *entry;
--- linux/drivers/sound/emu10k1/mixer.c.orig	Thu Oct 11 06:51:46 2001
+++ linux/drivers/sound/emu10k1/mixer.c	Sun Jan  6 01:33:02 2002
@@ -640,7 +640,7 @@
 
 static int emu10k1_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct emu10k1_card *card = NULL;
 	struct list_head *entry;
 

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
