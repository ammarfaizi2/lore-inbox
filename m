Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUEKGpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUEKGpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKGnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:43:19 -0400
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:21650 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262902AbUEKGke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:40:34 -0400
Message-ID: <01ab01c43722$caafc870$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: OOPS - 2.6.6 - using modules
Date: Mon, 10 May 2004 23:40:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting up the system is fine, the initrd loads the modules no problem,
but as soon as the network script starts and inserts the tulip module, I get
the following error: I am using GCC 3.4.0, glibc 05-02-2004, and binutils
2.15.0.0.3. If I disable the network script, it boots until it gets to
hotplug, which trys to load the usb driver, and I get a similar message, but
instead of saying tulip, it says uhci-hcd.

May 10 23:04:13 linux Unable to handle kernel paging request at virtual
address e3920e98
May 10 23:04:13 linux printing eip:
May 10 23:04:13 linux c01a2d27
May 10 23:04:13 linux *pde = 015bc067
May 10 23:04:13 linux *pte = 00000000
May 10 23:04:13 linux Oops: 0002 [#1]
May 10 23:04:13 linux PREEMPT
May 10 23:04:13 linux CPU: 0
May 10 23:04:13 linux EIP: 0060:[<c01a2d27>] Not tainted
May 10 23:04:13 linux EFLAGS: 00010292 (2.6.6-lfs-3)
May 10 23:04:13 linux EIP is at kobject_add+0x77/0x110
May 10 23:04:13 linux eax: c02b2ee0 ebx: e38eaffc ecx: e3920e98 edx:
e38eb018
May 10 23:04:13 linux esi: ffffffea edi: c02b2ee8 ebp: e38eafe4 esp:
decf3f1c
May 10 23:04:13 linux ds: 007b es: 007b ss: 0068
May 10 23:04:13 linux Process modprobe (pid: 499, threadinfo=decf2000
task=df782090)
May 10 23:04:13 linux Stack: c02b2ee8 e38eaffc e38eaffc ffffffea 00000000
c01a2de8 e38eaffc e38eaffc
May 10 23:04:13 linux c02b2e80 e38eaffc c02b2e80 c01d333a e38eaffc e38e6eda
e38eafc0 00000000
May 10 23:04:13 linux e38eb058 c0283f9c c01d37bf e38eafe4 00000400 e38e6f71
decf3f9c e38ddf74
May 10 23:04:13 linux Call Trace:
May 10 23:04:13 linux [<c01a2de8>] kobject_register+0x28/0x70
May 10 23:04:13 linux [<c01d333a>] bus_add_driver+0x4a/0xc0
May 10 23:04:13 linux [<c01d37bf>] driver_register+0x2f/0x40
May 10 23:04:13 linux [<c01aa8ec>] pci_register_driver+0x5c/0x90
May 10 23:04:13 linux [<e3844038>] tulip_init+0x38/0x46 [tulip]
May 10 23:04:13 linux [<c012cd3f>] sys_init_module+0x11f/0x250
May 10 23:04:13 linux [<c0105ab9>] sysenter_past_esp+0x52/0x71
May 10 23:04:13 linux
May 10 23:04:13 linux Code: 89 11 89 4a 04 8b 43 28 8b 30 8d 4e 48 89 c8 ba
ff ff 00 00

----
Jim Gifford
maillist@jg555.com

