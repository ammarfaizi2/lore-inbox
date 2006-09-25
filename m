Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWIYNMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWIYNMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWIYNMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:12:37 -0400
Received: from test.neuron.ee ([194.126.121.141]:47521 "EHLO test.neuron.ee")
	by vger.kernel.org with ESMTP id S932081AbWIYNMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:12:36 -0400
Message-ID: <4517D5BF.7000103@city.ee>
Date: Mon, 25 Sep 2006 16:12:31 +0300
From: Lenar <lenar@city.ee>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG / invalid opcode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not know where to send it, linux-kernel, debian or vserver guys, but
thought I'll start here.

Happened on dual-core AMD64 4600+ machine

Please ask, if more info is needed.

L.

---

Kernel BUG at mm/rmap.c:561
invalid opcode: 0000 [1] SMP
CPU 1
Modules linked in: netconsole button ac battery dummy w83627ehf i2c_isa 
i2c_core loop softdog serio_raw psmouse evdev pcspkr ext3 jbd mbcache 
dm_mirror dm_snapshot dm_mod raid1 md_mod ide_generic sd_mod amd74xx 
generic ide_core forcedeth sata_nv libata scsi_mod thermal processor fan
Pid: 14466, comm: libtool Not tainted 2.6.17-2-vserver-amd64 #1
RIP: 0010:[<ffffffff8020abc8>] <ffffffff8020abc8>{page_remove_rmap+19}
RSP: 0018:ffff81001fc57df0  EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff81007ea98000 RCX: ffff8100010202a0
RDX: 0000000000000000 RSI: 800000001f000045 RDI: ffff81007ea98000
RBP: 000000001f000000 R08: ffff81007ea0da40 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000745208 R12: 0000000000608000
R13: ffff810020251040 R14: ffff81007cb73240 R15: 0000000000749000
FS:  00002abb10e1e6d0(0000) GS:ffff810001349ac0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002abb10e18fe0 CR3: 0000000028647000 CR4: 00000000000006e0
Process libtool (pid: 14466[#26], threadinfo ffff81001fc56000, task 
ffff81002d556880)
Stack: ffffffff802079e2 0000000000000000 ffff81001fc57ec8 ffffffffffffffff
       0000000000000000 ffff8100369de700 ffff81001fc57ed0 0000000000000000
       0000000151c21a98 0000000000749000
Call Trace: <ffffffff802079e2>{unmap_vmas+1025} 
<ffffffff802390c7>{exit_mmap+120}
       <ffffffff8023b321>{mmput+40} <ffffffff8021438e>{do_exit+527}
       <ffffffff802481cc>{cpuset_exit+0} <ffffffff8025b84e>{system_call+126}

Code: 0f 0b 68 ee 3d 40 80 c2 31 02 48 83 ce ff bf 20 00 00 00 e9
RIP <ffffffff8020abc8>{page_remove_rmap+19} RSP <ffff81001fc57df0>
 <1>Fixing recursive fault but reboot is needed!

