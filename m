Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRFWTJw>; Sat, 23 Jun 2001 15:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbRFWTJo>; Sat, 23 Jun 2001 15:09:44 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:20172 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S262288AbRFWTJ1>;
	Sat, 23 Jun 2001 15:09:27 -0400
Date: Sat, 23 Jun 2001 20:08:06 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OPPS] 2.4.5-ac15
Message-ID: <Pine.LNX.4.30.0106232007330.1838-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

when using eject to eject a cd from an atapi cd writer that had the
tray locked by cdreored (which had messed up)

i got the following opps on 2.4.5-ac15

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: CD-Writer+ 7200  Rev: 3.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: ATAPI    Model: CD-ROM 44X       Rev: T4C2
  Type:   CD-ROM                           ANSI SCSI revision: 02


ksymoops 2.3.7 on i586 2.4.5-ac15-js1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac15-js1/ (default)
     -m /boot/System.map-2.4.5-ac15-js1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Error (regular_file): read_system_map stat /boot/System.map-2.4.5-ac15-js1 failed
Unable to handle kernel paging request at virtual address f6f5f251
c011cd0d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011cd0d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: f6f5f201   ebx: cb40e000   ecx: f6f5f1fd   edx: 00000050
esi: 00000246   edi: 00000005   ebp: cb40ff94   esp: cb40ff74
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 00000000 c0107a40 00000000 c0107ae4 00000005 cb40ff94 cb40e000
       00000005 00000000 00030001 c996d202 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0107a40>] [<c0107ae4>]
Code: 83 3c 02 01 75 07 c7 04 02 00 00 00 00 8d 47 ff 0f b3 83 50

>>EIP; c011cd0d <force_sig_info+3d/a0>   <=====
Trace; c0107a40 <__up_wakeup+1ec4/2594>
Trace; c0107ae4 <__up_wakeup+1f68/2594>
Code;  c011cd0d <force_sig_info+3d/a0>
00000000 <_EIP>:
Code;  c011cd0d <force_sig_info+3d/a0>   <=====
   0:   83 3c 02 01               cmpl   $0x1,(%edx,%eax,1)   <=====
Code;  c011cd11 <force_sig_info+41/a0>
   4:   75 07                     jne    d <_EIP+0xd> c011cd1a <force_sig_info+4a/a0>
Code;  c011cd13 <force_sig_info+43/a0>
   6:   c7 04 02 00 00 00 00      movl   $0x0,(%edx,%eax,1)
Code;  c011cd1a <force_sig_info+4a/a0>
   d:   8d 47 ff                  lea    0xffffffff(%edi),%eax
Code;  c011cd1d <force_sig_info+4d/a0>
  10:   0f b3 83 50 00 00 00      btr    %eax,0x50(%ebx)

 <1>Unable to handle kernel paging request at virtual address f6f5f251
c011cd0d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011cd0d>]
EFLAGS: 00010082
eax: f6f5f201   ebx: cb40e000   ecx: f6f5f1fd   edx: 00000050
esi: 00000246   edi: 00000005   ebp: cb40fbb4   esp: cb40fb94
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 00000000 c0107a40 00000000 c0107ae4 00000005 cb40fbb4 cb40e000
       00000005 00000000 00030001 c996d202 00000000 00000000 00000000 00000000
       cbf95504 c8a6f520 00000000 00000000 c5bdb0c0 cbfc3220 c0334150 00000286
Call Trace: [<c0107a40>] [<c0107ae4>] [<c01c781f>] [<c01c4455>] [<c01b923e>]
   [<c0106e08>] [<c01ba410>] [<c01ba773>] [<c01bac34>] [<c01d4740>] [<c01080da>]
   [<c010825d>] [<c010a51e>] [<c01080d0>] [<c010825d>] [<c010a51e>] [<c01080d0>]
   [<c010825d>] [<c010a51e>] [<c0119072>] [<c010828f>] [<f6f5f251>] [<c010a51e>]
   [<f6f5f251>] [<c0107282>] [<c011cd0d>] [<c01128f7>] [<c0112560>] [<c0106e08>]
   [<f6f5f1fd>] [<f6f5f201>] [<c011cd0d>] [<c0107a40>] [<c0107ae4>]
