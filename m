Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUCOB6C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 20:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUCOB6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 20:58:01 -0500
Received: from web60006.mail.yahoo.com ([216.109.116.229]:22144 "HELO
	web60006.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262194AbUCOB54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 20:57:56 -0500
Message-ID: <20040315015756.15559.qmail@web60006.mail.yahoo.com>
Date: Sun, 14 Mar 2004 17:57:56 -0800 (PST)
From: Shi Jin <jinzishuai@yahoo.com>
Subject: AIC7899 SCSI driver problem:DV failed to configure device.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I am having this problem for all the kernels I tried:
2.4.18,2.4.25 and
2.6.3.The message is:
******************begin*********************
 SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER,
Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
aic7899: Ultra160 Wide
        Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER,
Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel B, SCSI Id=7,
32/253 SCBs

blk: queue f797b818, I/O limit 4095Mb (mask
0xffffffff)
scsi0:A:0:0: DV failed to configure device.  Please
file a bug report against this driver.
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT,
offset 31, 16bit)
  Vendor:           Model:                   Rev: 0001
  Type:   Direct-Access                      ANSI SCSI
revision: 03
blk: queue f797b618, I/O limit 4095Mb (mask
0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 0, lun
0
SCSI device sda: 2578022400 512-byte hdwr sectors
(1319947 MB)
 sda: sda1 sda2 sda3
******************end *************************
The output of lspci -v is
*****************begin********************
00:0a.0 SCSI storage controller: Adaptec AIC-7899P
U160/m (rev 01)
        Subsystem: Tyan Computer: Unknown device 2468
        Flags: bus master, 66Mhz, medium devsel,
latency 72, IRQ 20
        BIST result: 00
        I/O ports at 1000 [disabled] [size=256]
        Memory at f4000000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: <available only to root>

00:0a.1 SCSI storage controller: Adaptec AIC-7899P
U160/m (rev 01)
        Subsystem: Tyan Computer: Unknown device 2468
        Flags: bus master, 66Mhz, medium devsel,
latency 72, IRQ 21
        BIST result: 00
        I/O ports at 1400 [disabled] [size=256]
        Memory at f4001000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled]
[size=128K]
        Capabilities: <available only to root>
******************end************************

An external IDE RAID(level 5) is connected to this
SCSI port.
It is working fine for now being, but I don't know why
the DV failed to
configure error happens. So I report it here.

Please tell me what else information you need.
Thank you very much.

Shi Jin


__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
