Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbWAMFAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWAMFAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 00:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWAMFAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 00:00:54 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:21033 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964922AbWAMFAx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 00:00:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QxNJJpucedZwlq3x66jtWDxvaUx7ODo7X2QmXBUH/kkXrQPoaTxH4jqKzWfTEoAbvDu8GD9PTeS4i8vrfDg4WHHZ+VO8bRIqqNSEgf0TZTmsBKIGt9BRwVQfog1yEtdzvml4bSZATxR8fseyFbS18YUPhNKsCtQKjLS1hbUov8M=
Message-ID: <a755d0d50601122100u649370a5h9adf8e659046cf01@mail.gmail.com>
Date: Fri, 13 Jan 2006 13:00:51 +0800
From: =?ISO-2022-JP?B?GyRCNmI5PzhVGyhC?= <bearhuzju@gmail.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel boot oops
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most recent kernel where this bug did not occur:
none
Distribution:
AS4
Hardware Environment:
SAN shared stroage, HBA card drived by qla2300, CPU 2*Xeon 2GHz,mem 2GB

Software Environment:
Kernel version:2.6.15-rc7 smp, 64GB-mem, with patch "Fix Fibre Channel boot oop
Problem Description:
the system boot log was:
Creating /dev
Sqla2300 0000:07:01.0: Configure NVRAM parameters...
tarting udev
Loading sd_mod.ko module
Loading scsi_transport_fc.ko module
Loading qla2xxx.ko qla2300 0000:07:01.0: Verifying loaded RISC code...
module
Loading qla2300.ko modulqla2300 0000:07:01.0: Waiting for LIP to complete...
e
qla2300 0000:07:01.0: LIP reset occured (f8f7).
qla2300 0000:07:01.0: LIP occured (f8f7).
qla2300 0000:07:01.0: LOOP UP detected (2 Gbps).
qla2300 0000:07:01.0: Topology - (Loop), Host Loop address 0x0
scsi0 : qla2xxx
qla2300 0000:07:01.0:
 QLogic Fibre Channel HBA Driver: 8.01.03-k
  QLogic QLA2342 - 133MHz PCI-X to 2Gb FC, Dual Channel
  ISP2312: PCI-X (133 MHz) @ 0000:07:01.0 hdma-, host#=0, fw=3.03.18 IPX
ACPI: PCI Interrupt 0000:07:01.1[B] -> GSI 97 (level, low) -> IRQ 177
qla2300 0000:07:01.1: Found an ISP2312, irq 177, iobase 0xf881a000
qla2300 0000:07:01.1: Configuring PCI space...
qla2300 0000:07:01.1: Configure NVRAM parameters...
qla2300 0000:07:01.1: Verifying loaded RISC code...
qla2300 0000:07:01.1: Waiting for LIP to complete...
qla2300 0000:07:01.1: LIP reset occured (f8f7).
qla2300 0000:07:01.1: LIP occured (f8f7).
  Vendor: TOYOU     Model: NetStor DA9220F   Rev: 342R
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 999950336 512-byte hdwr sectors (511975 MB)
SCSI device sda: drive cache: write back


qla2300 0000:07:01.1: Topology - (Loop), Host Loop address 0x0
scsi1 : qla2xxx
qla2300 0000:07:01.1:
 QLogic Fibre Channel HBA Driver: 8.01.03-k
  QLogic QLA2342 - 133MHz PCI-X to 2Gb FC, Dual Channel
  ISP2312: PCI-X (133 MHz) @ 0000:07:01.1 hdma-, host#=1, fw=3.03.18 IPX
Loading dm-mod.kdevice-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-
devel@redhat.com
o module
sd 0:0:0:0: Attached scsi generic sg0 type 0
Creating root device
  Vendor: TOYOU     Model: NetStor DA9220F   Rev: 342R
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 999950336 512-byte hdwr sectors (511975 MB)
Mounting root fiSCSI device sdb: drive cache: write back
lesystem
SCSI device sdb: 999950336 512-byte hdwr sectors (511975 MB)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Switching to newSCSI device sdb: drive cache: write back
 root
 sdb:
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
unmounting old /proc
unmounting old /sys
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
f885542a
*pde = 003b1001
Oops: 0000 [#1]
SMP
Modules linked in: dm_mod qla2300 qla2xxx scsi_transport_fc sd_mod
CPU:    1


EIP is at qla2x00_queuecommand+0x72/0x122 [qla2xxx]
eax: 00000000   ebx: c2331380   ecx: c2015fe0   edx: 00000002
esi: f7dd82a8   edi: 00000000   ebp: c021b96f   esp: f79a3d10
ds: 007b   es: 007b   ss: 0068
Process scsi_wq_1 (pid: 835, threadinfo=f79a2000 task=f7fe1030)
Stack: 00000287 f7dd8000 c2331380 00000000 c021b7ba c2331380 c021b96f c233939c
       c233939c f79adc00 f7dd8000 c2309044 c0220c02 c2331380 c2331380 c2331380
       c2309044 00000000 c2339418 c233939c c01b6c83 c2309044 f79a3de4 c01b77de
Call Trace:
 [<c021b7ba>] scsi_dispatch_cmd+0x1be/0x23c
 [<c021b96f>] scsi_done+0x0/0x1c
 [<c0220c02>] scsi_request_fn+0x25f/0x2d6
 [<c01b6c83>] generic_unplug_device+0x16/0x23
 [<c01b77de>] blk_execute_rq+0x80/0xa7
 [<c01b7997>] blk_end_sync_rq+0x0/0x22
 [<c01b872a>] blk_rq_bio_prep+0x63/0x81
 [<c021fb3a>] scsi_execute+0xb2/0xcd
 [<c021fbab>] scsi_execute_req+0x56/0x78
 [<c022237c>] scsi_report_lun_scan+0x1a2/0x3af
 [<c01bd53f>] kobject_put+0x16/0x19
 [<c01bd51f>] kobject_release+0x0/0xa
 [<c0222073>] scsi_probe_and_add_lun+0x1e3/0x1ec
 [<c022276c>] __scsi_scan_target+0xaf/0xe4
 [<c02227f2>] scsi_scan_target+0x51/0x61
 [<f882e669>] fc_scsi_scan_rport+0x1f/0x26 [scsi_transport_fc]
 [<c0127c2a>] worker_thread+0x170/0x1de
 [<f882e64a>] fc_scsi_scan_rport+0x0/0x26 [scsi_transport_fc]
 [<c0116f3d>] default_wake_function+0x0/0x12
 [<c0116f3d>] default_wake_function+0x0/0x12
 [<c0127aba>] worker_thread+0x0/0x1de
 [<c012b1b7>] kthread+0x7c/0xa6
 [<c012b13b>] kthread+0x0/0xa6
 [<c0101ab5>] kernel_thread_helper+0x5/0xb
Code: 83 ea 40 8b 52 24 31 c0 83 fa 02 74 0f 83 fa 04 b8 00 00 02 00 74 05 b8
00 00 01 00 85 c0 74 0b 89 83 3c 01 00 00 e9 a
INIT:

Steps to reproduce:
boot the system from the smp kernel,but sometimes it does not occur.
