Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTBDJfa>; Tue, 4 Feb 2003 04:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbTBDJfa>; Tue, 4 Feb 2003 04:35:30 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18835 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S267196AbTBDJf3>; Tue, 4 Feb 2003 04:35:29 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: BTTV Compile Problem
Date: 04 Feb 2003 10:50:25 +0100
Organization: SuSE Labs, Berlin
Message-ID: <87wukg4boe.fsf@bytesex.org>
References: <200302031626.43618.lkml@ro0tsiege.org>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1044352225 7969 127.0.0.1 (4 Feb 2003 09:50:25 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ro0tSiEgE <lkml@ro0tsiege.org> writes:

> What would be the cause of me having to insert 
> #include "../../sound/sound_firmware.c" into drivers/media/video/bttv-cards.c
> for bttv to compile into the kernel?

config bug.

  Gerd

--- linux64-2.5.59/drivers/media/video/Kconfig~	2003-01-24 20:11:20.000000000 +0100
+++ linux64-2.5.59/drivers/media/video/Kconfig	2003-02-04 10:36:40.009993513 +0100
@@ -19,7 +19,7 @@
 
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C_ALGOBIT
+	depends on VIDEO_DEV && PCI && I2C_ALGOBIT && SOUND
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in

