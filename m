Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTBHUYV>; Sat, 8 Feb 2003 15:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbTBHUYV>; Sat, 8 Feb 2003 15:24:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:33975 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267094AbTBHUYT>; Sat, 8 Feb 2003 15:24:19 -0500
Date: Sat, 08 Feb 2003 12:33:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 326] New: BUG at drivers/scsi/scsi_error.c:1522! loading
 ServeRaid driver
Message-ID: <19900000.1044736436@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=326

           Summary: BUG at drivers/scsi/scsi_error.c:1522! loading ServeRaid
                    driver
    Kernel Version: 2.5.59-bk pull on 2/7/2003
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: plars@austin.ibm.com


Distribution:
Hardware Environment:
Netfinity 5500R ServeRaid with 3 drives attached (BSOD)
Software Environment:
Problem Description:
I had previously been getting other errors on the ips driver that were
preventing it from booting and I decided to take a look at it today as some
changes had been made.

A log of ACPI errors came before this, I'm not sure if they are related or
not.

ACPI: No IRQ known for interrupt pin A of device 00:03.0<4>Warning ! ! !
ServeRAID Version Mismatch
Bios = 4.30.04, Firmware = 2.88.13, Device Driver = 5.99.00-BETA
These levels should match to avoid possible compatibility problems.
scsi0 : IBM PCI ServeRAID 5.99.00-BETA Build 1132 <ServeRAID II>
scsi_eh_get_failed: host_failed: 1 != found: 0
kernel BUG at drivers/scsi/scsi_error.c:1522!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c02d23f2>]    Not tainted
EFLAGS: 00010202
EIP is at scsi_unjam_host+0x7a/0xc8
eax: 00000001   ebx: f7cffc00   ecx: ffffa9d5   edx: 0000562b
esi: 00000000   edi: f7c31fd8   ebp: f7cffc00   esp: f7c31fa0
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_0 (pid: 15, threadinfo=f7c30000 task=f7c2f920)
Stack: f7c30000 00000000 c02d2636 f7cffc00 c02d2440 00000000 00000000
00000000        00000000 00000000 00000001 dead4ead f7c31fe8 f7c31fe8
00000000 00000000        00000001 dead4ead f7c31fe8 f7c31fe8 c0106f01
f7cffc00 00000000 00000000 Call Trace:
 [<c02d2636>] scsi_error_handler+0x1f6/0x22c
 [<c02d2440>] scsi_error_handler+0x0/0x22c
 [<c0106f01>] kernel_thread_helper+0x5/0xc

Code: 0f 0b f2 05 e7 2a 46 c0 8d b6 00 00 00 00 80 a3 9a 00 00 00
Steps to reproduce:

