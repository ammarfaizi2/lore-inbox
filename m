Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVBGQnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVBGQnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVBGQnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:43:51 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:40252 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261184AbVBGQns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:43:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=SO1SrG3ZoGTQCNyiVJ1JCQR+AWftjLi4MSSN+ifzPUt6VwLhovuQbWbLjFrQMH7YTz+QU6HBggw6ur3TPMCyKmkGw/U9O16sXucpKTaEqL7pHZT7qrmsnKm/7B9rF86ae+fgqxgPrsoX1PtmiZMpOIIH9Xp3htxLwWSreJhdxMQ=
Date: Mon, 7 Feb 2005 17:46:08 +0100
From: Mikkel Krautz <krautz@gmail.com>
To: rddunlap@osdl.org
Cc: vojtech@ucw.cz, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling Interval
Message-ID: <20050207164608.GA5663@omnipotens.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Why is it writable by root?  IOW, will writing a new value to it
> change the operational value dynamically?

Yes, sort of. It requires a re-plug of the mouse, though. :)

> Also, from the kernel-parameters.txt patch:
> (a) "which"
> (b) drop one of the "at"s... either one.

Oops, thanks!

Here's an updated version of the kernel-parameters patch:

Signed-off-by: Mikkel Krautz <krautz@gmail.com>
---
--- clean/Documentation/kernel-parameters.txt
+++ dirty/Documentation/kernel-parameters.txt
@@ -73,6 +73,7 @@
 	SWSUSP	Software suspension is enabled.
 	TS	Appropriate touchscreen support is enabled.
 	USB	USB support is enabled.
+	USBHID	USB Human Interface Device support is enabled.
 	V4L	Video For Linux support is enabled.
 	VGA	The VGA console has been enabled.
 	VT	Virtual terminal support is enabled.
@@ -1393,6 +1394,9 @@
 			Format: <io>,<irq>
 
 	usb-handoff	[HW] Enable early USB BIOS -> OS handoff
+
+	usbhid.mousepoll=
+			[USBHID] The interval which mice are to be polled at.
  
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.


