Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVCYBMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVCYBMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCYBKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:10:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:24337 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261348AbVCYBFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:05:23 -0500
Date: Fri, 25 Mar 2005 02:05:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.ne, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/class/usb-midi.c: remove dead code
Message-ID: <20050325010512.GM3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obviously dead code found by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/usb/class/usb-midi.c.old	2005-03-24 04:51:19.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/usb/class/usb-midi.c	2005-03-24 04:51:50.000000000 +0100
@@ -1451,8 +1451,6 @@ static struct usb_midi_device *parse_des
 			} else {
 				if ( oep < 15 ) {
 					pins = oep+1;
-					if ( pins > 16 )
-						pins = 16;
 					u->out[oep].endpoint = p1[2];
 					u->out[oep].cableId = ( 1 << pins ) - 1;
 					if ( u->out[oep].cableId )