Code: 83 3c 02 01 75 07 c7 04 02 00 00 00 00 8d 47 ff 0f b3 83 50

>>EIP; c011cd0d <force_sig_info+3d/a0>   <=====
Trace; c0107a40 <__up_wakeup+1ec4/2594>
Trace; c0107ae4 <__up_wakeup+1f68/2594>
Trace; c01c781f <proc_print_scsidevice+27f/340>
Trace; c01c4455 <scsi_release_command+195/1e0>
Trace; c01b923e <atapi_output_bytes+3e/70>
Trace; c0106e08 <__up_wakeup+128c/2594>
Trace; c01ba410 <ide_wait_stat+3d0/440>
Trace; c01ba773 <ide_stall_queue+2c3/310>
Trace; c01bac34 <ide_intr+124/150>
Trace; c01d4740 <scsi_free+8820/11130>
Trace; c01080da <__up_wakeup+255e/2594>
Trace; c010825d <enable_irq+ed/130>
Trace; c010a51e <disable_irq_nosync+1c6e/3430>
Trace; c01080d0 <__up_wakeup+2554/2594>
Trace; c010825d <enable_irq+ed/130>
Trace; c010a51e <disable_irq_nosync+1c6e/3430>
Trace; c01080d0 <__up_wakeup+2554/2594>
Trace; c010825d <enable_irq+ed/130>
Trace; c010a51e <disable_irq_nosync+1c6e/3430>
Trace; c0119072 <get_fast_time+7d2/910>
Trace; c010828f <enable_irq+11f/130>
Trace; f6f5f251 <END_OF_CODE+36c27105/????>
Trace; c010a51e <disable_irq_nosync+1c6e/3430>
Trace; f6f5f251 <END_OF_CODE+36c27105/????>
Trace; c0107282 <__up_wakeup+1706/2594>
Trace; c011cd0d <force_sig_info+3d/a0>
Trace; c01128f7 <__verify_write+607/910>
Trace; c0112560 <__verify_write+270/910>
Trace; c0106e08 <__up_wakeup+128c/2594>
Trace; f6f5f1fd <END_OF_CODE+36c270b1/????>
Trace; f6f5f201 <END_OF_CODE+36c270b5/????>
Trace; c011cd0d <force_sig_info+3d/a0>
Trace; c0107a40 <__up_wakeup+1ec4/2594>
Trace; c0107ae4 <__up_wakeup+1f68/2594>
Code;  c011cd0d <force_sig_info+3d/a0>
00000000 <_EIP>:
Code;  c011cd0d <force_sig_info+3d/a0>   <=====
   0:   83 3c 02 01               cmpl   $0x1,(%edx,%eax,1)   <=====
Code;  c011cd11 <force_sig_info+41/a0>
   4:   75 07                     jne    d <_EIP+0xd> c011cd1a <force_sig_info+4a/a0>
Code;  c011cd13 <force_sig_info+43/a0>
   6:   c7 04 02 00 00 00 00      movl   $0x0,(%edx,%eax,1)
Code;  c011cd1a <force_sig_info+4a/a0>
   d:   8d 47 ff                  lea    0xffffffff(%edi),%eax
Code;  c011cd1d <force_sig_info+4d/a0>
  10:   0f b3 83 50 00 00 00      btr    %eax,0x50(%ebx)

 <0>Kernel panic: Aiee, killing interrupt handler!

2 warnings and 1 error issued.  Results may not be reliable.

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  8:00pm  up 12 min,  2 users,  load average: 0.02, 0.39, 0.32

