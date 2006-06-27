Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161249AbWF0SRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249AbWF0SRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161248AbWF0SRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:17:01 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:29384 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161247AbWF0SQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:16:59 -0400
From: Foli Ayivoh <it21@arcor.de>
Reply-To: 101551.753@compuserve.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: Problems with [USB] on Kernel 2.6.x [1/3]
Date: Tue, 27 Jun 2006 20:18:45 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606272018.45688.it21@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two issues on USB:

First:
USB-HDD boot device hangs
Tested with Kernel 2.6.16.13-4 (SuSE), Kernel 2.6.17, Kernel 2.6.17-mm2, Kernel 2.6.17-mm3
it works, it hangs, it gets reseted, it works again until next hang, and on ...
The only hint in dmesg is:
usb 1-2.7: reset high speed USB device using ehci_hcd and address 6
The USB-HDD device works fine if connected as USB-HDD device, not as USB-HDD _boot_ device,
tested with Kernel 2.6.16.13-4 (SuSE) on different mainboard, booting not tested

Second:
Not ending USB device disconnect and reconnect
Tested with Kernel 2.6.16.13-4 (SuSE), it works fine
Tested with Kernel 2.6.17, Kernel 2.6.17-mm2, Kernel 2.6.17-mm3
dmesg shows:
usb 2-1.1: new low speed USB device using ohci_hcd and address 100
usb 2-1.1: new device found, idVendor=046a, idProduct=0023
usb 2-1.1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1.1: configuration #1 chosen from 1 choice
input: HID 046a:0023 as /class/input/input195
input: USB HID v1.11 Keyboard [HID 046a:0023] on usb-0000:00:02.0-1.1
/home/testit/kernel-source/linux-2.6.17/drivers/usb/input/hid-core.c: ctrl urb status -110 received
input: HID 046a:0023 as /class/input/input196
input: USB HID v1.11 Device [HID 046a:0023] on usb-0000:00:02.0-1.1
usb 2-1.1: reset low speed USB device using ohci_hcd and address 100
usb 2-1.1: failed to restore interface 0 altsetting 0 (error=-110)
usb 2-1.1: USB disconnect, address 100
usb 2-1.1: new low speed USB device using ohci_hcd and address 101
...
and on
