Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSL3JCF>; Mon, 30 Dec 2002 04:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSL3JCE>; Mon, 30 Dec 2002 04:02:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30734 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266810AbSL3JBY>;
	Mon, 30 Dec 2002 04:01:24 -0500
Date: Mon, 30 Dec 2002 01:04:56 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] minor TTY changes for 2.5.53
Message-ID: <20021230090456.GD29926@kroah.com>
References: <20021230090221.GA29926@kroah.com> <20021230090303.GB29926@kroah.com> <20021230090409.GC29926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230090409.GC29926@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.956.3.3, 2002/12/29 23:42:02-08:00, greg@kroah.com

TTY: Use the tty_devclass for all usb-serial devices.


diff -Nru a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
--- a/drivers/usb/serial/bus.c	Mon Dec 30 01:04:42 2002
+++ b/drivers/usb/serial/bus.c	Mon Dec 30 01:04:42 2002
@@ -128,6 +128,7 @@
 	device->driver.bus = &usb_serial_bus_type;
 	device->driver.probe = usb_serial_device_probe;
 	device->driver.remove = usb_serial_device_remove;
+	device->driver.devclass = &tty_devclass;
 
 	retval = driver_register(&device->driver);
 
