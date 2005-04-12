Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVDLNbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVDLNbZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVDLND5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:03:57 -0400
Received: from hermes.domdv.de ([193.102.202.1]:49413 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262353AbVDLMuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:50:23 -0400
Message-ID: <425BC406.4080005@domdv.de>
Date: Tue, 12 Apr 2005 14:50:14 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: 2.6.12rc2: Oops with pcmcia ide flash disk
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010102090109090901060209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010102090109090901060209
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

2.6.12rc2 oopses during eject of a pcmcia ide flash disk on x86_64.
2.6.11.2 works fine.

Attached is the kernel config and the oops itself.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------010102090109090901060209
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Apr 12 14:22:45 gringo kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xd8000-0xdffff 0xe4000-0xfffff
Apr 12 14:22:45 gringo kernel: ttyS16: detected caps 00000700 should be 00000100
Apr 12 14:22:45 gringo kernel: ttyS16 at I/O 0x100 (irq = 17) is a 16C950/954
Apr 12 14:22:45 gringo kernel: ttyS17 at I/O 0x108 (irq = 17) is a 8250
Apr 12 14:22:45 gringo kernel: cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xd8000-0xdffff 0xe4000-0xfffff
Apr 12 14:22:45 gringo kernel: hde: 16MB CTS, CFA DISK drive
Apr 12 14:22:45 gringo kernel: ide2 at 0x110-0x117,0x11e on irq 18
Apr 12 14:22:45 gringo kernel: hde: max request size: 128KiB
Apr 12 14:22:45 gringo kernel: hde: 32000 sectors (16 MB) w/4KiB Cache, CHS=500/2/32
Apr 12 14:22:45 gringo kernel: hde: cache flushes not supported
Apr 12 14:22:45 gringo kernel:  hde: hde1
Apr 12 14:22:45 gringo kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Apr 12 14:22:45 gringo kernel:  hde: hde1
Apr 12 14:22:45 gringo kernel: Unable to handle kernel NULL pointer dereference at 0000000000000020 RIP: 
Apr 12 14:22:45 gringo kernel: <ffffffff802dcaf5>{ide_drive_remove+21}
Apr 12 14:22:45 gringo kernel: PGD 3f76a067 PUD 3f708067 PMD 0 
Apr 12 14:22:45 gringo kernel: Oops: 0000 [1] 
Apr 12 14:22:45 gringo kernel: CPU 0 
Apr 12 14:22:45 gringo kernel: Modules linked in:
Apr 12 14:22:45 gringo kernel: Pid: 1066, comm: cardctl Not tainted 2.6.12-rc2-gringo
Apr 12 14:22:45 gringo kernel: RIP: 0010:[<ffffffff802dcaf5>] <ffffffff802dcaf5>{ide_drive_remove+21}
Apr 12 14:22:45 gringo kernel: RSP: 0000:ffff81003f6afa28  EFLAGS: 00010296
Apr 12 14:22:45 gringo kernel: RAX: ffffffff805d5050 RBX: ffffffff805d51c0 RCX: ffffffff805d5198
Apr 12 14:22:45 gringo kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff805d5050
Apr 12 14:22:45 gringo kernel: RBP: ffffffff805d5178 R08: 0000000000000117 R09: 0000000000000001
Apr 12 14:22:45 gringo kernel: R10: 00000000ffffffff R11: ffffffff80182c10 R12: ffffffff80511cf0
Apr 12 14:22:45 gringo kernel: R13: 0000000000000001 R14: 0000000000000002 R15: ffffffff805115a0
Apr 12 14:22:45 gringo kernel: FS:  00002aaaaae0aae0(0000) GS:ffffffff805ee340(0000) knlGS:0000000000000000
Apr 12 14:22:45 gringo kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Apr 12 14:22:45 gringo kernel: CR2: 0000000000000020 CR3: 000000003f072000 CR4: 00000000000006e0
Apr 12 14:22:45 gringo kernel: Process cardctl (pid: 1066, threadinfo ffff81003f6ae000, task ffff81000237c820)
Apr 12 14:22:45 gringo kernel: Stack: 0000000000000001 ffffffff802b5f67 ffffffff805d5178 ffffffff805113a0 
Apr 12 14:22:45 gringo kernel:        ffff81003fa17000 ffffffff802b6194 ffffffff805d5178 ffffffff805d5738 
Apr 12 14:22:45 gringo kernel:        ffff81003fa17000 ffffffff802b4fc8 
Apr 12 14:22:45 gringo kernel: Call Trace:<ffffffff802b5f67>{device_release_driver+119} <ffffffff802b6194>{bus_remove_device+180} 
Apr 12 14:22:45 gringo kernel:        <ffffffff802b4fc8>{device_del+88} <ffffffff802b5009>{device_unregister+9} 
Apr 12 14:22:45 gringo kernel:        <ffffffff802db012>{ide_unregister+546} <ffffffff80311590>{send_event_callback+0} 
Apr 12 14:22:45 gringo kernel:        <ffffffff802edcd5>{ide_release+37} <ffffffff802edf5e>{ide_event+174} 
Apr 12 14:22:45 gringo kernel:        <ffffffff8021af5e>{avc_has_perm_noaudit+574} <ffffffff80311590>{send_event_callback+0} 
Apr 12 14:22:45 gringo kernel:        <ffffffff802b5afd>{__bus_for_each_dev+109} <ffffffff80311590>{send_event_callback+0} 
Apr 12 14:22:45 gringo kernel:        <ffffffff802b5b88>{bus_for_each_dev+72} <ffffffff8031162d>{send_event+93} 
Apr 12 14:22:45 gringo kernel:        <ffffffff80311ae7>{ds_event+103} <ffffffff8030bef5>{send_event+69} 
Apr 12 14:22:45 gringo kernel:        <ffffffff8030c05d>{socket_shutdown+13} <ffffffff8030bef5>{send_event+69} 
Apr 12 14:22:45 gringo kernel:        <ffffffff8030c5e9>{socket_remove+9} <ffffffff8030e12d>{pcmcia_eject_card+93} 
Apr 12 14:22:45 gringo kernel:        <ffffffff803125fe>{ds_ioctl+1278} <ffffffff8021be6a>{inode_has_perm+106} 
Apr 12 14:22:45 gringo kernel:        <ffffffff801e2813>{do_get_write_access+1203} <ffffffff8021aa18>{avc_alloc_node+56} 
Apr 12 14:22:45 gringo kernel:        <ffffffff8021e86a>{selinux_file_ioctl+762} <ffffffff8021b0ea>{avc_has_perm+90} 
Apr 12 14:22:45 gringo kernel:        <ffffffff801e1d30>{journal_stop+480} <ffffffff8021bdc1>{task_has_capability+97} 
Apr 12 14:22:45 gringo kernel:        <ffffffff8017b62e>{do_ioctl+78} <ffffffff8017b8bd>{vfs_ioctl+637} 
Apr 12 14:22:45 gringo kernel:        <ffffffff8017b94a>{sys_ioctl+106} <ffffffff8010d696>{system_call+126} 
Apr 12 14:22:45 gringo kernel:        
Apr 12 14:22:45 gringo kernel: 
Apr 12 14:22:45 gringo kernel: Code: ff 52 20 31 c0 48 83 c4 08 c3 90 41 54 48 8d 87 38 01 00 00 
Apr 12 14:22:45 gringo kernel: RIP <ffffffff802dcaf5>{ide_drive_remove+21} RSP <ffff81003f6afa28>
Apr 12 14:22:45 gringo kernel: CR2: 0000000000000020

--------------010102090109090901060209
Content-Type: application/x-gunzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------010102090109090901060209--
