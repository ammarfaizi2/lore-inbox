Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267627AbUG2O44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267627AbUG2O44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267600AbUG2Oxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:53:41 -0400
Received: from styx.suse.cz ([82.119.242.94]:25750 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264937AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 26/47] when probing for ImExPS/2 mice, the ImPS/2 sequence needs to be sent first
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101954037@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101952172@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.148.13, 2004-06-21 20:31:56+02:00, vojtech@suse.cz
  input: when probing for ImExPS/2 mice, the ImPS/2 sequence needs
         to be sent first, but the result should be ignored.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 psmouse-base.c |    2 ++
 1 files changed, 2 insertions(+)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:40:13 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:40:13 2004
@@ -418,6 +418,8 @@
 {
 	unsigned char param[2];
 
+	intellimouse_detect(psmouse);
+
 	param[0] = 200;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 	param[0] = 200;

