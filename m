Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSJAIo4>; Tue, 1 Oct 2002 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbSJAIo4>; Tue, 1 Oct 2002 04:44:56 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:39088 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261545AbSJAIox>; Tue, 1 Oct 2002 04:44:53 -0400
Subject: bug in 2.4.19: USB device not accepting new address=12 (error=-110)
From: Soeren Sonnenburg <sonnenburg@informatik.hu-berlin.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 01 Oct 2002 10:44:22 +0200
Message-Id: <1033461863.12761.10.camel@sun>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Since the upgrade from 2.4.18 to .19 the following problem with usb
occurs:
First of all my setup is an k7v mainboard to which an usb hub of a ctx
monitor is attached. On that Monitor's usb hub a usb mouse is attached.

When I turn off the monitor and thus disconnect both the usb-mouse and
the monitor and turn the monitor back on *sometimes* the mouse's power
is not toggled back on (in most cases it just works fine).

In the syslog I observe these messages (this is a monitor switch on,
switch off, switch on,... session).

Since the usb driver got updated in 2.4.19 a suspect the bug to be
there.

Sorry if this is already known for quite some time,
Soeren.

Sep 30 20:50:44 zeus kernel: uhci.c: d400: wakeup_hc
Sep 30 20:50:44 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 49b data: 4
Sep 30 20:50:44 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:50:44 zeus kernel: hub.c: port 2, portstatus 101, change 3, 12 Mb/s
Sep 30 20:50:44 zeus kernel: hub.c: port 2 connection change
Sep 30 20:50:44 zeus kernel: hub.c: port 2, portstatus 101, change 3, 12 Mb/s
Sep 30 20:50:44 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:50:44 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:50:44 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 499 data: 4
Sep 30 20:50:44 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:50:45 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:50:45 zeus kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Sep 30 20:50:45 zeus kernel: hub.c: USB new device connect on bus1/2, assigned device number 11
Sep 30 20:50:49 zeus kernel: usb_control/bulk_msg: timeout
Sep 30 20:50:49 zeus kernel: usb.c: USB device not accepting new address=11 (error=-110)
Sep 30 20:50:49 zeus kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Sep 30 20:50:49 zeus kernel: hub.c: USB new device connect on bus1/2, assigned device number 12
Sep 30 20:50:53 zeus kernel: usb_control/bulk_msg: timeout
Sep 30 20:50:53 zeus kernel: usb.c: USB device not accepting new address=12 (error=-110)
Sep 30 20:50:53 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:50:53 zeus kernel: hub.c: port 2, portstatus 101, change 0, 12 Mb/s
Sep 30 20:52:00 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 48a data: 4
Sep 30 20:52:00 zeus kernel: uhci.c: d400: suspend_hc
Sep 30 20:52:00 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:00 zeus kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Sep 30 20:52:00 zeus kernel: hub.c: port 2 connection change
Sep 30 20:52:00 zeus kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Sep 30 20:52:00 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 488 data: 4
Sep 30 20:52:00 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:00 zeus kernel: hub.c: port 2, portstatus 100, change 2, 12 Mb/s
Sep 30 20:52:00 zeus kernel: hub.c: port 2 enable change, status 100
Sep 30 20:52:03 zeus kernel: uhci.c: d400: wakeup_hc
Sep 30 20:52:03 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 49b data: 4
Sep 30 20:52:03 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:03 zeus kernel: hub.c: port 2, portstatus 101, change 3, 12 Mb/s
Sep 30 20:52:03 zeus kernel: hub.c: port 2 connection change
Sep 30 20:52:03 zeus kernel: hub.c: port 2, portstatus 101, change 3, 12 Mb/s
Sep 30 20:52:03 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:04 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:04 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 499 data: 4
Sep 30 20:52:04 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:04 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:04 zeus kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Sep 30 20:52:04 zeus kernel: hub.c: USB new device connect on bus1/2, assigned device number 13
Sep 30 20:52:08 zeus kernel: usb_control/bulk_msg: timeout
Sep 30 20:52:08 zeus kernel: usb.c: USB device not accepting new address=13 (error=-110)
Sep 30 20:52:08 zeus kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Sep 30 20:52:08 zeus kernel: hub.c: USB new device connect on bus1/2, assigned device number 14
Sep 30 20:52:12 zeus kernel: usb_control/bulk_msg: timeout
Sep 30 20:52:12 zeus kernel: usb.c: USB device not accepting new address=14 (error=-110)
Sep 30 20:52:12 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:12 zeus kernel: hub.c: port 2, portstatus 101, change 0, 12 Mb/s
Sep 30 20:52:19 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 48a data: 4
Sep 30 20:52:19 zeus kernel: uhci.c: d400: suspend_hc
Sep 30 20:52:19 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:19 zeus kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Sep 30 20:52:19 zeus kernel: hub.c: port 2 connection change
Sep 30 20:52:19 zeus kernel: hub.c: port 2, portstatus 100, change 3, 12 Mb/s
Sep 30 20:52:19 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 488 data: 4
Sep 30 20:52:19 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:19 zeus kernel: hub.c: port 2, portstatus 100, change 2, 12 Mb/s
Sep 30 20:52:19 zeus kernel: hub.c: port 2 enable change, status 100
Sep 30 20:52:22 zeus kernel: uhci.c: d400: wakeup_hc
Sep 30 20:52:23 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 49b data: 4
Sep 30 20:52:23 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 101, change 3, 12 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: port 2 connection change
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 101, change 3, 12 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:23 zeus kernel: uhci.c: root-hub INT complete: port1: 580 port2: 499 data: 4
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 101, change 2, 12 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Sep 30 20:52:23 zeus kernel: hub.c: USB new device connect on bus1/2, assigned device number 15
Sep 30 20:52:27 zeus kernel: usb_control/bulk_msg: timeout
Sep 30 20:52:27 zeus kernel: usb.c: USB device not accepting new address=15 (error=-110)
Sep 30 20:52:27 zeus kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
Sep 30 20:52:27 zeus kernel: hub.c: USB new device connect on bus1/2, assigned device number 16
Sep 30 20:52:31 zeus kernel: usb_control/bulk_msg: timeout
Sep 30 20:52:31 zeus kernel: usb.c: USB device not accepting new address=16 (error=-110)
Sep 30 20:52:31 zeus kernel: hub.c: port 1, portstatus 300, change 0, 1.5 Mb/s
Sep 30 20:52:31 zeus kernel: hub.c: port 2, portstatus 101, change 0, 12 Mb/

