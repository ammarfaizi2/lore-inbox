Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSE3WmE>; Thu, 30 May 2002 18:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316904AbSE3WmD>; Thu, 30 May 2002 18:42:03 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:11997 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S316903AbSE3WmB>; Thu, 30 May 2002 18:42:01 -0400
Message-ID: <3CF6AAB8.51EB64A4@delusion.de>
Date: Fri, 31 May 2002 00:42:00 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.19 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS]: 2.5.19 oopses when writing to floppy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I got the following oops when mcopy'ing to a floppy drive with no disk in it.
I won't be able to read my mail until Sunday, so if you need further info
it'll have to wait until then.

Regards,
-Udo.

ksymoops 2.4.4 on i686 2.5.19.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.19/ (default)
     -m /boot/System.map-2.5.19 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000098
c01d40da
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01d40da>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000286   ecx: 00000001   edx: 00000000
esi: e6317e78   edi: c155ec08   ebp: efcd1640   esp: e6317e34
ds: 0018   es: 0018   ss: 0018
Stack: e6317e5c c01de3c3 00000000 efcd1640 00000000 e6317e78 efcd1640 00000200 
       00000001 c0300200 00000001 00000000 e6317e64 e6317e64 c155ec08 00000400 
       00000000 00000000 00000000 efcd1640 00000000 00000000 00000001 00000000 
Call Trace: [<c01de3c3>] [<c01de300>] [<c01de44a>] [<c01de5a0>] [<c0134ffb>] 
   [<c01de1b6>] [<c013517c>] [<c0135382>] [<c012f191>] [<c012f0a2>] [<c012f447>] 
   [<c0106b47>] 
Code: 0f b3 82 98 00 00 00 19 c0 85 c0 74 19 8b 82 98 00 00 00 a8 

>>EIP; c01d40da <generic_unplug_device+a/40>   <=====
Trace; c01de3c3 <__floppy_read_block_0+b3/f0>
Trace; c01de300 <floppy_rb0_complete+0/10>
Trace; c01de44a <floppy_read_block_0+4a/60>
Trace; c01de5a0 <floppy_revalidate+140/170>
Trace; c0134ffb <check_disk_change+7b/90>
Trace; c01de1b6 <floppy_open+336/390>
Trace; c013517c <do_open+11c/280>
Trace; c0135382 <blkdev_open+22/30>
Trace; c012f191 <dentry_open+e1/190>
Trace; c012f0a2 <filp_open+52/60>
Trace; c012f447 <sys_open+37/80>
Trace; c0106b47 <syscall_call+7/b>
Code;  c01d40da <generic_unplug_device+a/40>
00000000 <_EIP>:
Code;  c01d40da <generic_unplug_device+a/40>   <=====
   0:   0f b3 82 98 00 00 00      btr    %eax,0x98(%edx)   <=====
Code;  c01d40e1 <generic_unplug_device+11/40>
   7:   19 c0                     sbb    %eax,%eax
Code;  c01d40e3 <generic_unplug_device+13/40>
   9:   85 c0                     test   %eax,%eax
Code;  c01d40e5 <generic_unplug_device+15/40>
   b:   74 19                     je     26 <_EIP+0x26> c01d4100 <generic_unplug_device+30/40>
Code;  c01d40e7 <generic_unplug_device+17/40>
   d:   8b 82 98 00 00 00         mov    0x98(%edx),%eax
Code;  c01d40ed <generic_unplug_device+1d/40>
  13:   a8 00                     test   $0x0,%al

VFS: Disk change detected on device fd(2,0)
generic_make_request: Trying to access nonexistent block-device 02:00 (0)

***oops***
floppy driver state
-------------------
now=39510 last interrupt=55 diff=39455 last called handler=c01d8620
timeout_message=lock fdc
last output bytes:
 0  0 0
 0  0 0
 0  0 0
 8 80 55
 8 80 55
 8 80 55
 8 80 55
 e 80 55
13 80 55
 0 90 55
1a 90 55
 0 90 55
12 90 55
 0 90 55
14 90 55
18 80 55
 8 80 55
 8 80 55
 8 80 55
 8 80 55
last result at 55
last redo_fd_request at 55

status=80
fdc_busy=1
cont=00000000
CURRENT=00000000
command_status=-1

floppy0: floppy timeout called
no cont in shutdown!
floppy0: timeout handler died: floppy shutdown
