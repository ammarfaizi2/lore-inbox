Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261417AbSJAAeL>; Mon, 30 Sep 2002 20:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSJAAdm>; Mon, 30 Sep 2002 20:33:42 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5126 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261417AbSJAAcD>;
	Mon, 30 Sep 2002 20:32:03 -0400
Date: Mon, 30 Sep 2002 17:35:13 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003512.GG3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com> <20021001003304.GC3994@kroah.com> <20021001003401.GD3994@kroah.com> <20021001003440.GE3994@kroah.com> <20021001003456.GF3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003456.GF3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.5 -> 1.660.1.6
#	drivers/usb/core/usb.c	1.89    -> 1.90   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.6
# USB: allow /sbin/hotplug to be called for the main USB device.
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
--- a/drivers/usb/core/usb.c	Mon Sep 30 17:25:17 2002
+++ b/drivers/usb/core/usb.c	Mon Sep 30 17:25:17 2002
@@ -525,9 +525,8 @@
 	if (!dev)
 		return -ENODEV;
 
-	/* check for generic driver, we do not call do hotplug calls for it */
 	if (dev->driver == &usb_generic_driver)
-		return -ENODEV;
+		return 0;
 
 	intf = to_usb_interface(dev);
 	if (!intf)
