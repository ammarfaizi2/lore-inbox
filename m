Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCJCkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCJCkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVCJBPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:15:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:46239 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262612AbVCJAmZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:25 -0500
Cc: gregkh@suse.de
Subject: [PATCH] sysdev: make system_subsys static as no one else needs access to it.
In-Reply-To: <111041488554@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:45 -0800
Message-Id: <11104148853742@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2049, 2005/03/09 09:59:49-08:00, gregkh@suse.de

[PATCH] sysdev: make system_subsys static as no one else needs access to it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/base/sys.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	2005-03-09 16:28:45 -08:00
+++ b/drivers/base/sys.c	2005-03-09 16:28:45 -08:00
@@ -79,7 +79,7 @@
 /*
  * declare system_subsys
  */
-decl_subsys(system, &ktype_sysdev, NULL);
+static decl_subsys(system, &ktype_sysdev, NULL);
 
 int sysdev_class_register(struct sysdev_class * cls)
 {

