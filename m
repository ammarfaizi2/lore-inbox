Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbUKDHqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUKDHqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUKDHqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:46:53 -0500
Received: from [211.58.254.17] ([211.58.254.17]:19368 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262128AbUKDHpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:45:54 -0500
Date: Thu, 4 Nov 2004 16:45:52 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 3/4] driver-model: detach_state functions renamed
Message-ID: <20041104074552.GJ25567@home-tj.org>
References: <20041104074330.GG25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104074330.GG25567@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ma_03_detach_state_fn_rename.patch

 This patch renames detach_{show,store}() functions which is used for
detach_state device interface node to detach_state_{show,store}().


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/interface.c
===================================================================
--- linux-export.orig/drivers/base/interface.c	2004-11-04 10:25:59.000000000 +0900
+++ linux-export/drivers/base/interface.c	2004-11-04 11:04:15.000000000 +0900
@@ -27,12 +27,13 @@
  *	driver's suspend method.
  */
 
-static ssize_t detach_show(struct device * dev, char * buf)
+static ssize_t detach_state_show(struct device * dev, char * buf)
 {
 	return sprintf(buf, "%u\n", dev->detach_state);
 }
 
-static ssize_t detach_store(struct device * dev, const char * buf, size_t n)
+static ssize_t detach_state_store(struct device * dev,
+				  const char * buf, size_t n)
 {
 	u32 state;
 	state = simple_strtoul(buf, NULL, 10);
@@ -42,7 +43,7 @@ static ssize_t detach_store(struct devic
 	return n;
 }
 
-static DEVICE_ATTR(detach_state, 0644, detach_show, detach_store);
+static DEVICE_ATTR(detach_state, 0644, detach_state_show, detach_state_store);
 
 
 struct attribute * dev_default_attrs[] = {
