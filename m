Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbTDAREa>; Tue, 1 Apr 2003 12:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262682AbTDARE3>; Tue, 1 Apr 2003 12:04:29 -0500
Received: from photon.hao.ucar.edu ([128.117.16.7]:49099 "EHLO
	photon.hao.ucar.edu") by vger.kernel.org with ESMTP
	id <S262680AbTDARE1>; Tue, 1 Apr 2003 12:04:27 -0500
Message-Id: <200304011715.h31HFj515444@photon.hao.ucar.edu>
Date: Tue, 1 Apr 2003 10:15:45 -0700 (MST)
From: Barry Gamblin <bgamblin@hao.ucar.edu>
Reply-To: Barry Gamblin <bgamblin@hao.ucar.edu>
Subject: Oops 0002
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Swarm_of_Eels_298_000
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.3.5 SunOS 5.7 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Swarm_of_Eels_298_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: NcAYpDz1lxgfiN4/unEKcw==

I have a server that is hanging and/or crashing quite regularly. It has 
a Supermicro p4dc6 motherboard with dual Xeon 1.7G processors. I am 
using the onboard scsi with two 36G IBM drives and the onboard ethernet 
eepro100. I have it running Redhat 7.3 with the 2-4-18-19.7.xsmp kernel. 
The BIOS is version 1.0.

The last time it crashed it gave an Oops 0002 which I copied down from 
the screen. I ran that through ksymoops, but I do not really know what I 
am looking for. I have attached both the Oops text and the ksymoops 
output to this message. Can anyone tell from this what is going on? I 
need to get this machine stablized before it can go into production. I 
cannot tell if I have a software or a hardware problem.

Any help is greatly appreciated.

Thanks, Barry

Barry S. Gamblin, UNIX Administrator III, bgamblin@ucar.edu
High Altitude Observatory - National Center for Atmospheric Research
P.O.Box 3000, Boulder CO 80307-3000
voice - 303-497-1509  fax - 303-497-1589

--Swarm_of_Eels_298_000
Content-Type: TEXT/plain; name="oops.txt"; charset=us-ascii; x-unix-mode=0644
Content-Description: oops.txt
Content-MD5: i6M5b3MAXNge5OF54HpqGQ==

<1> Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
c012108b
*pde=00000000
Oops: 0002
nfsd autofs nfs lockd sunrpc eepro100 usb_uhci usbcore aic7xxx sd_mod scsi_mod
CPU: 0
EIP: 0010 [<c012108b>] Not tainted
EFLAGS: 00010a87

EIP is at sys_wait4 [kernel] 0xeb (2.4.18-19,7.xsmp)
eax: c0393c80 ebx: f6f20000 ecx: f748e000 edx: f748e000
esi: f748e000 edi: 00000000 ebp: ffffffff esp: e0000000
ds: 0018 es: 0018 ss: 0018
Process (pid:0, stackpage=dffff000)
Stack:
Call Trace:

Code: ab c8 90 51 53 02 00 00 f7 44 24 3c 00 00 00 80 8b 43 68 74
<0>Kernel Panic: Attempted to kill the idle task!
In idle task - not syncing

--Swarm_of_Eels_298_000
Content-Type: TEXT/plain; name="ksymoops.out"; charset=us-ascii; x-unix-mode=0644
Content-Description: ksymoops.out
Content-MD5: XVFhrk/u6SKg/BSVDlD7rg==

ksymoops 2.4.4 on i686 2.4.18-19.7.xsmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-19.7.xsmp/ (default)
     -m /boot/System.map-2.4.18-19.7.xsmp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
<1> Unable to handle kernel NULL pointer dereference at virtual address 00000000
c012108b
Oops: 0002
CPU: 0
EIP: 0010 [<c012108b>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a87
eax: c0393c80 ebx: f6f20000 ecx: f748e000 edx: f748e000
esi: f748e000 edi: 00000000 ebp: ffffffff esp: e0000000
ds: 0018 es: 0018 ss: 0018
Process (pid:0, stackpage=dffff000)
Code: ab c8 90 51 53 02 00 00 f7 44 24 3c 00 00 00 80 8b 43 68 74

>>EIP; c012108b <sys_wait4+eb/3f0>   <=====
Code;  c012108b <sys_wait4+eb/3f0>
00000000 <_EIP>:
Code;  c012108b <sys_wait4+eb/3f0>   <=====
   0:   ab                        stos   %eax,%es:(%edi)   <=====
Code;  c012108c <sys_wait4+ec/3f0>
   1:   c8 90 51 53               enter  $0x5190,$0x53
Code;  c0121090 <sys_wait4+f0/3f0>
   5:   02 00                     add    (%eax),%al
Code;  c0121092 <sys_wait4+f2/3f0>
   7:   00 f7                     add    %dh,%bh
Code;  c0121094 <sys_wait4+f4/3f0>
   9:   44                        inc    %esp
Code;  c0121095 <sys_wait4+f5/3f0>
   a:   24 3c                     and    $0x3c,%al
Code;  c0121097 <sys_wait4+f7/3f0>
   c:   00 00                     add    %al,(%eax)
Code;  c0121099 <sys_wait4+f9/3f0>
   e:   00 80 8b 43 68 74         add    %al,0x7468438b(%eax)

<0>Kernel Panic: Attempted to kill the idle task!

1 warning and 3 errors issued.  Results may not be reliable.

--Swarm_of_Eels_298_000--
