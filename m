Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129238AbRBGBgr>; Tue, 6 Feb 2001 20:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbRBGBgg>; Tue, 6 Feb 2001 20:36:36 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:28676 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S129238AbRBGBg3>; Tue, 6 Feb 2001 20:36:29 -0500
Date: Tue, 6 Feb 2001 20:36:27 -0500 (EST)
From: Arthur Pedyczak <arthur-p@home.com>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Oopses in 2.4.1  (lots of them) 
Message-ID: <Pine.LNX.4.30.0102062018320.1053-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I have a misfortune of reporting yet another Oops in 2.4.1  (my previous
report got ignored). After running for 4 days I got many, many oopses.
They were trigerred by xscreensaver, and some other X-related apps.
After dopping to runlevel 3, the system seemed O.K. Nothing unusual in
process table, no zombies etc. I could restart the X server itself, bu any
attemp to start gdm would generate yet another Oops. Had to reboot.

Ideas/suggestions/Help appreciated

Arthur

==========================================================================================
My hardware:
PIII 450
motherboard: Asus P2B
384 MB RAM (no swap)
ide: PIIX4
ide0  hda: WDC AC313000R, ATA DISK drive
      hdb: MATSHITA CR-589, ATAPI CDROM drive
ide1  hdc: WDC WD200BB-00AUA1, ATA DISK drive
      hdd: MITSBICDRW4420a, ATAPI CDROM drive (ide-scsi)
graphics: Riva TNT2
sound: es1370
eth0  eepro100
eth1  3c59x
=======================
ksymoops output:
=======================
ksymoops 2.3.4 on i686 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb  6 16:41:46 cs865114-a kernel: Unable to handle kernel paging request at virtual address 0909093e
Feb  6 16:41:46 cs865114-a kernel: c0131ce1
Feb  6 16:41:46 cs865114-a kernel: *pde = 00000000
Feb  6 16:41:46 cs865114-a kernel: Oops: 0002
Feb  6 16:41:46 cs865114-a kernel: CPU:    0
Feb  6 16:41:46 cs865114-a kernel: EIP:    0010:[file_move+25/44]
Feb  6 16:41:46 cs865114-a kernel: EFLAGS: 00210282
Feb  6 16:41:46 cs865114-a kernel: eax: 0909093a   ebx: d7937440   ecx: cb456600   edx: c6c35a20
Feb  6 16:41:46 cs865114-a kernel: esi: d5d16600   edi: ffffffe9   ebp: d7a1c320   esp: c3a65f48
Feb  6 16:41:46 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 16:41:46 cs865114-a kernel: Process xroger (pid: 1066, stackpage=c3a65000)
Feb  6 16:41:46 cs865114-a kernel: Stack: cb456600 c0130a6e cb456600 d7937440 400134a0 c3aa4000 00000000 c3aa4000
Feb  6 16:41:46 cs865114-a kernel:        c01309ba d79d01c0 d7a1c320 00000000 c3a64000 00000003 08048984 d79d01c0
Feb  6 16:41:46 cs865114-a kernel:        d7a1c320 08048984 c3aa4000 00000003 00000001 00000001 c0130cac c3aa4000
Feb  6 16:41:46 cs865114-a kernel: Call Trace: [dentry_open+170/328] [filp_open+82/92] [sys_open+56/180] [system_call+51/56]
Feb  6 16:41:46 cs865114-a kernel: Code: 89 48 04 89 01 89 59 04 89 0b 90 8d 74 26 00 5b c3 89 f6 53
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  00000008 Before first symbol
   8:   89 0b                     mov    %ecx,(%ebx)
Code;  0000000a Before first symbol
   a:   90                        nop
Code;  0000000b Before first symbol
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000f Before first symbol
   f:   5b                        pop    %ebx
Code;  00000010 Before first symbol
  10:   c3                        ret
Code;  00000011 Before first symbol
  11:   89 f6                     mov    %esi,%esi
Code;  00000013 Before first symbol
  13:   53                        push   %ebx

Feb  6 16:51:46 cs865114-a kernel: Unable to handle kernel paging request at virtual address 0909093e
Feb  6 16:51:46 cs865114-a kernel: c0131ce1
Feb  6 16:51:46 cs865114-a kernel: *pde = 00000000
Feb  6 16:51:46 cs865114-a kernel: Oops: 0002
Feb  6 16:51:46 cs865114-a kernel: CPU:    0
Feb  6 16:51:46 cs865114-a kernel: EIP:    0010:[file_move+25/44]
Feb  6 16:51:46 cs865114-a kernel: EFLAGS: 00210282
Feb  6 16:51:46 cs865114-a kernel: eax: 0909093a   ebx: d7937440   ecx: c961a5a0   edx: c6c35d80
Feb  6 16:51:46 cs865114-a kernel: esi: d5d16600   edi: ffffffe9   ebp: d7a1c320   esp: d1de7f48
Feb  6 16:51:46 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 16:51:46 cs865114-a kernel: Process xroger (pid: 1080, stackpage=d1de7000)
Feb  6 16:51:46 cs865114-a kernel: Stack: c961a5a0 c0130a6e c961a5a0 d7937440 400134a0 d7140000 00000000 d7140000
Feb  6 16:51:46 cs865114-a kernel:        c01309ba d79d01c0 d7a1c320 00000000 d1de6000 00000003 08048984 d79d01c0
Feb  6 16:51:46 cs865114-a kernel:        d7a1c320 08048984 d7140000 00000003 00000001 00000001 c0130cac d7140000
Feb  6 16:51:46 cs865114-a kernel: Call Trace: [dentry_open+170/328] [filp_open+82/92] [sys_open+56/180] [system_call+51/56]
Feb  6 16:51:46 cs865114-a kernel: Code: 89 48 04 89 01 89 59 04 89 0b 90 8d 74 26 00 5b c3 89 f6 53

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  00000008 Before first symbol
   8:   89 0b                     mov    %ecx,(%ebx)
