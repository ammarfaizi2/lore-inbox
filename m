Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268281AbTGTUdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbTGTUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:33:04 -0400
Received: from 82-41-215-154.cable.ubr12.edin.blueyonder.co.uk ([82.41.215.154]:41414
	"EHLO savagelandz.cjb.net") by vger.kernel.org with ESMTP
	id S268281AbTGTUdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:33:00 -0400
From: iain@savagelandz.cjb.net
Reply-To: iain@savagelandz.cjb.net
To: linux-kernel@vger.kernel.org
Subject: Lockups with stv680 driver and kernel-2.6.0-test1
Date: Sun, 20 Jul 2003 21:47:59 +0100
User-Agent: KMail/1.5.2
Cc: iain@savagelandz.cjb.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307202147.59744.iain@savagelandz.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently bought a small cheap webcam (thought it would be fun). Anyway it 
appears to use the stv680 driver in linux. The camera works, but only for 
about 30secs then the usb controller seems to lock up as I loose the picture 
(it freezes) and I also loose the use of my mouse (usb mouse). A short while 
after this the machine generally grounds to a halt if I dont quit X to a 
console and reboot.

I have this problem in the 2.4 series of kernel to only the lockup occurs 
after about 5 secs. I did read somwhere that there are problems with the 2.4 
kernel, the mentioned driver and the KT133 chipset from Via. I have a KT266 
based motherboard which I believe is similar just a bit faster ;). Anyway I 
thought I should post here in the hopes that someone might have a solution.

Cheers

iain

p.s I have tried to include the relevent stuff below, is there anything else 
you guys need?

part of dmesg
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver 
v2.1
uhci-hcd 0000:00:11.2: VIA Technologies, In USB
uhci-hcd 0000:00:11.2: irq 5, io base 0000a800
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:11.4: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:11.4: irq 5, io base 0000b000
uhci-hcd 0000:00:11.4: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
Linux video capture interface: v1.00
registering 1-0290
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 1, assigned address 2
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 2, assigned address 3
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with 
IntelliEye(TM)] on usb-0000:00:11.4-2
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver

drivers/usb/media/stv680.c: [stv680_probe:1466] STV(i): STV0680 camera found.
drivers/usb/media/stv680.c: [stv680_probe:1497] STV(i): registered new video 
device: video0
drivers/usb/core/usb.c: registered new driver stv680
drivers/usb/media/stv680.c: [usb_stv680_init:1573] STV(i): usb camera driver 
version v0.25 registering
drivers/usb/media/stv680.c: STV0680 USB Camera Driver v0.25

lsusb
Bus 002 Device 003: ID 045e:0047 Microsoft Corp.
Bus 002 Device 002: ID 0553:0202 STMicroelectronics Imaging Division (VLSI 
Vision) Aiptek PenCam 1
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000



