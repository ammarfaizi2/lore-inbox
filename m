Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262183AbTCWAqX>; Sat, 22 Mar 2003 19:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262186AbTCWAqX>; Sat, 22 Mar 2003 19:46:23 -0500
Received: from franka.aracnet.com ([216.99.193.44]:38530 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262183AbTCWAqW>; Sat, 22 Mar 2003 19:46:22 -0500
Date: Sat, 22 Mar 2003 16:57:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 488] New: host controller halted after unplugging usb mouse 
Message-ID: <369620000.1048381042@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=488

           Summary: host controller halted after unplugging usb mouse
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: kc0@hotmail.com


Distribution: Debian sid, kernel 2.5.65
Hardware Environment: toshiba satellite pro 6100
Software Environment: debian hotplug package Version: 0.0.20030117-4
Problem Description: This laptop has 2 USB ports. At boot time the mouse was
already plugged in in one of the ports. Works fine. Then I unplugged it and put
it in the other port. The mouse didn't work, so I unplugged it again and put it
back in the port where it was plugged in at boottime. Now the mouse works again.
So it's not really bothering me, but it's still a bug to report.

This is what I found in the logs:
[After stripping the usual: atkbd.c: Unknown key (set 2, scan.... errors ]

usb 1-1: USB disconnect, address 2
drivers/usb/input/hid-core.c: can't resubmit intr, 00:1d.0-1/input0, status -19
drivers/usb/host/uhci-hcd.c: efe0: host controller halted. very bad
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 3
input: USB HID v1.10 Mouse [Microsoft Microsoft 5-Button Mouse with
IntelliEye(TM)] on usb-00:1d.0-1

Steps to reproduce:


