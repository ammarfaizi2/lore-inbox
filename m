Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBWNjz>; Fri, 23 Feb 2001 08:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbRBWNjf>; Fri, 23 Feb 2001 08:39:35 -0500
Received: from felix.convergence.de ([212.84.236.131]:25992 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129116AbRBWNjS>;
	Fri, 23 Feb 2001 08:39:18 -0500
Date: Fri, 23 Feb 2001 14:40:04 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB and 2.4.2: "uhci: host system error, PCI problems?"
Message-ID: <20010223144004.A30274@convergence.de>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the log.

Feb 23 14:35:53 hellhound kernel: usb.c: registered new driver usb_mouse
Feb 23 14:35:53 hellhound kernel: PCI: Found IRQ 12 for device 00:07.2
Feb 23 14:35:53 hellhound kernel: PCI: The same IRQ used for device 00:07.3
Feb 23 14:35:53 hellhound kernel: PCI: The same IRQ used for device 00:0b.0
Feb 23 14:35:53 hellhound kernel: uhci.c: USB UHCI at I/O 0xa400, IRQ 12
Feb 23 14:35:53 hellhound kernel: uhci.c: detected 2 ports
Feb 23 14:35:53 hellhound kernel: usb.c: new USB bus registered, assigned bus number 1
Feb 23 14:35:53 hellhound kernel: hub.c: USB hub found
Feb 23 14:35:53 hellhound kernel: hub.c: 2 ports detected
Feb 23 14:35:53 hellhound kernel: PCI: Found IRQ 12 for device 00:07.3
Feb 23 14:35:53 hellhound kernel: PCI: The same IRQ used for device 00:07.2
Feb 23 14:35:53 hellhound kernel: PCI: The same IRQ used for device 00:0b.0
Feb 23 14:35:53 hellhound kernel: uhci.c: USB UHCI at I/O 0xa800, IRQ 12
Feb 23 14:35:53 hellhound kernel: uhci.c: detected 2 ports
Feb 23 14:35:53 hellhound kernel: usb.c: new USB bus registered, assigned bus number 2
Feb 23 14:35:53 hellhound kernel: hub.c: USB hub found
Feb 23 14:35:53 hellhound kernel: hub.c: 2 ports detected
Feb 23 14:35:53 hellhound usbmgr[2819]: start 0.4.4
Feb 23 14:35:53 hellhound kernel: usb.c: registered new driver hid
Feb 23 14:35:53 hellhound kernel: mice: PS/2 mouse device common for all mice
Feb 23 14:35:53 hellhound insmod: Note: /etc/modules.conf is more recent than /lib/modules/2.4.2-fefe1/modules.dep
Feb 23 14:35:53 hellhound usbmgr[2821]: "hid" was loaded
Feb 23 14:35:53 hellhound usbmgr[2821]: "mousedev" was loaded
Feb 23 14:35:53 hellhound usbmgr[2821]: open error "host"
Feb 23 14:35:53 hellhound usbmgr[2824]: mount /proc/bus/usb
Feb 23 14:35:53 hellhound kernel: uhci.c: root-hub INT complete: port1: 5ab port2: 58a data: 6
Feb 23 14:35:53 hellhound kernel: hub.c: USB new device connect on bus1/1, assigned device number 22
Feb 23 14:35:53 hellhound kernel: uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
Feb 23 14:35:53 hellhound kernel: mouse0: PS/2 mouse device for input0
Feb 23 14:35:53 hellhound kernel: input0: Logitech USB Mouse on usb1:22.0
Feb 23 14:35:53 hellhound kernel: uhci.c: root-hub INT complete: port1: 5a5 port2: 588 data: 4
Feb 23 14:35:54 hellhound kernel: uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
Feb 23 14:35:54 hellhound usbmgr[2821]: class:0x9 subclass:0x0 protocol:0x0
Feb 23 14:35:54 hellhound kernel: uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
Feb 23 14:35:54 hellhound usbmgr[2821]: USB device is matched the configuration
Feb 23 14:35:54 hellhound usbmgr[2821]: "none" isn't loaded
Feb 23 14:35:54 hellhound usbmgr[2821]: vendor:0x46d product:0xc00c
Feb 23 14:35:54 hellhound usbmgr[2821]: class:0x3 subclass:0x1 protocol:0x2
Feb 23 14:35:54 hellhound usbmgr[2821]: USB device is matched the configuration
Feb 23 14:35:54 hellhound kernel: uhci: host system error, PCI problems?
Feb 23 14:35:54 hellhound kernel: uhci: host controller halted. very bad


Any ideas?  It's a VIA based Athlon board.  Worked fine with 2.4.0 and
2.4.1.  The only change was that I added rivafb, which finally adds
Geforce support in 2.4.2.  /proc/interrupts does not show any interrupts
assigned to rivafb, maybe there is a conflict?


           CPU0
  0:     457839          XT-PIC  timer
  1:      24705          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     156420          XT-PIC  eth0
  8:          0          XT-PIC  rtc
 11:         26          XT-PIC  ncr53c8xx
 12:       5232          XT-PIC  usb-uhci, usb-uhci
 14:      17610          XT-PIC  ide0
 15:       2441          XT-PIC  ide1
NMI:          0
ERR:          0


Felix
