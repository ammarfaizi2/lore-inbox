Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTIYQxD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTIYQvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:51:40 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:37335 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261551AbTIYQub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:50:31 -0400
Subject: [PATCH 1/8] Revert synaptics->pktcnt change.
In-Reply-To: <20030925164845.GA30105@ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 25 Sep 2003 18:50:12 +0200
Message-Id: <1064508612452@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, dtor_core@ameritech.net, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1341, 2003-09-25 18:17:45+02:00, vojtech@suse.cz
  input: Revert synaptics->pktcnt change. New synaptics driver actually
         uses the variable.


 psmouse-base.c |    1 -
 1 files changed, 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Sep 25 18:37:50 2003
+++ b/drivers/input/mouse/psmouse-base.c	Thu Sep 25 18:37:50 2003
@@ -173,7 +173,6 @@
 		 * so it needs to receive all bytes one at a time.
 		 */
 		synaptics_process_byte(psmouse, regs);
-		psmouse->pktcnt = 0;
 		goto out;
 	}
 

