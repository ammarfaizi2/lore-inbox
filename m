Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUBSTyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUBSTyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:54:39 -0500
Received: from vsmtp1alice.tin.it ([212.216.176.141]:52705 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S267511AbUBSTux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:50:53 -0500
Date: Thu, 19 Feb 2004 20:50:39 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: USB keyboard problems
Message-Id: <20040219205039.6ba0773f.pochini@shiny.it>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linux 2.6 has some problems recognizing my keyboard. I have to disconnect
and reconnect it several times every boot. The keyboards is a Logitech
internet navigator and it worked perfectly with Linux 2.4. The keyboard is
attached to a hub, but it behaves exactly the same if I connect it directly
to the case's plug. This is the output of dmesg about two failures and a
success:


hub 2-1:1.0: new USB device on port 1, assigned address 14
bus usb: add device 2-1.1
bound device '2-1.1' to driver 'usb'
bus usb: add device 2-1.1:1.0
hid: probe of 2-1.1:1.0 failed with error -5
bus usb: add device 2-1.1:1.1
hid: probe of 2-1.1:1.1 failed with error -5
usb 2-1.1: USB disconnect, address 14
bus usb: remove device 2-1.1:1.0
bus usb: remove device 2-1.1:1.1
bus usb: remove device 2-1.1
hub 2-1:1.0: new USB device on port 1, assigned address 15
bus usb: add device 2-1.1
bound device '2-1.1' to driver 'usb'
bus usb: add device 2-1.1:1.0
hid: probe of 2-1.1:1.0 failed with error -5
bus usb: add device 2-1.1:1.1
hid: probe of 2-1.1:1.1 failed with error -5
usb 2-1.1: USB disconnect, address 15
bus usb: remove device 2-1.1:1.0
bus usb: remove device 2-1.1:1.1
bus usb: remove device 2-1.1
hub 2-1:1.0: new USB device on port 1, assigned address 16
bus usb: add device 2-1.1
bound device '2-1.1' to driver 'usb'
bus usb: add device 2-1.1:1.0
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0001:01:1b.1-1.1
bound device '2-1.1:1.0' to driver 'hid'
bus usb: add device 2-1.1:1.1
input: USB HID v1.10 Mouse [Logitech Logitech USB Keyboard] on usb-0001:01:1b.1-1.1
bound device '2-1.1:1.1' to driver 'hid'


[Giu@Jay Giu]$ uname -a
Linux Jay 2.6.2-ben1 #1 SMP Sat Feb 7 09:45:15 CET 2004 ppc unknown


--
Giuliano.

