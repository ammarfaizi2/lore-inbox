Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268544AbTANDce>; Mon, 13 Jan 2003 22:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268548AbTANDce>; Mon, 13 Jan 2003 22:32:34 -0500
Received: from [65.102.248.137] ([65.102.248.137]:62426 "EHLO aesaeion.com")
	by vger.kernel.org with ESMTP id <S268544AbTANDcd>;
	Mon, 13 Jan 2003 22:32:33 -0500
Date: Tue, 14 Jan 2003 04:10:19 -0700 (MST)
From: kosh@aesaeion.com
To: linux-kernel@vger.kernel.org
Subject: usb-uhci host controller halted 2.5.56
Message-ID: <Pine.LNX.4.44.0301140400350.16161-100000@aesaeion.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting this error

drivers/usb/host/uhci-hcd.c: dc00: host controller process error.
something bad happened
drivers/usb/host/uhci-hcd.c: dc00: host controller halted. very bad
usb 1-1: USB disconnect, address 2
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 3
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-00:0d.0-1

What happens is that the mouse just turns off but it will work again if I
unplug it and plug it back in again. When I first start up 2.5.56 it will
often work for a few hours up to about 16 hours before usb will just start
having those error messages. However once that happens and I unplug the
mouse and plug it back in again the problem will happen every minute or
so.

It is a VIA kt333 chipset with a usb mouseman wheel logitech optical mouse

This issue does not happen under any 2.4.x kernel.

Also this board has both an UHCI and an EHCI controller and if I compile
support for the EHCI and UHCI controllers into a 2.5 series kernel when
the host controller halts like that unplugging the mouse and plugging it back in
again does not work. Under a 2.4 kernel both UHCI and EHCI controllers can
be enabled and working without these problems.

Thanks

