Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTFDJyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 05:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbTFDJyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 05:54:51 -0400
Received: from vt.ibt.lt ([193.219.56.32]:35457 "EHLO vt.fermentas.lt")
	by vger.kernel.org with ESMTP id S261944AbTFDJyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 05:54:51 -0400
From: Vitalis Tiknius <vt@vt.fermentas.lt>
Organization: myself
To: linux-kernel@vger.kernel.org
Subject: Re:2.5.70-mm4
Date: Wed, 4 Jun 2003 13:08:24 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306041308.24120.vt@vt.fermentas.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

re. cdrom mount problem: so far, so good with all combinations.

vesafb problem: does not work with memory >1Gb.

with patch:

--- vesafb.c.old	2003-06-04 12:12:03.000000000 +0200
+++ vesafb.c	2003-06-04 12:40:28.000000000 +0200
@@ -227,7 +227,7 @@
 	vesafb_defined.xres = screen_info.lfb_width;
 	vesafb_defined.yres = screen_info.lfb_height;
 	vesafb_fix.line_length = screen_info.lfb_linelength;
-	vesafb_fix.smem_len = screen_info.lfb_size * 65536;
+	vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height * 
vesafb_defined.bits_per_pixel;
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
from http://bugs.gentoo.org/show_bug.cgi?id=19061 all is ok. it is not the 
time to apply this patch?
