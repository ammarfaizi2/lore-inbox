Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUHUN02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUHUN02 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 09:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265410AbUHUN01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 09:26:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:30608 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265207AbUHUN0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 09:26:15 -0400
Date: Sat, 21 Aug 2004 15:26:13 +0200
From: Olaf Hering <olh@suse.de>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA 1.0.6
Message-ID: <20040821132613.GA12506@suse.de>
References: <Pine.LNX.4.58.0408161451280.1780@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0408161451280.1780@pnote.perex-int.cz>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 16, Jaroslav Kysela wrote:

> Linus, please do a
> 
>   bk pull http://linux-sound.bkbits.net/linux-sound
> 
> The GNU patch is available at:
> 
>   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-08-15.patch.gz
> 

>    use ARRAY_SIZE() instead of sizeof() computations

This update leads to an unresolved symbol.


--- ./sound/ppc/awacs.c.kaputt	2004-08-21 14:08:37.897062000 +0200
+++ ./sound/ppc/awacs.c	2004-08-21 14:47:32.989074632 +0200
@@ -829,10 +829,10 @@ snd_pmac_awacs_init(pmac_t *chip)
 				snd_pmac_awacs_mixers)) < 0)
 		return err;
 	if (chip->model == PMAC_SCREAMER)
-		err = build_mixers(chip, num_controls(snd_pmac_screamer_mixers2),
+		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_screamer_mixers2),
 				   snd_pmac_screamer_mixers2);
 	else
-		err = build_mixers(chip, num_controls(snd_pmac_awacs_mixers2),
+		err = build_mixers(chip, ARRAY_SIZE(snd_pmac_awacs_mixers2),
 				   snd_pmac_awacs_mixers2);
 	if (err < 0)
 		return err;

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
