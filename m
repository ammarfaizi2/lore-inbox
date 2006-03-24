Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWCXAAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWCXAAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWCXAAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:00:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422735AbWCXAAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:00:02 -0500
Date: Fri, 24 Mar 2006 01:00:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org, Yani Ioannou <yani.ioannou@gmail.com>,
       Greg KH <greg@kroah.com>
Subject: [-mm patch] make drivers/char/ipmi/ipmi_msghandler.c:ipmi_find_bmc_guid() static
Message-ID: <20060324000001.GK22727@stusta.de>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 01:40:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc6-mm2:
>...
> +ipmi-add-full-sysfs-support.patch
>...
>  Random stuff.
>...


This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm1-full/drivers/char/ipmi/ipmi_msghandler.c.old	2006-03-23 23:10:10.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/char/ipmi/ipmi_msghandler.c	2006-03-23 23:10:30.000000000 +0100
@@ -1754,8 +1754,8 @@
 	return memcmp(bmc->guid, id, 16) == 0;
 }
 
-struct bmc_device * ipmi_find_bmc_guid(struct device_driver *drv,
-				       unsigned char *guid)
+static struct bmc_device *ipmi_find_bmc_guid(struct device_driver *drv,
+					     unsigned char *guid)
 {
 	struct device *dev;
 

