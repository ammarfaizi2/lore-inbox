Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbSJHXU5>; Tue, 8 Oct 2002 19:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSJHXUE>; Tue, 8 Oct 2002 19:20:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:56329 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261511AbSJHXTK>;
	Tue, 8 Oct 2002 19:19:10 -0400
Date: Tue, 8 Oct 2002 16:21:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and driver core changes for 2.5.41
Message-ID: <20021008232105.GI11337@kroah.com>
References: <20021008231511.GA11337@kroah.com> <20021008231557.GB11337@kroah.com> <20021008231646.GC11337@kroah.com> <20021008231747.GD11337@kroah.com> <20021008231832.GE11337@kroah.com> <20021008231903.GF11337@kroah.com> <20021008231957.GG11337@kroah.com> <20021008232032.GH11337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008232032.GH11337@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.573.92.19 -> 1.573.92.20
#	drivers/usb/core/usb.c	1.92    -> 1.93   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/08	greg@kroah.com	1.573.92.20
# USB: removed unused DEVFS /sbin/hotplug attribute
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Tue Oct  8 15:53:32 2002
+++ b/drivers/usb/core/usb.c	Tue Oct  8 15:53:32 2002
@@ -558,14 +558,6 @@
 	 */
 	envp [i++] = scratch;
 	length += snprintf (scratch, buffer_size - length,
-			    "%s", "DEVFS=/proc/bus/usb");
-	if ((buffer_size - length <= 0) || (i >= num_envp))
-		return -ENOMEM;
-	++length;
-	scratch += length;
-
-	envp [i++] = scratch;
-	length += snprintf (scratch, buffer_size - length,
 			    "DEVICE=/proc/bus/usb/%03d/%03d",
 			    usb_dev->bus->busnum, usb_dev->devnum);
 	if ((buffer_size - length <= 0) || (i >= num_envp))
