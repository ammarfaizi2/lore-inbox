Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263478AbUJ2VuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbUJ2VuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUJ2Vt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:49:57 -0400
Received: from ns1.q-leap.de ([153.94.51.193]:32908 "EHLO mail.q-leap.de")
	by vger.kernel.org with ESMTP id S263478AbUJ2VmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:42:21 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VH7dKRw63l"
Content-Transfer-Encoding: 7bit
Message-ID: <16770.9441.410275.546384@gargle.gargle.HOWL>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: rf@q-leap.de
From: Roland Fehrenbacher <rf@q-leap.de>
To: jgarzik@mandrakesoft.com
Subject: Kernel oops on x86_64 2.4.27 with 8GB RAM and sata_sil
Date: Fri, 29 Oct 2004 13:09:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VH7dKRw63l
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hi,

I have appended the output of ksymoops obtained from an Oops on an
Opteron Server that has 8GB RAM. The Oops occurs when disc access to a
SATA disk is attempted. The disk sits on a SIL3114 controller. There
is no oops and perfect behaviour if I specify mem=4032M as a kernel
parameter. Anybody got an idea what is going on?

Many thanks,

Roland

---------------------------------- Kernel boot messages -----------------------
libata version 1.02 loaded.
sata_sil version 0.54
ata1: SATA max UDMA/100 cmd 0xFFFFFF0000009C80 ctl 0xFFFFFF0000009C8A bmdma 0xFF
FFFF0000009C00 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFFF0000009CC0 ctl 0xFFFFFF0000009CCA bmdma 0xFF
FFFF0000009C08 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFFF0000009E80 ctl 0xFFFFFF0000009E8A bmdma 0xFF
FFFF0000009E00 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFFF0000009EC0 ctl 0xFFFFFF0000009ECA bmdma 0xFF
FFFF0000009E08 irq 19
ata1: no device found (phy stat 00000000)
ata2: no device found (phy stat 00000000)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata3: dev 0 ATA, max UDMA/133, 156301488 sectors: lba48
ata3: dev 0 configured for UDMA/100
ata4: no device found (phy stat 00000000)
scsi0 : sata_sil
scsi1 : sata_sil
scsi2 : sata_sil
scsi3 : sata_sil
  Vendor: ATA       Model: ST380013AS        Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
-------------------------------------------------------------------------------


--VH7dKRw63l
Content-Type: text/plain
Content-Description: ksymoops.out
Content-Disposition: inline;
	filename="oops.out"
Content-Transfer-Encoding: 7bit

ksymoops 2.4.5 on x86_64 2.4.27.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27/ (default)
     -m /boot/System.map-2.4.27 (specified)

kernel BUG in header file at line 160
Kernel BUG at panic:149
invalid operand: 0000
CPU 1
Pid: 376, comm: sfdisk Not tainted
RIP: 0010:[<ffffffff80121a82>]
Using defaults from ksymoops -t elf32-i386 -a i386
RSP: 0018:00000101fa697c68  EFLAGS: 00010016
RAX: 0000000000000026 RBX: 000001000c06b000 RCX: 000000000000ea5f
RDX: ffffffff80323148 RSI: 0000000000000001 RDI: ffffffff80323140
RBP: 0000010037ee95d0 R08: 0000000000000002 R09: 0000000000000046
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000010
R13: 0000010037ee90c0 R14: 0000010037ee90c0 R15: ffffffff802524c0
FS:  0000000000000000(0000) GS:ffffffff803c7740(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000051e168 CR3: 00000000fbfe4000 CR4: 00000000000006a0
Process sfdisk (pid: 376, stackpage=101fa697000)
Stack: 00000101fa697c68 0000000000000018 ffffffff80121a82 000001000042f000
       ffffffff801166f8 00000100fbf83400 ffffffff8025056c 0000000000000001
       0000010037ee95d0 0000010037ee90c0 00000100fbf83488 0000010037ee9180
Call Trace: [<ffffffff80121a82>] [<ffffffff801166f8>]
       [<ffffffff8025056c>] [<ffffffff80250ec6>] [<ffffffff8025271a>]
       [<ffffffff802434a0>] [<ffffffff80252ff8>] [<ffffffff80242e76>]
       [<ffffffff8024a7b0>] [<ffffffff80212e08>] [<ffffffff80127810>]
       [<ffffffff8014bebb>] [<ffffffff80136350>] [<ffffffff80136e14>]
       [<ffffffff80137210>] [<ffffffff80137331>] [<ffffffff802566f1>]
       [<ffffffff80146c7a>] [<ffffffff801101cf>]
Code: 0f 0b 1f 8c 2d 80 ff ff ff ff 95 00 66 90 eb fe 90 90 90 90


>>EIP; ffffffff80121a82 <__out_of_line_bug+12/30>   <=====

>>RBX; 1000c06b000 Before first symbol
>>RCX; 0000ea5f Before first symbol
>>RDX; ffffffff80323148 <log_wait+8/20>
>>RDI; ffffffff80323140 <log_wait+0/20>
>>RBP; 10037ee95d0 Before first symbol
>>R13; 10037ee90c0 Before first symbol
>>R14; 10037ee90c0 Before first symbol
>>R15; ffffffff802524c0 <ata_scsi_rw_xlat+0/1e0>

Trace; ffffffff80121a82 <__out_of_line_bug+12/30>
Trace; ffffffff801166f8 <pci_map_sg+128/170>
Trace; ffffffff8025056c <ata_sg_setup+8c/c0>
Trace; ffffffff80250ec6 <ata_qc_issue+26/70>
Trace; ffffffff8025271a <ata_scsi_translate+7a/b0>
Trace; ffffffff802434a0 <scsi_done+0/d0>
Trace; ffffffff80252ff8 <ata_scsi_queuecmd+168/190>
Trace; ffffffff80242e76 <scsi_dispatch_cmd+186/310>
Trace; ffffffff8024a7b0 <scsi_request_fn+390/3c0>
Trace; ffffffff80212e08 <generic_unplug_device+38/50>
Trace; ffffffff80127810 <__run_task_queue+80/90>
Trace; ffffffff8014bebb <block_sync_page+1b/30>
Trace; ffffffff80136350 <___wait_on_page+c0/f0>
Trace; ffffffff80136e14 <do_generic_file_read+344/4a0>
Trace; ffffffff80137210 <file_read_actor+0/90>
Trace; ffffffff80137331 <generic_file_read+91/190>
Trace; ffffffff802566f1 <sd_ioctl+181/4c0>
Trace; ffffffff80146c7a <sys_read+ba/160>
Trace; ffffffff801101cf <system_call+77/7c>

Code;  80121a82 Before first symbol
00000000 <_EIP>:
Code;  80121a82 Before first symbol
   0:   0f 0b                     ud2a   
Code;  80121a84 Before first symbol
   2:   1f                        pop    %ds
Code;  80121a85 Before first symbol
   3:   8c 2d 80 ff ff ff         movl   %gs,0xffffff80
Code;  80121a8b Before first symbol
   9:   ff 95 00 66 90 eb         call   *0xeb906600(%ebp)
Code;  80121a91 Before first symbol
   f:   fe                        (bad)  
Code;  80121a92 Before first symbol
  10:   90                        nop    
Code;  80121a93 Before first symbol
  11:   90                        nop    
Code;  80121a94 Before first symbol
  12:   90                        nop    
Code;  80121a95 Before first symbol
  13:   90                        nop    


--VH7dKRw63l--




