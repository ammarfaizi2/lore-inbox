Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265332AbUAADWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 22:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUAADWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 22:22:38 -0500
Received: from eldar.tcsn.co.za ([196.41.199.50]:36357 "EHLO tcsn.co.za")
	by vger.kernel.org with ESMTP id S265332AbUAADWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 22:22:36 -0500
Date: Thu, 1 Jan 2004 05:20:29 +0200
From: Henti Smith <henti@geekware.co.za>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: error message in dmesg
Message-Id: <20040101052029.40b10f87.henti@geekware.co.za>
Organization: geekware
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there 

I've upgraded to 2.6.0 and I get this error in dmesg: 

------------[ cut here ]------------
kernel BUG at mm/slab.c:1268!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0138825>]    Tainted: PF 
EFLAGS: 00010202
EIP is at kmem_cache_create+0x3c5/0x4cc
eax: 0000002c   ebx: dfff3498   ecx: c04d30f8   edx: c3d52000
esi: c03d3b4d   edi: e0a42d44   ebp: c3d53f64   esp: c3d53f34
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4841, threadinfo=c3d52000 task=cb71ccc0)
Stack: c03aacc0 e0a42d3b 00002000 c3d53f54 dfe1d794 c0000000 dfe1d758 ffffff80 
       00000000 00000000 00000004 e0a52c80 c3d53fbc e0a5411d e0a42d3b 00000080 
       00000080 00002000 00000000 00000000 c040d3b0 c3d52000 e0a5400c c040d3b0 
Call Trace:
 [<e0a5411d>] scsi_init_queue+0x47/0xca [scsi_mod]
 [<e0a5400c>] init_scsi+0xc/0xd6 [scsi_mod]
 [<c0131063>] sys_init_module+0x135/0x27b
 [<c0109233>] syscall_call+0x7/0xb

Code: 0f 0b f4 04 d2 a4 3a c0 8b 0b e9 71 ff ff ff 8b 47 34 c7 04 

This seems to happen after I've used my USB drive, 16MB Kalliba/Intel labeled

hub 2-0:1.0: new USB device on port 2, assigned address 2
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 31263 512-byte hdwr sectors (16 MB)
sda: Write Protect is off
sda: Mode Sense: 00 0f 00 00
sda: assuming drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
usb 2-2: USB disconnect, address 2


system information can be found at http://www.geekware.co.za/henti/kernel

-- 
Henti Smith
henti@geekware.co.za
Co-Owner
+27 82 958 2525
http://www.geekware.co.za
