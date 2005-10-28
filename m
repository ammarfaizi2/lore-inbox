Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbVJ1GrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbVJ1GrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVJ1Gqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:46:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:18410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965113AbVJ1GbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:07 -0400
Cc: jesper.juhl@gmail.com
Subject: [PATCH] Driver Core: Big kfree NULL check cleanup - Documentation
In-Reply-To: <11304810274123@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:27 -0700
Message-Id: <1130481027412@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver Core: Big kfree NULL check cleanup - Documentation

This is the Documentation/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in example code in Documentation/.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c4438d593e764474d701af6deebbb7df567be40f
tree 437de4251803d433d3cb80cc72e3f8aa83efd233
parent c2458141eaa1fcfe3c09a9834784a2c2716012b3
author Jesper Juhl <jesper.juhl@gmail.com> Thu, 13 Oct 2005 21:31:08 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:07 -0700

 Documentation/DocBook/writing_usb_driver.tmpl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/DocBook/writing_usb_driver.tmpl b/Documentation/DocBook/writing_usb_driver.tmpl
index 51f3bfb..008a341 100644
--- a/Documentation/DocBook/writing_usb_driver.tmpl
+++ b/Documentation/DocBook/writing_usb_driver.tmpl
@@ -345,8 +345,7 @@ if (!retval) {
   <programlisting>
 static inline void skel_delete (struct usb_skel *dev)
 {
-    if (dev->bulk_in_buffer != NULL)
-        kfree (dev->bulk_in_buffer);
+    kfree (dev->bulk_in_buffer);
     if (dev->bulk_out_buffer != NULL)
         usb_buffer_free (dev->udev, dev->bulk_out_size,
             dev->bulk_out_buffer,

