Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUE1V0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUE1V0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUE1V0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:26:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:17069 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261711AbUE1V0j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:26:39 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core fixes for 2.6.7-rc1
In-Reply-To: <10857795552130@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 28 May 2004 14:25:55 -0700
Message-Id: <1085779555955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.7.7, 2004/05/28 10:31:37-07:00, greg@kroah.com

Minor coding style fixups in resume code and added a bit of debugging help.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/power/runtime.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -Nru a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
--- a/drivers/base/power/runtime.c	Fri May 28 14:17:57 2004
+++ b/drivers/base/power/runtime.c	Fri May 28 14:17:57 2004
@@ -12,12 +12,11 @@
 
 static void runtime_resume(struct device * dev)
 {
+	dev_dbg(dev, "resuming\n");
 	if (!dev->power.power_state)
 		return;
-	if (! resume_device(dev))
+	if (!resume_device(dev))
 		dev->power.power_state = 0;
-
-	return;
 }
 
 

