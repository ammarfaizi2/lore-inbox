Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267355AbUG2Oet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267355AbUG2Oet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUG2OcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:32:13 -0400
Received: from styx.suse.cz ([82.119.242.94]:15254 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264966AbUG2OIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:13 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 14/47] logips2pp - do not call get_model_info 2 times
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110195981@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <109111019563@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1612.25.2, 2004-06-02 13:00:58-05:00, dtor_core@ameritech.net
  Input: logips2pp - do not call get_model_info 2 times
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 logips2pp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	Thu Jul 29 14:41:21 2004
+++ b/drivers/input/mouse/logips2pp.c	Thu Jul 29 14:41:21 2004
@@ -277,7 +277,7 @@
 				protocol = PSMOUSE_PS2TPP;
 			}
 
-		} else if (get_model_info(model) != NULL) {
+		} else if (model_info != NULL) {
 
 			param[0] = param[1] = param[2] = 0;
 			ps2pp_cmd(psmouse, param, 0x39); /* Magic knock */

