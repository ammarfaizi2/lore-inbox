Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265046AbUELNNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbUELNNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 09:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265045AbUELNNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 09:13:33 -0400
Received: from beholder.math.fu-berlin.de ([160.45.44.200]:35201 "EHLO
	beholder.fefe.de") by vger.kernel.org with ESMTP id S265043AbUELNNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 09:13:31 -0400
Date: Wed, 12 May 2004 15:13:06 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 breaks my Logitech USB mouse
Message-ID: <20040512131306.GA241@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting into 2.6.6 (compiled with gcc 3.4, could that be the
problem?), my USB mouse does not work any more.  Neither hot nor cold
plugging it works.  USB detects a low speed device and then hangs.

Now I am used to USB not working at all under Linux on my desktop with
VIA chipset, but now USB is also hosed for Intel chipsets?  Here is the
dmesg from 2.6.5, where my USB mouse still worked:

  drivers/usb/core/usb.c: registered new driver usbfs
  drivers/usb/core/usb.c: registered new driver hub
  USB Universal Host Controller Interface driver v2.2
  PCI: Found IRQ 10 for device 0000:00:1f.2
  PCI: Sharing IRQ 10 with 0000:02:0f.0
  PCI: Sharing IRQ 10 with 0000:02:0f.1
  PCI: Sharing IRQ 10 with 0000:02:0f.2
  uhci_hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub #1)
  PCI: Setting latency timer of device 0000:00:1f.2 to 64
  uhci_hcd 0000:00:1f.2: irq 10, io base 0000bce0
  uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 2 ports detected
  drivers/usb/core/usb.c: registered new driver hiddev
  drivers/usb/core/usb.c: registered new driver hid
  drivers/usb/input/hid-core.c: v2.0:USB HID core driver
  usb 1-1: new low speed USB device using address 2
  input: USB HID v1.10 Mouse [B16_b_02 USB-PS/2 Optical Mouse] on usb-0000:00:1f.2-1
  drivers/usb/input/hid-input.c: event field not found
  drivers/usb/input/hid-input.c: event field not found
  drivers/usb/input/hid-input.c: event field not found
  drivers/usb/input/hid-input.c: event field not found
  drivers/usb/input/hid-input.c: event field not found
  drivers/usb/input/hid-input.c: event field not found

2.6.6 never reaches the "input: " line.  What gives?

Felix
