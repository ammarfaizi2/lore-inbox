Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTLPA5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 19:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLPA5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 19:57:53 -0500
Received: from smtp02.ya.com ([62.151.11.132]:63153 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S264288AbTLPA5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 19:57:51 -0500
Subject: UHCI-HCD && mosedev on 2.6.0-test11
From: Carlos =?ISO-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Reply-To: lordeath@linuxspain.net
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Torrejon Wireless
Message-Id: <1071536070.12406.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Dec 2003 01:55:34 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an usbmouse that works on 2.4.x kernel series.
now on 2.6.0 usb module hangs, and does not work with it.

Tests are made on centrino laptop (00:1d.0 USB Controller: Intel Corp.
82801DB USB) on 2.6.0-test[9-11] series on gentoo linux.

Error:

Dec 16 01:41:42 kardon kernel: usb 2-2: USB disconnect, address 2
Dec 16 01:41:42 kardon kernel:  printing eip:
Dec 16 01:41:42 kardon kernel: c0159683
Dec 16 01:41:42 kardon kernel: Oops: 0000 [#1]
Dec 16 01:41:42 kardon kernel: CPU:    0
Dec 16 01:41:42 kardon kernel: EIP:    0060:[<c0159683>]    Not tainted
Dec 16 01:41:42 kardon kernel: EFLAGS: 00010296
Dec 16 01:41:42 kardon kernel: EIP is at __lookup_hash+0x1b/0xd0
Dec 16 01:41:42 kardon kernel: eax: cf411e98   ebx: 12fd28db   ecx:
ffffffff   edx: 01b9ec71
Dec 16 01:41:42 kardon kernel: esi: c03a7218   edi: 00000000   ebp:
00000000   esp: cf411e5c
Dec 16 01:41:42 kardon kernel: ds: 007b   es: 007b   ss: 0068
Dec 16 01:41:42 kardon kernel: Process khubd (pid: 2642,
threadinfo=cf410000 task=cf830cc0)
Dec 16 01:41:42 kardon kernel: Stack: c036f8c0 cf411e8c 00000000
12fd28db c03a7218 c034053c ce5ae528 c0159757
Dec 16 01:41:42 kardon kernel:        cf411e98 00000000 00000000
c017a998 cf411e98 00000000 00000282 c0340537
Dec 16 01:41:42 kardon kernel:        00000005 12fd28db 00000282
cdf5a894 ce5ae400 c017be33 00000000 c0340537
Dec 16 01:41:42 kardon kernel: Call Trace:
Dec 16 01:41:42 kardon kernel:  [<c0159757>] lookup_hash+0x1f/0x23
Dec 16 01:41:42 kardon kernel:  [<c017a998>] sysfs_get_dentry+0x6a/0x70
Dec 16 01:41:42 kardon kernel:  [<c017be33>]
sysfs_remove_group+0x65/0x6a
Dec 16 01:41:42 kardon kernel:  [<c023e662>] dpm_sysfs_remove+0x1a/0x20
Dec 16 01:41:42 kardon kernel:  [<c023e12b>] device_pm_remove+0x26/0x71
Dec 16 01:41:42 kardon kernel:  [<c023bcff>] device_del+0x65/0x9b
Dec 16 01:41:42 kardon kernel:  [<d1adfbd4>]
usb_disable_device+0xdb/0x116 [usbcore]
Dec 16 01:41:42 kardon kernel:  [<d1ad9c85>] usb_disconnect+0x9f/0x12f
[usbcore]
Dec 16 01:41:42 kardon kernel:  [<d1adc790>]
hub_port_connect_change+0x399/0x39e [usbcore]
Dec 16 01:41:42 kardon kernel:  [<d1adcb9c>] hub_events+0x407/0x470
[usbcore]
Dec 16 01:41:42 kardon kernel:  [<d1adcc32>] hub_thread+0x2d/0xf7
[usbcore]
Dec 16 01:41:42 kardon kernel:  [<c011a1f4>]
default_wake_function+0x0/0x12
Dec 16 01:41:42 kardon kernel:  [<d1adcc05>] hub_thread+0x0/0xf7
[usbcore]
Dec 16 01:41:42 kardon kernel:  [<c0107289>]
kernel_thread_helper+0x5/0xb
Dec 16 01:41:42 kardon kernel:
Dec 16 01:41:42 kardon kernel: Code: 8b 77 08 89 6c 24 08 c7 44 24 04 01
00 00 00 89 34 24 e8 30
Dec 16 01:41:42 kardon kernel:  <7>drivers/usb/host/uhci-hcd.c: efe0:
suspend_hc

Any ideas tos solve it? tnx