Code;  0000000a Before first symbol
   a:   90                        nop
Code;  0000000b Before first symbol
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000f Before first symbol
   f:   5b                        pop    %ebx
Code;  00000010 Before first symbol
  10:   c3                        ret
Code;  00000011 Before first symbol
  11:   89 f6                     mov    %esi,%esi
Code;  00000013 Before first symbol
  13:   53                        push   %ebx

Feb  6 17:01:46 cs865114-a kernel: Unable to handle kernel paging request at virtual address 0909093e
Feb  6 17:01:46 cs865114-a kernel: c0131ce1
Feb  6 17:01:46 cs865114-a kernel: *pde = 00000000
Feb  6 17:01:46 cs865114-a kernel: Oops: 0002
Feb  6 17:01:46 cs865114-a kernel: CPU:    0
Feb  6 17:01:46 cs865114-a kernel: EIP:    0010:[file_move+25/44]
Feb  6 17:01:46 cs865114-a kernel: EFLAGS: 00210282
Feb  6 17:01:46 cs865114-a kernel: eax: 0909093a   ebx: d7937440   ecx: cf0f8a40   edx: cb0f9680
Feb  6 17:01:46 cs865114-a kernel: esi: d5d16600   edi: ffffffe9   ebp: d7a1c320   esp: d1de7f48
Feb  6 17:01:46 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 17:01:46 cs865114-a kernel: Process xroger (pid: 1098, stackpage=d1de7000)
Feb  6 17:01:46 cs865114-a kernel: Stack: cf0f8a40 c0130a6e cf0f8a40 d7937440 400134a0 d4223000 00000000 d4223000
Feb  6 17:01:46 cs865114-a kernel:        c01309ba d79d01c0 d7a1c320 00000000 d1de6000 00000003 08048984 d79d01c0
Feb  6 17:01:46 cs865114-a kernel:        d7a1c320 08048984 d4223000 00000003 00000001 00000001 c0130cac d4223000
Feb  6 17:01:46 cs865114-a kernel: Call Trace: [dentry_open+170/328] [filp_open+82/92] [sys_open+56/180] [system_call+51/56]
Feb  6 17:01:46 cs865114-a kernel: Code: 89 48 04 89 01 89 59 04 89 0b 90 8d 74 26 00 5b c3 89 f6 53

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  00000008 Before first symbol
   8:   89 0b                     mov    %ecx,(%ebx)
Code;  0000000a Before first symbol
   a:   90                        nop
Code;  0000000b Before first symbol
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000f Before first symbol
   f:   5b                        pop    %ebx
Code;  00000010 Before first symbol
  10:   c3                        ret
Code;  00000011 Before first symbol
  11:   89 f6                     mov    %esi,%esi
Code;  00000013 Before first symbol
  13:   53                        push   %ebx

Feb  6 17:11:46 cs865114-a kernel: Unable to handle kernel paging request at virtual address 0909093e
Feb  6 17:11:46 cs865114-a kernel: c0131ce1
Feb  6 17:11:46 cs865114-a kernel: *pde = 00000000
Feb  6 17:11:46 cs865114-a kernel: Oops: 0002
Feb  6 17:11:46 cs865114-a kernel: CPU:    0
Feb  6 17:11:46 cs865114-a kernel: EIP:    0010:[file_move+25/44]
Feb  6 17:11:46 cs865114-a kernel: EFLAGS: 00210282
Feb  6 17:11:46 cs865114-a kernel: eax: 0909093a   ebx: d7937440   ecx: c3958620   edx: cb0f9680
Feb  6 17:11:46 cs865114-a kernel: esi: d5d16600   edi: ffffffe9   ebp: d7a1c320   esp: d1de7f48
Feb  6 17:11:46 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 17:11:46 cs865114-a kernel: Process xroger (pid: 1114, stackpage=d1de7000)
Feb  6 17:11:46 cs865114-a kernel: Stack: c3958620 c0130a6e c3958620 d7937440 400134a0 c8392000 00000000 c8392000
Feb  6 17:11:46 cs865114-a kernel:        c01309ba d79d01c0 d7a1c320 00000000 d1de6000 00000003 08048984 d79d01c0
Feb  6 17:11:46 cs865114-a kernel:        d7a1c320 08048984 c8392000 00000003 00000001 00000001 c0130cac c8392000
Feb  6 17:11:46 cs865114-a kernel: Call Trace: [dentry_open+170/328] [filp_open+82/92] [sys_open+56/180] [system_call+51/56]
Feb  6 17:11:46 cs865114-a kernel: Code: 89 48 04 89 01 89 59 04 89 0b 90 8d 74 26 00 5b c3 89 f6 53

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  00000003 Before first symbol
   3:   89 01                     mov    %eax,(%ecx)
Code;  00000005 Before first symbol
   5:   89 59 04                  mov    %ebx,0x4(%ecx)
Code;  00000008 Before first symbol
   8:   89 0b                     mov    %ecx,(%ebx)
Code;  0000000a Before first symbol
   a:   90                        nop
Code;  0000000b Before first symbol
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000f Before first symbol
   f:   5b                        pop    %ebx
Code;  00000010 Before first symbol
  10:   c3                        ret
Code;  00000011 Before first symbol
  11:   89 f6                     mov    %esi,%esi
Code;  00000013 Before first symbol
  13:   53                        push   %ebx


1 warning issued.  Results may not be reliable.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
