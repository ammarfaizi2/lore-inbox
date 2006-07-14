Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWGNLaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWGNLaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWGNLaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:30:23 -0400
Received: from tornado.reub.net ([202.89.145.182]:59883 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1161075AbWGNLaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:30:22 -0400
Message-ID: <44B7804E.4030908@reub.net>
Date: Fri, 14 Jul 2006 23:30:22 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060713)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.18-rc1-mm2
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2006 5:48 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/
> 
> - Patches were merged, added, dropped and fixed.  Nothing particularly exciting.
> 
> - Added the avr32 architecture.  Review is sought, please.

Another oops, USB related perhaps?

Fedora Core release 5.90 (Test)
Kernel 2.6.18-rc1-mm2 on an x86_64

tornado.reub.net login: Unable to handle kernel NULL pointer dereference at 
0000000000000020 RIP:
  [<ffffffff8029a9b1>] __lock_acquire+0x81/0xcbb
PGD 27153067 PUD 27152067 PMD 0
Oops: 0000 [1] SMP
last sysfs file: /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/usbdev2.4/dev
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre iptable_filter 
iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle ip_tables binfmt_misc 
iTCO_wdt i2c_i801 serio_raw
Pid: 104, comm: khubd Not tainted 2.6.18-rc1-mm2 #1
RIP: 0010:[<ffffffff8029a9b1>]  [<ffffffff8029a9b1>] __lock_acquire+0x81/0xcbb
RSP: 0018:ffff81003f2ddc98  EFLAGS: 00010046
RAX: 0000000000000002 RBX: 0000000000000246 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff81003f2ddd08 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff80488338 R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff805ac760 R14: ffff810037f96140 R15: 0000000000000018
FS:  0000000000000000(0000) GS:ffffffff808af000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000020 CR3: 000000002725c000 CR4: 00000000000006e0
Process khubd (pid: 104, threadinfo ffff81003f2dc000, task ffff810037f96140)
Stack:  ffffffff80263d05 0000000000000246 ffff81003ec0f4f0 ffff810012202370
  000000003f2ddcd8 0000000000000002 0000000000000000 ffff81003ec0f4e8
  ffff81003f2ddd08 0000000000000246 0000000000000000 ffffffff805ac760
Call Trace:
  [<ffffffff8029b63a>] lock_acquire+0x4f/0x75
  [<ffffffff802654fa>] _spin_lock+0x25/0x34
  [<ffffffff80488338>] klist_remove+0x15/0x36
  [<ffffffff803b63fe>] bus_remove_device+0xa7/0xc9
  [<ffffffff803b4d4d>] device_del+0x162/0x195
  [<ffffffff803f5b96>] usb_disconnect+0xbb/0x10e
  [<ffffffff803f69df>] hub_thread+0x3ff/0xc36
  [<ffffffff802332a3>] kthread+0xd3/0x100
  [<ffffffff802602f2>] child_rip+0x8/0x12

Code: 49 8b 5f 08 48 85 db 0f 85 4e 03 00 00 49 83 3f 00 75 03 4d
RIP  [<ffffffff8029a9b1>] __lock_acquire+0x81/0xcbb
  RSP <ffff81003f2ddc98>
CR2: 0000000000000020

I didn't see this one but more than likely it happened when my 2 yr old hit the 
KVM "change console" button (it's a USB KVM and there are no other USB devices 
on the system).

Reuben
