Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288986AbSAIUG1>; Wed, 9 Jan 2002 15:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSAIUDb>; Wed, 9 Jan 2002 15:03:31 -0500
Received: from ubermail.mweb.co.za ([196.2.53.169]:49420 "EHLO
	ubermail.mweb.co.za") by vger.kernel.org with ESMTP
	id <S288998AbSAIUBn>; Wed, 9 Jan 2002 15:01:43 -0500
Subject: [PATCH 2.5.2-pre10] btaudio.c kdev_t compilation fixes
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: LKM <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Jan 2002 22:13:29 +0200
Message-Id: <1010607213.12978.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hope this is correct, it compiles fine but I haven't tested it yet
(still compiling)

	-- Bongani

--- /usr/src/linux-2.5/drivers/sound/btaudio.c	Wed Oct 17 23:19:20 2001
+++ /usr/src/linux-2.5-dev/drivers/sound/btaudio.c	Wed Jan  9 22:02:42
2002
@@ -300,7 +300,7 @@
 
 static int btaudio_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct btaudio *bta;
 
 	for (bta = btaudios; bta != NULL; bta = bta->next)
@@ -459,7 +459,7 @@
 
 static int btaudio_dsp_open_digital(struct inode *inode, struct file
*file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct btaudio *bta;
 
 	for (bta = btaudios; bta != NULL; bta = bta->next)
@@ -475,7 +475,7 @@
 
 static int btaudio_dsp_open_analog(struct inode *inode, struct file
*file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	struct btaudio *bta;
 
 	for (bta = btaudios; bta != NULL; bta = bta->next)

