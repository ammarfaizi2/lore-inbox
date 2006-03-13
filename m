Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWCMVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWCMVOq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWCMVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:14:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57102 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932224AbWCMVOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:14:46 -0500
Date: Mon, 13 Mar 2006 22:14:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [-mm patch] sound/pci/ice1712/delta.c: make 2 functions static
Message-ID: <20060313211444.GH13973@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm3:
>...
>  git-alsa.patch
>...
>  git trees
>...


This patch makes two needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/ice1712/delta.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc6-mm1-full/sound/pci/ice1712/delta.c.old	2006-03-13 21:32:49.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/sound/pci/ice1712/delta.c	2006-03-13 21:33:25.000000000 +0100
@@ -393,7 +393,7 @@
 	snd_ice1712_delta_cs8403_spdif_write(ice, tmp);
 }
 
-int snd_ice1712_delta1010lt_wordclock_status_info(struct snd_kcontrol *kcontrol,
+static int snd_ice1712_delta1010lt_wordclock_status_info(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -403,7 +403,7 @@
 	return 0;
 }
 
-int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kcontrol,
+static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
 	char reg = 0x10; // cs8427 receiver error register

