Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUG2SWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUG2SWX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267757AbUG2O4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:56:37 -0400
Received: from styx.suse.cz ([82.119.242.94]:63125 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264781AbUG2OIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:07 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 5/47] Return 0 from uinput poll if device isn't yet created.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101944159@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101942431@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.54.3, 2004-05-31 12:27:40+02:00, vojtech@suse.cz
  input: Return 0 from uinput poll if device isn't yet created.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 uinput.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
--- a/drivers/input/misc/uinput.c	Thu Jul 29 14:42:09 2004
+++ b/drivers/input/misc/uinput.c	Thu Jul 29 14:42:09 2004
@@ -280,7 +280,7 @@
 	struct uinput_device *udev = file->private_data;
 
 	if (!test_bit(UIST_CREATED, &(udev->state)))
-		return -ENODEV;
+		return 0;
 
 	poll_wait(file, &udev->waitq, wait);
 

