Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSJKOHj>; Fri, 11 Oct 2002 10:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSJKOHj>; Fri, 11 Oct 2002 10:07:39 -0400
Received: from holomorphy.com ([66.224.33.161]:13441 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262464AbSJKOHe>;
	Fri, 11 Oct 2002 10:07:34 -0400
Date: Fri, 11 Oct 2002 07:10:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: remove unused variable in wacom driver
Message-ID: <20021011141001.GO12432@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wacom.c generates the following warning:

drivers/usb/input/wacom.c: In function `wacom_probe':
drivers/usb/input/wacom.c:405: warning: unused variable `rep_data'


--- akpm-2.5.41-3/drivers/usb/input/wacom.c	2002-10-11 06:09:32.000000000 -0700
+++ wli-2.5.41-3/drivers/usb/input/wacom.c	2002-10-11 06:52:36.000000000 -0700
@@ -402,7 +402,6 @@
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_endpoint_descriptor *endpoint;
 	struct wacom *wacom;
-	char rep_data[2] = {0x02, 0x02};
 	char path[64];
 
 	if (!(wacom = kmalloc(sizeof(struct wacom), GFP_KERNEL)))
