Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752015AbWIHDGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbWIHDGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 23:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWIHDGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 23:06:10 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:39458 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752015AbWIHDGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 23:06:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iOyV53S/fdVZRfC0kYwLKJGb2q+pzTSGztMGggY6qBVobMzFr4njrVJ9uvR0shqx8YAIX+1tg8g+vqS2nvfCCfnjckGNXTWM5vSj558tP4xYM3OjItm4J68zCTcagwFsArvlxNAfvRtr3clSwIXB8wxo9LgOUTg8oIKvNBPc8kU=
Message-ID: <a44ae5cd0609072006p627fb127g62949c62a5bfc6c2@mail.gmail.com>
Date: Thu, 7 Sep 2006 20:06:07 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Arjan van de Ven" <arjan@infradead.org>
Subject: 2.6.18-rc5-mm1 + all hotfixes + nodemgr patches -- INFO: trying to register non-static key (the code is fine but needs lockdep annotation).
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ieee1394: Initialized config rom entry `ip1394'
SCSI subsystem initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[22]
MMIO=[e0207000-e02077ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ohci1394: fw-host0: Running dma failed because Node ID is not valid
ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
PM: Adding info for ieee1394:00c09f00004fec18
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00c09f00004fec18]
PM: Adding info for ieee1394:00c09f00004fec18-0
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
PM: Adding info for ieee1394:0080880002103eae
ieee1394: Node added: ID:BUS[1-00:1023]  GUID[0080880002103eae]
PM: Adding info for ieee1394:0090a950000b2255
ieee1394: Node added: ID:BUS[1-01:1023]  GUID[0090a950000b2255]
PM: Adding info for ieee1394:0090a94000007475
ieee1394: Host added: ID:BUS[1-02:1023]  GUID[0090a94000007475]
PM: Adding info for ieee1394:0080880002103eae-0
PM: Adding info for ieee1394:0090a950000b2255-0
scsi0 : SBP-2 IEEE-1394
PM: Adding info for No Bus:host0
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 1-01:1023: Max speed [S400] - Max payload [1024]
PM: Adding info for No Bus:target0:0:0
ieee1394: sbp2: aborting sbp2 command
scsi 0:0:0:0:
        command: cdb[0]=0x12: 12 00 00 00 24 00
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
 [<c1003d3a>] dump_trace+0x64/0x1a2
 [<c1003e8a>] show_trace_log_lvl+0x12/0x25
 [<c1004164>] show_trace+0xd/0x10
 [<c100417e>] dump_stack+0x17/0x19
 [<c1038b9c>] __lock_acquire+0x11d/0xa07
 [<c1039763>] lock_acquire+0x5e/0x7f
 [<c11e53b2>] _spin_lock_irq+0x1f/0x2e
 [<c11e3967>] wait_for_completion_timeout+0x2c/0xb9
 [<f902f441>] scsi_send_eh_cmnd+0x20a/0x318 [scsi_mod]
 [<f902f573>] scsi_eh_tur+0x24/0x4c [scsi_mod]
 [<f902fc29>] scsi_error_handler+0x1b2/0x599 [scsi_mod]
 [<c1032b1d>] kthread+0xc4/0xf3
 [<c10039d3>] kernel_thread_helper+0x7/0x10
DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

Leftover inexact backtrace:

 [<c1003e8a>] show_trace_log_lvl+0x12/0x25
 [<c1004164>] show_trace+0xd/0x10
 [<c100417e>] dump_stack+0x17/0x19
 [<c1038b9c>] __lock_acquire+0x11d/0xa07
 [<c1039763>] lock_acquire+0x5e/0x7f
 [<c11e53b2>] _spin_lock_irq+0x1f/0x2e
 [<c11e3967>] wait_for_completion_timeout+0x2c/0xb9
 [<f902f441>] scsi_send_eh_cmnd+0x20a/0x318 [scsi_mod]
 [<f902f573>] scsi_eh_tur+0x24/0x4c [scsi_mod]
 [<f902fc29>] scsi_error_handler+0x1b2/0x599 [scsi_mod]
 [<c1032b1d>] kthread+0xc4/0xf3
 [<c10039d3>] kernel_thread_helper+0x7/0x10
 =======================
scsi 0:0:0:0: Direct-Access-RBC WDC      FireWire/USB2.0  4.17 PQ: 0 ANSI: 4
PM: Adding info for scsi:0:0:0:0
PM: Adding info for ieee1394:0090a94000007475-0
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 0c 00 00 00
PM: Adding info for No Bus:vcs7
PM: Adding info for No Bus:vcsa7
PM: Removing info for No Bus:vcs7
PM: Removing info for No Bus:vcsa7
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
ieee1394: sbp2: aborting sbp2 command
sd 0:0:0:0:
        command: cdb[0]=0x1a: 1a 08 06 00 04 00
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 0c 00 00 00
ieee1394: sbp2: aborting sbp2 command
sd 0:0:0:0:
        command: cdb[0]=0x1a: 1a 08 06 00 04 00
ieee1394: sbp2: hpsb_node_write failed.
ieee1394: sbp2: aborting sbp2 command
sd 0:0:0:0:
        command: cdb[0]=0x0: 00 00 00 00 00 00
ieee1394: sbp2: reset requested
ieee1394: sbp2: Generating sbp2 fetch agent reset
ieee1394: sbp2: aborting sbp2 command
sd 0:0:0:0:
        command: cdb[0]=0x0: 00 00 00 00 00 00
sd 0:0:0:0: scsi: Device offlined - not ready after error recovery
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda:<3>sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda, logical block 0
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda, logical block 0
ldm_validate_partition_table(): Disk read failed.
sd 0:0:0:0: rejecting I/O to offline device
Buffer I/O error on device sda, logical block 0
 unable to read partition table
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 14
