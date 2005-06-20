Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVFUCq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVFUCq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVFUCpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:45:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:22756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261683AbVFTW7m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:42 -0400
Cc: gregkh@suse.de
Subject: [PATCH] USB: fix build warning in usb core as pointed out by Andrew.
In-Reply-To: <11193083661546@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:26 -0700
Message-Id: <1119308366638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] USB: fix build warning in usb core as pointed out by Andrew.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Index: gregkh-2.6/drivers/usb/core/usb.c
===================================================================

---
commit ff710710eae73990dd484ea8e37dba636452502b
tree c764773894a10b5650f81b32e86751b97e54706e
parent 126eddfbf8cae8a20c22708192bffcbd77c8a889
author gregkh@suse.de <gregkh@suse.de> Thu, 24 Mar 2005 00:44:28 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:26 -0700

 drivers/usb/core/usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -492,7 +492,7 @@ static int __find_interface(struct devic
  */
 struct usb_interface *usb_find_interface(struct usb_driver *drv, int minor)
 {
-	struct usb_interface *intf = (struct usb_interface *)minor;
+	struct usb_interface *intf = (struct usb_interface *)(long)minor;
 	int ret;
 
 	ret = driver_for_each_device(&drv->driver, NULL, &intf, __find_interface);

