Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUG2OL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUG2OL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUG2OJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:09:50 -0400
Received: from styx.suse.cz ([82.119.242.94]:31894 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265055AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 46/47] Fix a missing index in tmdc.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110196560@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101963121@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1858, 2004-07-29 13:42:55+02:00, vojtech@suse.cz
  input: Fix a missing index in tmdc.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 tmdc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/joystick/tmdc.c b/drivers/input/joystick/tmdc.c
--- a/drivers/input/joystick/tmdc.c	Thu Jul 29 14:38:28 2004
+++ b/drivers/input/joystick/tmdc.c	Thu Jul 29 14:38:28 2004
@@ -322,7 +322,7 @@
 			tmdc->dev[j].evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 
 			for (i = 0; i < models[m].abs && i < TMDC_ABS; i++) {
-				if (tmdc->abs[i] < 0) continue;
+				if (tmdc->abs[j][i] < 0) continue;
 				set_bit(tmdc->abs[j][i], tmdc->dev[j].absbit);
 				tmdc->dev[j].absmin[tmdc->abs[j][i]] = 8;
 				tmdc->dev[j].absmax[tmdc->abs[j][i]] = 248;

