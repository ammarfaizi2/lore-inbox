Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268672AbUHaOp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268672AbUHaOp6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 10:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUHaOp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 10:45:57 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:24732 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S268672AbUHaOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 10:45:54 -0400
Date: Tue, 31 Aug 2004 16:45:50 +0200
Message-Id: <200408311445.QAA30989@boskoop.iwr.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.27: Oops while mounting cdrom with ide-scsi
From: ml <Michael.Lampe@iwr.uni-heidelberg.de>
CC: Michael.Lampe@iwr.uni-heidelberg.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.3 on i686 2.4.27.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27/ (default)
     -m /boot/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 001000be
cf25eca9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<cf25eca9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0010004c   ebx: c2678360   ecx: 00000286   edx: 00000000
esi: 00000000   edi: c67f3a00   ebp: 00000000   esp: cb725e48
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 779, stackpage=cb725000)
Stack: c2678360 00000000 c67f3a00 0009a4c7 cb725e60 cf25f14c 00000000 00000000 
       00000000 cb725e6c cb725e6c cf2725ae c67f3a00 00000b00 c67f3c14 cf273d40 
       00000b00 c021fdd4 00000001 00000000 c26783b4 c67f3a00 cf27280f 00000000 
Call Trace:    [<cf25f14c>] [<cf2725ae>] [<cf273d40>] [<cf27280f>] [<cf2728ee>]
  [<cf2693f5>] [<c0140680>] [<cf269386>] [<c0134c4d>] [<c0134d9a>] [<c012eb45>]
  [<c012ea5a>] [<c012ed7e>] [<c0106b33>]
Code: f6 40 72 01 0f 84 ae 00 00 00 bb 00 e0 ff ff 21 e3 c7 44 24 

>>EIP; cf25eca8 <[scsi_mod]scsi_block_when_processing_errors+c/d8>   <=====
Trace; cf25f14c <[scsi_mod]scsi_sleep_done+0/14>
Trace; cf2725ae <[sr_mod]sr_do_ioctl+d2/2d4>
Trace; cf273d40 <[sr_mod]sr_dops+0/40>
Trace; cf27280e <[sr_mod]test_unit_ready+5e/68>
Trace; cf2728ee <[sr_mod]sr_drive_status+22/3c>
Trace; cf2693f4 <[cdrom]open_for_data+34/2c4>
Trace; c0140680 <alloc_inode+30/12c>
Trace; cf269386 <[cdrom]cdrom_open+8e/c8>
Trace; c0134c4c <do_open+90/144>
Trace; c0134d9a <blkdev_open+22/28>
Trace; c012eb44 <dentry_open+e0/188>
Trace; c012ea5a <filp_open+52/5c>
Trace; c012ed7e <sys_open+36/84>
Trace; c0106b32 <system_call+32/38>
Code;  cf25eca8 <[scsi_mod]scsi_block_when_processing_errors+c/d8>
00000000 <_EIP>:
Code;  cf25eca8 <[scsi_mod]scsi_block_when_processing_errors+c/d8>   <=====
   0:   f6 40 72 01               testb  $0x1,0x72(%eax)   <=====
Code;  cf25ecac <[scsi_mod]scsi_block_when_processing_errors+10/d8>
   4:   0f 84 ae 00 00 00         je     b8 <_EIP+0xb8> cf25ed60 <[scsi_mod]scsi_block_when_processing_errors+c4/d8>
Code;  cf25ecb2 <[scsi_mod]scsi_block_when_processing_errors+16/d8>
   a:   bb 00 e0 ff ff            mov    $0xffffe000,%ebx
Code;  cf25ecb6 <[scsi_mod]scsi_block_when_processing_errors+1a/d8>
   f:   21 e3                     and    %esp,%ebx
Code;  cf25ecb8 <[scsi_mod]scsi_block_when_processing_errors+1c/d8>
  11:   c7 44 24 00 00 00 00      movl   $0x0,0x0(%esp,1)
Code;  cf25ecc0 <[scsi_mod]scsi_block_when_processing_errors+24/d8>
  18:   00 

1 warning issued.  Results may not be reliable.
