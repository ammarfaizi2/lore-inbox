Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270589AbTGNMdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270590AbTGNMb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:26 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:46724
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270589AbTGNMMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:12:24 -0400
Date: Mon, 14 Jul 2003 13:26:24 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141226.h6ECQONp030929@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: re-enable POST on via audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/sound/via82cxxx_audio.c linux.22-pre5-ac1/drivers/sound/via82cxxx_audio.c
--- linux.22-pre5/drivers/sound/via82cxxx_audio.c	2003-07-14 12:27:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/sound/via82cxxx_audio.c	2003-07-08 17:04:50.000000000 +0100
@@ -3226,7 +3226,7 @@
 	/* inform device of an upcoming pause in input (or output). */
 	case SNDCTL_DSP_POST:
 		DPRINTK ("DSP_POST\n");
-		if (0 && wr) {
+		if (wr) {
 			if (card->ch_out.slop_len > 0)
 				via_chan_flush_frag (&card->ch_out);
 			via_chan_maybe_start (&card->ch_out);
