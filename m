Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTISKb3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 06:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbTISKaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 06:30:02 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21646 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261507AbTISK1E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 06:27:04 -0400
Subject: [PATCH 7/11] input: Fix psmouse->pktcnt in Synaptics mode
In-Reply-To: <10639672011502@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Sep 2003 12:26:41 +0200
Message-Id: <10639672012999@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1345, 2003-09-19 01:20:33-07:00, vojtech@suse.cz
  psmouse-base.c:
    Make sure psmouse->pktcnt is zero after passing a byte
    to be processed by synaptics code.


 psmouse-base.c |    1 +
 1 files changed, 1 insertion(+)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:08 2003
+++ b/drivers/input/mouse/psmouse-base.c	Fri Sep 19 12:16:08 2003
@@ -173,6 +173,7 @@
 		 * so it needs to receive all bytes one at a time.
 		 */
 		synaptics_process_byte(psmouse, regs);
+		psmouse->pktcnt = 0;
 		goto out;
 	}
 

