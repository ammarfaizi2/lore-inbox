Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288521AbSATNRa>; Sun, 20 Jan 2002 08:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288531AbSATNRU>; Sun, 20 Jan 2002 08:17:20 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:39431 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S288521AbSATNRN>; Sun, 20 Jan 2002 08:17:13 -0500
Message-ID: <3C4AC354.55562D1F@delusion.de>
Date: Sun, 20 Jan 2002 14:17:08 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rui Sousa <rui.p.m.sousa@clix.pt>
Subject: [PATCH] Compile Fix for Emu10K1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch against 2.5.3-pre2 fixes compile errors with the Emu10K1 driver.

diff -Naur -X dontdiff linux-2.5.3-vanilla/drivers/sound/emu10k1/audio.c linux-2.5.3/drivers/sound/emu10k1/audio.c
--- linux-2.5.3-vanilla/drivers/sound/emu10k1/audio.c   Tue Oct  9 19:53:17 2001
+++ linux-2.5.3/drivers/sound/emu10k1/audio.c   Sun Jan 20 13:38:26 2002
@@ -1098,7 +1098,7 @@

 static int emu10k1_audio_open(struct inode *inode, struct file *file)
 {
-       int minor = MINOR(inode->i_rdev);
+       int minor = minor(inode->i_rdev);
        struct emu10k1_card *card = NULL;
        struct list_head *entry;
        struct emu10k1_wavedevice *wave_dev;
diff -Naur -X dontdiff linux-2.5.3-vanilla/drivers/sound/emu10k1/midi.c linux-2.5.3/drivers/sound/emu10k1/midi.c
--- linux-2.5.3-vanilla/drivers/sound/emu10k1/midi.c    Tue Oct  9 19:53:18 2001
+++ linux-2.5.3/drivers/sound/emu10k1/midi.c    Sun Jan 20 13:39:01 2002
@@ -87,7 +87,7 @@

 static int emu10k1_midi_open(struct inode *inode, struct file *file)
 {
-       int minor = MINOR(inode->i_rdev);
+       int minor = minor(inode->i_rdev);
        struct emu10k1_card *card = NULL;
        struct emu10k1_mididevice *midi_dev;
        struct list_head *entry;
diff -Naur -X dontdiff linux-2.5.3-vanilla/drivers/sound/emu10k1/mixer.c linux-2.5.3/drivers/sound/emu10k1/mixer.c
--- linux-2.5.3-vanilla/drivers/sound/emu10k1/mixer.c   Tue Oct  9 19:53:18 2001
+++ linux-2.5.3/drivers/sound/emu10k1/mixer.c   Sun Jan 20 13:39:22 2002
@@ -640,7 +640,7 @@

 static int emu10k1_mixer_open(struct inode *inode, struct file *file)
 {
-       int minor = MINOR(inode->i_rdev);
+       int minor = minor(inode->i_rdev);
        struct emu10k1_card *card = NULL;
        struct list_head *entry;
