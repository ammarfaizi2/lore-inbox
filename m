Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263168AbSJHXTx>; Tue, 8 Oct 2002 19:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261504AbSJHXSg>; Tue, 8 Oct 2002 19:18:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:54793 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261502AbSJHXSI>;
	Tue, 8 Oct 2002 19:18:08 -0400
Date: Tue, 8 Oct 2002 16:19:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008231957.GG11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com> <20021008231646.GC11337@kroah.com> <20021008231747.GD11337@kroah.com> <20021008231832.GE11337@kroah.com> <20021008231903.GF11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008231903.GF11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.17 -> 1.573.92.18
#	drivers/base/hotplug.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	greg@kroah.com	1.573.92.18
# driver core: rename DEVICE to DEVPATH for /sbin/hotplug call to prevent conflict with USB
# --------------------------------------------
#
diff -Nru a/drivers/base/hotplug.c b/drivers/base/hotplug.c
--- a/drivers/base/hotplug.c	Tue Oct  8 15:53:38 2002
+++ b/drivers/base/hotplug.c	Tue Oct  8 15:53:38 2002
@@ -97,7 +97,7 @@
 	scratch += sprintf (scratch, "ACTION=%s", action) + 1;
 
 	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DEVICE=%s", dev_path) + 1;
+	scratch += sprintf (scratch, "DEVPATH=%s", dev_path) + 1;
 	
 	if (dev->bus->hotplug) {
 		/* have the bus specific function add its stuff */
