Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263432AbSJGVaH>; Mon, 7 Oct 2002 17:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263433AbSJGVaG>; Mon, 7 Oct 2002 17:30:06 -0400
Received: from oracle.uk.clara.net ([195.8.69.94]:61969 "EHLO
	oracle.uk.clara.net") by vger.kernel.org with ESMTP
	id <S263432AbSJGV36>; Mon, 7 Oct 2002 17:29:58 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
X-no-productlinks: yes
Subject: USB Hub failure in 2.5.40/2.5.41
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-15
NNTP-Posting-Host: daria.co.uk
Message-ID: <817.3da1fdfd.b21a0@trespassersw.daria.co.uk>
Date: Mon, 07 Oct 2002 21:34:53 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unable to access any USB devices on a 4 port USB hub in 2.5; it
works fine in 2.4.

Initially /proc/bus/usb/devices will list all devices, including those
(printer,scanner,camera) on the hub as well as the directly connected
USB mouse.

A simple program to open the scanner device gives:

 Unable to open scanner device: No such device

Unplugging/Plugging the hub or its devices gives a load of log
messages like:

drivers/usb/core/hub.c: usb_hub_port_status(00:07.2-1) failed (err = -110)
drivers/usb/core/hub.c: new USB device 00:07.2-1.3, assigned address 6
drivers/usb/image/scanner.c: probe_scanner: User specified USB scanner -- Vendor:Product - 4b8:110
drivers/usb/core/hub.c: usb_hub_port_status(00:07.2-1) failed (err = -110)
drivers/usb/core/hub.c: usb_hub_port_status(00:07.2-1) failed (err = -110)
drivers/usb/core/hub.c: usb_hub_port_status(00:07.2-1) failed (err = -110)
drivers/usb/core/hub.c: usb_hub_port_status(00:07.2-1) failed (err = -110)

Is this a known problem ? Further info on request. Back to 2.4, where
it all works.

