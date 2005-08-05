Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVHEBM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVHEBM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVHEBJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:09:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:56039 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262808AbVHEBHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:07:09 -0400
Date: Thu, 4 Aug 2005 18:06:36 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: [patch 3/5] USB: ub documentation update
Message-ID: <20050805010635.GD19625@kroah.com>
References: <20050805010206.711658000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-ub-documentation-update.patch"
In-Reply-To: <20050805010533.GA19625@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>

The patch which went in was correct, but not quite what I had in mind.
Here is a patch to update that a little bit. Original patch is at:
 http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4749f32da939d4e4160541b2cadc22492bb507ec

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/usb/usbmon.txt |    2 +-
 drivers/usb/mon/Kconfig      |    9 ++++-----
 drivers/usb/mon/Makefile     |    1 +
 3 files changed, 6 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/Documentation/usb/usbmon.txt	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/Documentation/usb/usbmon.txt	2005-08-04 17:40:06.000000000 -0700
@@ -102,7 +102,7 @@
 - URB Status. This field makes no sense for submissions, but is present
   to help scripts with parsing. In error case, it contains the error code.
   In case of a setup packet, it contains a Setup Tag. If scripts read a number
-  in this field, the proceed to read Data Length. Otherwise, they read
+  in this field, they proceed to read Data Length. Otherwise, they read
   the setup packet before reading the Data Length.
 - Setup packet, if present, consists of 5 words: one of each for bmRequestType,
   bRequest, wValue, wIndex, wLength, as specified by the USB Specification 2.0.
--- gregkh-2.6.orig/drivers/usb/mon/Kconfig	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/mon/Kconfig	2005-08-04 17:40:06.000000000 -0700
@@ -9,9 +9,8 @@
 	help
 	  If you say Y here, a component which captures the USB traffic
 	  between peripheral-specific drivers and HC drivers will be built.
-	  The USB_MON is similar in spirit and may be compatible with Dave
-	  Harding's USBMon.
+	  For more information, see <file:Documentation/usb/usbmon.txt>.
 
-	  This is somewhat experimental at this time, but it should be safe,
-	  as long as you aren't using modular USB and try to remove this
-	  module.
+	  This is somewhat experimental at this time, but it should be safe.
+
+	  If unsure, say Y.
--- gregkh-2.6.orig/drivers/usb/mon/Makefile	2005-08-04 17:37:11.000000000 -0700
+++ gregkh-2.6/drivers/usb/mon/Makefile	2005-08-04 17:40:06.000000000 -0700
@@ -4,4 +4,5 @@
 
 usbmon-objs	:= mon_main.o mon_stat.o mon_text.o
 
+# This does not use CONFIG_USB_MON because we want this to use a tristate.
 obj-$(CONFIG_USB)	+= usbmon.o

--
