Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbUCPP2w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUCPOkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:40:22 -0500
Received: from styx.suse.cz ([82.208.2.94]:61825 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261916AbUCPOTl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:41 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467774130@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 14/44] Fix a warning in i8042.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467773458@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1557.13.3, 2004-02-09 02:10:02+01:00, vojtech@suse.cz
  input: Fix a warning in i8042.c


 i8042.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Mar 16 13:19:25 2004
+++ b/drivers/input/serio/i8042.c	Tue Mar 16 13:19:25 2004
@@ -375,7 +375,7 @@
 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	unsigned long flags;
-	unsigned char str, data;
+	unsigned char str, data = 0;
 	unsigned int dfl;
 	int ret;
 

