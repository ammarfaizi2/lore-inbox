Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUG2OrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUG2OrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUG2OqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:46:23 -0400
Received: from styx.suse.cz ([82.119.242.94]:24214 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264919AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 23/47] Fix bad struct hidinput initialization in hid-tmff.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101951399@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101952752@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.148.9, 2004-06-17 08:38:07+02:00, zinx@epicsol.org
  input: Fix bad struct hidinput initialization in hid-tmff.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-tmff.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-tmff.c b/drivers/usb/input/hid-tmff.c
--- a/drivers/usb/input/hid-tmff.c	Thu Jul 29 14:40:32 2004
+++ b/drivers/usb/input/hid-tmff.c	Thu Jul 29 14:40:32 2004
@@ -110,7 +110,7 @@
 {
 	struct tmff_device *private;
 	struct list_head *pos;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 
 	private = kmalloc(sizeof(struct tmff_device), GFP_KERNEL);
 	if (!private)

