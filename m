Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWBHGnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWBHGnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWBHGnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:00 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10112 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161013AbWBHGm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:58 -0500
Message-Id: <20060208064916.791651000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:24 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Daniel Drake <dsd@gentoo.org>, tiwai@suse.de
Subject: [PATCH 21/23] [ALSA] emu10k1 - Fix the confliction of Front control
Content-Disposition: inline; filename=emu10k1-fix-the-confliction-of-front-control.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix the confliction of 'Front' controls on models with STAC9758 codec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 sound/pci/emu10k1/emumixer.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.15.3/sound/pci/emu10k1/emumixer.c
===================================================================
--- linux-2.6.15.3.orig/sound/pci/emu10k1/emumixer.c
+++ linux-2.6.15.3/sound/pci/emu10k1/emumixer.c
@@ -750,6 +750,8 @@ int __devinit snd_emu10k1_mixer(emu10k1_
 		"Master Mono Playback Volume",
 		"PCM Out Path & Mute",
 		"Mono Output Select",
+		"Front Playback Switch",
+		"Front Playback Volume",
 		"Surround Playback Switch",
 		"Surround Playback Volume",
 		"Center Playback Switch",

--
