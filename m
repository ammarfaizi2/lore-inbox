Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318473AbSGSIam>; Fri, 19 Jul 2002 04:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318474AbSGSIam>; Fri, 19 Jul 2002 04:30:42 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:34697 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318473AbSGSIal>; Fri, 19 Jul 2002 04:30:41 -0400
Date: Fri, 19 Jul 2002 10:34:03 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] Floppy oops with 2.5.26
Message-Id: <20020719103403.4daaf6b4.reality@delusion.de>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Following oops happened with 2.5.26 when trying to mount a disk in /dev/fd0.

Regards,
-Udo.

VFS: Disk change detected on device fd(2,0)
generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)

ksymoops 2.4.5 on i686 2.5.26.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.26/ (default)
     -m /boot/System.map-2.5.26 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000094
c01e5727
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01e5727>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000094   ecx: c03dc000   edx: c03dde60
esi: 00000000   edi: c1008708   ebp: efcf1640   esp: c03dde2c
ds: 0018   es: 0018   ss: 0018
Stack: c03dde58 c03dde74 c01ee293 00000000 efcf1640 00000000 c03dde74
efcf1640 
       00000200 00000001 ef500200 00000001 00000000 c03dde60 c03dde60
c1008708 
       00000400 00000000 00000000 00000000 efcf1640 00000000 00000000
00000001 
Call Trace: [<c01ee293>] [<c01ee1d0>] [<c01ee31a>] [<c01ee470>] [<c013bbeb>] 
   [<c01ee086>] [<c013bd7d>] [<c013c002>] [<c0135281>] [<c0135192>]
[<c0135597>] 
   [<c0106dab>] 
Code: 39 9e 94 00 00 00 74 40 ff 41 10 8b 53 04 8b 86 94 00 00 00 


>>EIP; c01e5727 <generic_unplug_device+17/80>   <=====

>>ecx; c03dc000 <END_OF_CODE+2642c/????>
>>edx; c03dde60 <END_OF_CODE+2828c/????>
>>edi; c1008708 <END_OF_CODE+c52b34/????>
>>ebp; efcf1640 <END_OF_CODE+2f93ba6c/????>
>>esp; c03dde2c <END_OF_CODE+28258/????>

Trace; c01ee293 <__floppy_read_block_0+b3/f0>
Trace; c01ee1d0 <floppy_rb0_complete+0/10>
Trace; c01ee31a <floppy_read_block_0+4a/60>
Trace; c01ee470 <floppy_revalidate+140/170>
Trace; c013bbeb <check_disk_change+7b/90>
Trace; c01ee086 <floppy_open+336/390>
Trace; c013bd7d <do_open+12d/310>
Trace; c013c002 <blkdev_open+22/30>
Trace; c0135281 <dentry_open+e1/1b0>
Trace; c0135192 <filp_open+52/60>
Trace; c0135597 <sys_open+37/80>
Trace; c0106dab <syscall_call+7/b>

Code;  c01e5727 <generic_unplug_device+17/80>
00000000 <_EIP>:
Code;  c01e5727 <generic_unplug_device+17/80>   <=====
   0:   39 9e 94 00 00 00         cmp    %ebx,0x94(%esi)   <=====
Code;  c01e572d <generic_unplug_device+1d/80>
   6:   74 40                     je     48 <_EIP+0x48> c01e576f <generic_unplug_device+5f/80>
Code;  c01e572f <generic_unplug_device+1f/80>
   8:   ff 41 10                  incl   0x10(%ecx)
Code;  c01e5732 <generic_unplug_device+22/80>
   b:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01e5735 <generic_unplug_device+25/80>
   e:   8b 86 94 00 00 00         mov    0x94(%esi),%eax
<6>note: mount[6832] exited with preempt_count 2

floppy driver state
-------------------
now=53287074 last interrupt=1198 diff=53285876 last called handler=c01e9fd0
timeout_message=lock fdc
last output bytes:
 0  0 0
 0  0 0
 0  0 0
 8 80 1196
 8 80 1196
 8 80 1196
 8 80 1196
 e 80 1197
13 80 1197
 0 90 1197
1a 90 1197
 0 90 1197
12 90 1197
 0 90 1198
14 90 1198
18 80 1198
 8 80 1198
 8 80 1198
 8 80 1198
 8 80 1198
last result at 1199
last redo_fd_request at 1199

status=80
fdc_busy=1
cont=00000000
CURRENT=00000000
command_status=-1

floppy0: floppy timeout called
no cont in shutdown!
floppy0: timeout handler died: floppy shutdown

