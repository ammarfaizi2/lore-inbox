Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRHFEGN>; Mon, 6 Aug 2001 00:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266641AbRHFEGD>; Mon, 6 Aug 2001 00:06:03 -0400
Received: from cm-24-169-216-117.nycap.rr.com ([24.169.216.117]:22026 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S266606AbRHFEFu>; Mon, 6 Aug 2001 00:05:50 -0400
Date: Mon, 6 Aug 2001 00:06:00 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.4.6's drivers/scsi/in2000.c
Message-ID: <20010806000600.A2269@mp3revolution.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux incandescent 2.4.6 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

2.4.6, oops run through ksymoops is attached.  This was a kernel w/ all
scsi drivers compiled in statically (and modules disabled), hence there
were no actual in2000 cards in the machine.  If more info is needed, let
me know.

-- 
"... being a Linux user is sort of like living in a house inhabited
by a large family of carpenters and architects. Every morning when
you wake up, the house is a little different. Maybe there is a new
turret, or some walls have moved. Or perhaps someone has temporarily
removed the floor under your bed." - Unix for Dummies, 2nd Edition
        -- found in the .sig of Rob Riggs, rriggs@tesser.com

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.ksym"

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -v linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m linux/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 000c8010
c034cc11
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c034cc11>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 000c8000   ecx: 00000005   edx: c035a210
esi: 00000000   edu: 00000000   ebp: 00000000   esp: c15f9efc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c15f9000)
Stack: c037a03c 00000000 00000000 0008e000 c01891c1 00000000 c02ef820 0000002b
       00000282 00000000 c037e52e c037e503 c02ea484 00000001 00000282 c15f9f54
       c15f9f58 c15f9f5c c037a038 c0302040 00000000 c037a038 c0339fd8 00000000
Call Trace: [<c01891c1>] [<c01a2b8a>] [<c01a255f>] [<c01598e5>] [<c01a2da6>] [<c0105013>] [<c0105434>]
Code: 8b 4b 10 89 44 24 34 81 f9 4e 4f 56 41 74 15 8b 43 30 8d 55

>>EIP; c034cc11 <in2000_detect+ad/62c>   <=====
Trace; c01891c1 <vt_console_print+2c1/2d8>
Trace; c01a2b8a <scsi_unregister_host+3ae/41c>
Trace; c01a255f <scsi_register_host+57/2d4>
Trace; c01598e5 <devfs_mk_dir+4d/e8>
Trace; c01a2da6 <scsi_register_module+2a/4c>
Trace; c0105013 <init+7/114>
Trace; c0105434 <kernel_thread+28/38>
Code;  c034cc11 <in2000_detect+ad/62c>
00000000 <_EIP>:
Code;  c034cc11 <in2000_detect+ad/62c>   <=====
   0:   8b 4b 10                  mov    0x10(%ebx),%ecx   <=====
Code;  c034cc14 <in2000_detect+b0/62c>
   3:   89 44 24 34               mov    %eax,0x34(%esp,1)
Code;  c034cc18 <in2000_detect+b4/62c>
   7:   81 f9 4e 4f 56 41         cmp    $0x41564f4e,%ecx
Code;  c034cc1e <in2000_detect+ba/62c>
   d:   74 15                     je     24 <_EIP+0x24> c034cc35 <in2000_detect+d1/62c>
Code;  c034cc20 <in2000_detect+bc/62c>
   f:   8b 43 30                  mov    0x30(%ebx),%eax
Code;  c034cc23 <in2000_detect+bf/62c>
  12:   8d 55 00                  lea    0x0(%ebp),%edx

Kernel panic: Attempted to kill init!

--Kj7319i9nmIyA2yE--
