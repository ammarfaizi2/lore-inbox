Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbUEHPnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUEHPnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 11:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUEHPnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 11:43:42 -0400
Received: from heredia-a381.racsa.co.cr ([196.40.93.7]:61962 "EHLO
	bruno.wildbear.com") by vger.kernel.org with ESMTP id S263171AbUEHPnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 11:43:40 -0400
Date: Sat, 8 May 2004 09:43:36 -0600 (CST)
From: Joseph Parmelee <jparmele@wildbear.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Crystal cs4235 mixer
Message-ID: <Pine.LNX.4.10.10405080931290.5604-100000@bruno>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings all:

The very short patch below fixes improper setup of the mixer on Crystal
soundcards with the CS4235 chip.  It applies against 2.4.26 and other recent
2.4.X kernels.  I haven't tried it against 2.6.X.

Please CC me directly at jparmele at wildbear point com as I am no longer
subscribed to the list.

Best regards,

Joseph Parmelee
Wild Bear Systems


--- linux/drivers/sound/ad1848.c.orig	Sun Jan 19 14:17:57 2003
+++ linux/drivers/sound/ad1848.c	Fri Jan 24 08:05:40 2003
@@ -636,6 +636,7 @@
 			devc->supported_devices = MODE3_MIXER_DEVICES;
 			break;
 		case MD_4232:
+		case MD_4235:
 		case MD_4236:
 			devc->supported_devices = MODE3_MIXER_DEVICES;
 			break;

