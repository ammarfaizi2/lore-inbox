Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSJAAge>; Mon, 30 Sep 2002 20:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261420AbSJAAdM>; Mon, 30 Sep 2002 20:33:12 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:6662 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261419AbSJAAct>;
	Mon, 30 Sep 2002 20:32:49 -0400
Date: Mon, 30 Sep 2002 17:35:59 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003558.GI3994@kroah.com>
References: <20021001003104.GA3994@kroah.com> <20021001003240.GB3994@kroah.com> <20021001003304.GC3994@kroah.com> <20021001003401.GD3994@kroah.com> <20021001003440.GE3994@kroah.com> <20021001003456.GF3994@kroah.com> <20021001003512.GG3994@kroah.com> <20021001003541.GH3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001003541.GH3994@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660.1.7 -> 1.660.1.8
#	drivers/usb/serial/usbserial.c	1.44    -> 1.45   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/30	greg@kroah.com	1.660.1.8
# USB: fix typo from previous schedule_task() patch.
# --------------------------------------------
#
diff -Nru a/drivers/usb/serial/usbserial.c b/drivers/usb/serial/usbserial.c
--- a/drivers/usb/serial/usbserial.c	Mon Sep 30 17:24:53 2002
+++ b/drivers/usb/serial/usbserial.c	Mon Sep 30 17:24:53 2002
@@ -1092,7 +1092,7 @@
 
 	usb_serial_port_softint((void *)port);
 
-	schedule_tasks(&port->tqueue);
+	schedule_task(&port->tqueue);
 }
 
 static void generic_shutdown (struct usb_serial *serial)
