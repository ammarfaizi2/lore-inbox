Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSJAAdH>; Mon, 30 Sep 2002 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSJAAcD>; Mon, 30 Sep 2002 20:32:03 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:4358 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261416AbSJAAbr>;
	Mon, 30 Sep 2002 20:31:47 -0400
Date: Mon, 30 Sep 2002 17:34:57 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003456.GF3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com> <20021001003304.GC3994@kroah.com> <20021001003401.GD3994@kroah.com> <20021001003440.GE3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003440.GE3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.4 -> 1.660.1.5
#	drivers/usb/core/hub.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.5
# USB: Fix the name of usb hubs in driverfs.
# --------------------------------------------
#
diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
--- a/drivers/usb/core/hub.c	Mon Sep 30 17:25:28 2002
+++ b/drivers/usb/core/hub.c	Mon Sep 30 17:25:28 2002
@@ -537,7 +537,7 @@
 	dev_set_drvdata (&intf->dev, hub);
 
 	if (usb_hub_configure(hub, endpoint) >= 0) {
-		strcpy (intf->dev.name, "Hub/Port Status Changes");
+		strcpy (intf->dev.name, "Hub");
 		return 0;
 	}
 
