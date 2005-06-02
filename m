Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVFBIB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFBIB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFBIBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:01:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261181AbVFBH61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:58:27 -0400
Date: Thu, 2 Jun 2005 16:02:46 +0800
From: David Teigland <teigland@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/9] dlm: uncomment unregister_lockspace
Message-ID: <20050602080246.GD21570@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="do-unregister-lockspace.patch"
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The call to unregister_lockspace was left commented out from previous
debugging.

Signed-off-by: David Teigland <teigland@redhat.com>

Index: linux/drivers/dlm/device.c
===================================================================
--- linux.orig/drivers/dlm/device.c	2005-06-02 12:28:30.000000000 +0800
+++ linux/drivers/dlm/device.c	2005-06-02 12:58:09.796172200 +0800
@@ -594,8 +594,7 @@
 
 		if (lsinfo->ls_lockspace) {
 			if (test_bit(LS_FLAG_AUTOFREE, &lsinfo->ls_flags)) {
-				/* TODO this breaks!
-				unregister_lockspace(lsinfo, 1); */
+				unregister_lockspace(lsinfo, 1);
 			}
 		} else {
 			kfree(lsinfo->ls_miscinfo.name);

--

