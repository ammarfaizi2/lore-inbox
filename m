Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWBPQtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWBPQtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBPQtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:49:03 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:48827 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932333AbWBPQtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:49:01 -0500
Subject: 2.6.16-rc3 qlogic panic ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 08:49:49 -0800
Message-Id: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I am not sure if its already reported. I get following panic
while using qla2200 on 2.6.16-rc3.

Thanks,
Badari

Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}
PGD 1bddac067 PUD 1be314067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in: thermal processor fan button battery ac parport_pc lp
parport ipv6 sg qlogicfc qla2200 qla2300 qla2xxx ohci_hcd hw_random
usbcore dm_mod
Pid: 4601, comm: modprobe Tainted: GF     2.6.16-rc3 #1
RIP: 0010:[<ffffffff88042690>]
<ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}RSP:
0018:ffff8101be8b9d58  EFLAGS: 00010207
RAX: ffff81017df566a0 RBX: ffff81017df544b0 RCX: 0000000000000003
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff81017df544b0 R08: 00000000ffffffff R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000002400
R13: ffff81017df54000 R14: 0000000000000100 R15: ffffffffffffffff
FS:  00002b544141b6e0(0000) GS:ffffffff80575000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000001bdf1a000 CR4: 00000000000006e0
Process modprobe (pid: 4601, threadinfo ffff8101be8b8000, task
ffff8101beeaf100)Stack: 00000000ffffffff ffff81017df544b0
ffff81017df544b0 ffffffff880427fd
       00000000fffffff4 ffffffff880445f0 ffff8101c13d3a00
ffff8101dfc2c000
       0000000000000292 ffffffff80125c73
Call Trace: <ffffffff880427fd>{:qla2xxx:qla2x00_free_device+193}
       <ffffffff880445f0>{:qla2xxx:qla2x00_probe_one+3860}
       <ffffffff80125c73>{set_cpus_allowed+318}
<ffffffff803a3827>{__down+237}
       <ffffffff80278910>{pci_device_probe+230}
<ffffffff80278978>{pci_bus_match+0}
       <ffffffff802ca53e>{driver_probe_device+84}
<ffffffff802ca596>{__driver_attach+0}
       <ffffffff802ca5ec>{__driver_attach+86}
<ffffffff802c9f86>{bus_for_each_dev+67}
       <ffffffff802c9a5a>{bus_add_driver+114}
<ffffffff80278b2c>{__pci_register_driver+118}
       <ffffffff801444e7>{sys_init_module+241}
<ffffffff8010a762>{system_call+126}

Code: 48 8b 2f 74 2d 48 8b 07 48 8b 57 08 48 89 50 08 48 89 02 48
RIP <ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648} RSP
<ffff8101be8b9d58>

                                                                                


