Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWGQQeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWGQQeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWGQQeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:34:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:56764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750963AbWGQQdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:50 -0400
Date: Mon, 17 Jul 2006 09:29:15 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 40/45] ALSA: Fix missing array terminators in AD1988 codec support
Message-ID: <20060717162915.GO4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-missing-array-terminators-in-ad1988-codec-support.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix missing array terminators in AD1988 codec support

Fixed the missing array terminators in AD1988 codec support code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/hda/patch_analog.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.17.6.orig/sound/pci/hda/patch_analog.c
+++ linux-2.6.17.6/sound/pci/hda/patch_analog.c
@@ -1582,6 +1582,7 @@ static struct snd_kcontrol_new ad1988_6s
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_6stack_mixers1_rev2[] = {
@@ -1590,6 +1591,7 @@ static struct snd_kcontrol_new ad1988_6s
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0a, 2, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x06, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_6stack_mixers2[] = {
@@ -1628,6 +1630,7 @@ static struct snd_kcontrol_new ad1988_3s
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x05, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x05, 2, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_3stack_mixers1_rev2[] = {
@@ -1635,6 +1638,7 @@ static struct snd_kcontrol_new ad1988_3s
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x0a, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x06, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x06, 2, 0x0, HDA_OUTPUT),
+	{ } /* end */
 };
 
 static struct snd_kcontrol_new ad1988_3stack_mixers2[] = {

--
