Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268018AbUG2PGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268018AbUG2PGw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUG2PAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:00:42 -0400
Received: from styx.suse.cz ([82.119.242.94]:15510 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264850AbUG2OIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:09 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 15/47] Fix compilation breakage when CONFIG_USB_HIDDEV not defined
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <109111019563@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101951045@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.106.1, 2004-06-04 07:18:00+02:00, wli@holomorphy.com
  input: Move CONFIG_USB_HIDDEV a little lower in hiddev.h, to fix
         compilation breakage when it is not defined.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hiddev.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/include/linux/hiddev.h b/include/linux/hiddev.h
--- a/include/linux/hiddev.h	Thu Jul 29 14:41:17 2004
+++ b/include/linux/hiddev.h	Thu Jul 29 14:41:17 2004
@@ -213,12 +213,12 @@
  * In-kernel definitions.
  */
 
-#ifdef CONFIG_USB_HIDDEV
 struct hid_device;
 struct hid_usage;
 struct hid_field;
 struct hid_report;
 
+#ifdef CONFIG_USB_HIDDEV
 int hiddev_connect(struct hid_device *);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,

