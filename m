Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSLXUXn>; Tue, 24 Dec 2002 15:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265843AbSLXUXn>; Tue, 24 Dec 2002 15:23:43 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:3588
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S265830AbSLXUXm>; Tue, 24 Dec 2002 15:23:42 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Tue, 24 Dec 2002 15:33:21 -0500
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PROBLEM][2.5.52][USB] USB Device unusable
Cc: Greg KH <greg@kroah.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200212241533.21347.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* NOTE: This is -mm2. I will be compiling 2.5.53 (-mm1) today and test this as 
well.

Initial Power on of USB Device:

ehci-hcd 02:08.2: GetStatus port 2 status 001803 POWER sig=j  CSC CONNECT
hub 1-0:0: port 2, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
hub 1-0:0: port 2 not reset yet, waiting 10ms
hub 1-0:0: port 2 not reset yet, waiting 10ms
hub 1-0:0: port 2 not reset yet, waiting 200ms
ehci-hcd 02:08.2: port 2 full speed --> companion
ehci-hcd 02:08.2: GetStatus port 2 status 003801 POWER OWNER sig=j  CONNECT
drivers/usb/host/ehci-hcd.c: 02:08.2: free_config devnum 0
drivers/usb/host/ohci-hub.c: 02:08.1: GetStatus roothub.portstatus [1] =
0x00010101 CSC PPS CCS
hub 3-0:0: port 1, status 101, change 1, 12 Mb/s
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
drivers/usb/host/ohci-hub.c: 02:08.1: GetStatus roothub.portstatus [1] = 
0x00100103 PRSC PPS PES CCS
hub 3-0:0: new USB device on port 1, assigned address 4
drivers/usb/core/usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Product: JamC@m 2.? OR JamC@m 2.0 OR JamC@m 2.0__________ depending on 
connection quality (?)
Manufacturer: KBGear Interactive
drivers/usb/core/usb.c: usb_new_device - registering 3-1:0

When attempting to configure device:

drivers/usb/core/usb.c: usbfs driver claimed interface d0447c80
drivers/usb/host/ohci-q.c: urb cf17e0c0 usb-02:08.1-1 ep-0-OUT cc 4 --> status 
-32
usbfs: USBDEVFS_CONTROL failed dev 5 rqt 64 rq 165 len 0 ret -32
drivers/usb/host/ohci-q.c: urb cf17e0c0 usb-02:08.1-1 ep-1-IN cc 8 --> status 
-75
usbfs: USBDEVFS_BULK failed dev 5 ep 0x81 len 12 ret -75

>From the Userland side we get errors and a failure 'Error Reading from port'


