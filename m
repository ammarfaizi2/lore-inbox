Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262582AbSI0ThR>; Fri, 27 Sep 2002 15:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbSI0ThQ>; Fri, 27 Sep 2002 15:37:16 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:2318 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262582AbSI0ThO>;
	Fri, 27 Sep 2002 15:37:14 -0400
Date: Fri, 27 Sep 2002 12:40:54 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] More USB changes for 2.5.38
Message-ID: <20020927194054.GD12909@kroah.com>
References: <20020927193723.GA12909@kroah.com> <20020927193855.GB12909@kroah.com> <20020927194025.GC12909@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927194025.GC12909@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611.1.2 -> 1.611.1.3
#	drivers/net/irda/irda-usb.c	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	greg@kroah.com	1.611.1.3
# USB: fix ifnum usage that was missed in the previous irda-usb patch
# --------------------------------------------
#
diff -Nru a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	Fri Sep 27 12:30:22 2002
+++ b/drivers/net/irda/irda-usb.c	Fri Sep 27 12:30:22 2002
@@ -1487,7 +1487,7 @@
 	 * specify an alternate, but very few driver do like this.
 	 * Jean II */
 	ret = usb_set_interface(dev, intf->altsetting->bInterfaceNumber, 0);
-	IRDA_DEBUG(1, "usb-irda: set interface %d result %d\n", ifnum, ret);
+	IRDA_DEBUG(1, "usb-irda: set interface %d result %d\n", intf->altsetting->bInterfaceNumber, ret);
 	switch (ret) {
 		case 0:
 			break;
