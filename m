Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbTC0Lyr>; Thu, 27 Mar 2003 06:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbTC0Lyr>; Thu, 27 Mar 2003 06:54:47 -0500
Received: from jessie.softnet.si ([212.103.128.68]:45709 "EHLO softnet.si")
	by vger.kernel.org with ESMTP id <S261935AbTC0Lyi>;
	Thu, 27 Mar 2003 06:54:38 -0500
Date: Thu, 27 Mar 2003 13:05:46 +0100
From: Damjan Bole <damjanbole@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre6: usb ports/mouse not detected
Message-Id: <20030327130546.1f1d6d1f.damjanbole@gmx.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Switching from 2.4.21pre5 to pre6 I've found out my usb mouse is dead and no usb port is detected on my msi kt266pro2. I used same (make oldconfig) as in pre5. I included dmesg logs below. 
regards



Here's pre6 dmesg part wih missing port detection:
...
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 256k freed
Adding Swap: 353420k swap-space (priority -1)
...


And here is dmesg from pre5:
...
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 13:00:46 Mar 22 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 12
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 256k freed
hub.c: new USB device 00:11.2-2, assigned address 2
input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb3:2.0
Adding Swap: 353420k swap-space (priority -1)
...
