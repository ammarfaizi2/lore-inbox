Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVC2SYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVC2SYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVC2SYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:24:11 -0500
Received: from imag.imag.fr ([129.88.30.1]:2974 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261284AbVC2SYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:24:06 -0500
Message-ID: <1112120644.42499d44890ab@webmail.imag.fr>
Date: Tue, 29 Mar 2005 20:24:04 +0200
From: colbuse@ensisun.imag.fr
To: linux-kernel@vger.kernel.org
Subject: [2.2]drivers/char/console.c: check if caller is proprietary of the current console
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 195.221.228.2
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Tue, 29 Mar 2005 20:24:05 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a verification that the calling process is writing to the
current console, in the DEC alignment screen test.

Signed-off-by: Emmanuel Colbus <emmanuel.colbus@ensimag.imag.fr>
  
---

This patch was already sent on:
- 04 Jan 2005

--- old/drivers/char/console.c Mon Sep 16 18:26:11 2002
+++ patched/drivers/char/console.c Tue Jan 4 09:54:58 2005
@@ -1742,7 +1742,7 @@
			csi_J(currcons, 2);
			video_erase_char =
				(video_erase_char & 0xff00) | ' ';
-			do_update_region(currcons, origin, screenbuf_size/2);
+			update_region(currcons, origin, screenbuf_size/2);
		}
		return;
	case ESsetG0:


  
--
Emmanuel Colbus
Club Gnu/LInux
ENSIMAG - Departement telecoms

-------------------------------------------------
envoyé via Webmail/IMAG !

