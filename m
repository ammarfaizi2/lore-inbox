Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUHACSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUHACSz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 22:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUHACSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 22:18:55 -0400
Received: from ee.oulu.fi ([130.231.61.23]:49826 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264857AbUHACSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 22:18:53 -0400
Date: Sun, 1 Aug 2004 05:18:52 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: Oops in idepnp_probe -> sysfs_hash_and_remove with pnpbios turned on
Message-ID: <20040801021852.GA3769@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya

I get this oops on boot when booting a kernel with pnpbios turned on
on a old thinkpad 600. BIOS seems to be pretty broken on this one, so that
might be a partial cause. Kernel is a pretty recentish fedora devel one
so it's basically 2.6.8-rc2'ish in case that matters. 

Might contain a few typos, couldn't get a readable photo :-(

Unable to handle kernel NULL pointer derference at virtual address 00000020
printing eip:
021a5e21
*pde = 00000000
Oops: 00008319
Modules linked in:
CPU: 0
EIP: 0060:[<021a5e21>] Not tainted
EFLAGS: 000102556 (2.6.7-1.492custom)
EIP is at sysfs_hash_and_remove+0xf/0x1ce
eax: 00000000 ebx: 023f8e74 ecx: 00000000 edx: 00000077
esi: 0235cf10 edi: 023f8e9c ebp: 0000000 esp: 0ff61e68
ds: 007b es:007b ss:0068
Process swapper (pid:1, threadinfo=0ff61000 task=0ff4f830)
Stack: 023f8e74 0235cf10 023f8e74 0fd754c4 ...
Call trace:
0222ff4a device_release_driver+0x16/0x46
0223014c bus_remove_device+0x5c/0x95
device_del+0x6d/0x8e
device_unregister+0x8/0x10
ide_unregister+0x410/0x7c3
ide_register_hw+0xa7(0x141
idepnp_probe+0x8c/0xb2
inode_doinit_with_dentry+0x4b/0x64b
pnp_device_probe+0x5a/0x77
bus_match+0x27/0x45
driver_attach+0x37/0x66
bus_add_driver+0x77/0x97
driver_register+0x51/0x58
pnp_register_driver+0x2b/0x4c
ide_init+0x44/0x56

-- 
Pekka Pietikainen
