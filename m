Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310143AbSCAWnd>; Fri, 1 Mar 2002 17:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310142AbSCAWnX>; Fri, 1 Mar 2002 17:43:23 -0500
Received: from ns0.petreley.net ([64.170.109.178]:57230 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S310141AbSCAWnH>;
	Fri, 1 Mar 2002 17:43:07 -0500
Date: Fri, 1 Mar 2002 14:43:04 -0800
From: Nicholas Petreley <nicholas@petreley.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre1-ac2 and 2.5.5-dj2 USB issues
Message-ID: <20020301224304.GA5399@petreley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.5.5-dj2 and 2.4.19-pre1-ac2, my USB mouse is no longer detected at
boot.  If, after boot, I pull the plug on the mouse and then put it back in,
the system detects it.  This only started with the kernel versions mentioned
above.  It still works fine with 2.4.19-pre1-ac1, for example, and I believe
it worked fine with 2.5.5-dj1 (but I deleted that kernel so I can't test it
again).

I'm using Debian unstable branch, with hotplug installed, and a MiniView USB
KVM which is reported as a USB hub. 

Here are the messages at boot with 2.5.5-dj2.

usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 7
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found at /
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.31:USB HID core driver
hub.c: new USB device on bus 1 path /2, assigned address 2
hub.c: USB hub found at /2
hub.c: 4 ports detected
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
hub.c: connect-debounce failed, port 1 disabled
usb-uhci.c: ENXIO 80000200, flags 0, urb db922d40, burb db922cc0
hub.c: cannot disable port 1 of hub /2 (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: get_hub_status /2 failed
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: usb_hub_port_status(/2) failed (err = -6)
usb-uhci.c: ENXIO 80000280, flags 0, urb db922d40, burb db922cc0
hub.c: get_hub_status /2 failed
hub.c: new USB device on bus 1 path /2/2, assigned address 3
usb-uhci.c: ENXIO 80000300, flags 0, urb db7e20c0, burb db922f40

-Nick

-- 
***********************************************************
Nicholas Petreley        http://www.VarLinux.org
nicholas@petreley.com    http://www.computerworld.com
http://www.petreley.org  http://www.linuxworld.com Eph 6:12
***********************************************************
