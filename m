Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266217AbSIRL6Y>; Wed, 18 Sep 2002 07:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266280AbSIRL6Y>; Wed, 18 Sep 2002 07:58:24 -0400
Received: from ulima.unil.ch ([130.223.144.143]:54400 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S266217AbSIRL6V>;
	Wed, 18 Sep 2002 07:58:21 -0400
Date: Wed, 18 Sep 2002 14:03:21 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.36 oops at boot
Message-ID: <20020918120321.GA6167@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ksymoops -m /usr/src/linux/System.map  -v /usr/src/linux/vmlinux  -K -O -L < 2536-boot                                     18.09 13:52
ksymoops 2.3.5 on i686 2.4.20-pre5.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux/System.map (specified)

cpu: 0, clocks: 99676, slice: 49838
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c011663a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: d7ffc220   ecx: d1c26000   edx: 00000002
esi: d1d48600   edi: 00000000   ebp: d1c27f8c   esp: d1c27f74
ds: 0068   es: 0068   ss: 0068
Stack: c011d842 d1d48600 00000011 d7ffc220 d1d48600 00000000 d1c27fb0 c011dc06 
       d7ffc220 d7cc9240 40140667 d1c27fbc d1c26000 401422dc 00000000 d1c27fbc 
       c011dc95 00000000 bffffd38 c01079ab 00000000 00001000 40143340 401422dc 
Call Trace: [<c011d842>] [<c011dc06>] [<c011dc95>] [<c01079ab>] 
Code: 0f 0b b0 03 45 e7 2d c0 e9 39 fd ff ff 90 90 8d b4 26 00 00 

>>EIP; c011663a <schedule+2ea/300>   <=====
Trace; c011d842 <exit_notify+a2/220>
Trace; c011dc06 <do_exit+246/2a0>
Trace; c011dc95 <sys_exit+15/20>
Trace; c01079ab <syscall_call+7/b>
Code;  c011663a <schedule+2ea/300>
00000000 <_EIP>:
Code;  c011663a <schedule+2ea/300>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011663c <schedule+2ec/300>
   2:   b0 03                     mov    $0x3,%al
Code;  c011663e <schedule+2ee/300>
   4:   45                        inc    %ebp
Code;  c011663f <schedule+2ef/300>
   5:   e7 2d                     out    %eax,$0x2d
Code;  c0116641 <schedule+2f1/300>
   7:   c0 e9 39                  shr    $0x39,%cl
Code;  c0116644 <schedule+2f4/300>
   a:   fd                        std    
Code;  c0116645 <schedule+2f5/300>
   b:   ff                        (bad)  
Code;  c0116646 <schedule+2f6/300>
   c:   ff 90 90 8d b4 26         call   *0x26b48d90(%eax)

kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c011663a>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: d1c26000   edx: 00000004
esi: d1d48600   edi: 0000000b   ebp: d1c27e4c   esp: d1c27e34
ds: 0068   es: 0068   ss: 0068
Stack: c011d842 d1d48600 00000011 00000000 d1d48600 0000000b d1c27e70 c011dc06 
       0000000b d1d4885a 0000000d 00000002 d1c26000 d1c27f40 c0108ac0 d1c27e8c 
       c0108956 0000000b c02d983e 00000000 d7ffc220 00000000 d1c27f30 c0108b1d 
Call Trace: [<c011d842>] [<c011dc06>] [<c0108ac0>] [<c0108956>] [<c0108b1d>] 
   [<c011663a>] [<c01268f5>] [<c012517b>] [<c0158580>] [<c010838d>] [<c011663a>] 
   [<c011d842>] [<c011dc06>] [<c011dc95>] [<c01079ab>] 
Code: 0f 0b b0 03 45 e7 2d c0 e9 39 fd ff ff 90 90 8d b4 26 00 00 

>>EIP; c011663a <schedule+2ea/300>   <=====
Trace; c011d842 <exit_notify+a2/220>
Trace; c011dc06 <do_exit+246/2a0>
Trace; c0108ac0 <do_invalid_op+0/70>
Trace; c0108956 <die+86/90>
Trace; c0108b1d <do_invalid_op+5d/70>
Trace; c011663a <schedule+2ea/300>
Trace; c01268f5 <wake_up_parent+45/c0>
Trace; c012517b <do_notify_parent+ab/110>
Trace; c0158580 <dput+30/150>
Trace; c010838d <error_code+2d/38>
Trace; c011663a <schedule+2ea/300>
Trace; c011d842 <exit_notify+a2/220>
Trace; c011dc06 <do_exit+246/2a0>
Trace; c011dc95 <sys_exit+15/20>
Trace; c01079ab <syscall_call+7/b>
Code;  c011663a <schedule+2ea/300>
00000000 <_EIP>:
Code;  c011663a <schedule+2ea/300>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011663c <schedule+2ec/300>
   2:   b0 03                     mov    $0x3,%al
Code;  c011663e <schedule+2ee/300>
   4:   45                        inc    %ebp
Code;  c011663f <schedule+2ef/300>
   5:   e7 2d                     out    %eax,$0x2d
Code;  c0116641 <schedule+2f1/300>
   7:   c0 e9 39                  shr    $0x39,%cl
Code;  c0116644 <schedule+2f4/300>
   a:   fd                        std    
Code;  c0116645 <schedule+2f5/300>
   b:   ff                        (bad)  
Code;  c0116646 <schedule+2f6/300>
   c:   ff 90 90 8d b4 26         call   *0x26b48d90(%eax)

kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c011663a>]    Not tainted
EFLAGS: 00010206
eax: 00000000   ebx: 00000000   ecx: d1c26000   edx: 00000006
esi: d1d48600   edi: 0000000b   ebp: d1c27d0c   esp: d1c27cf4
ds: 0068   es: 0068   ss: 0068
Stack: c011d842 d1d48600 00000011 00000000 d1d48600 0000000b d1c27d30 c011dc06 
       0000000b d1d4885a 0000000d 00000004 d1c26000 d1c27e00 c0108ac0 d1c27d4c 
       c0108956 0000000b c02d983e 00000000 00000000 00000000 d1c27df0 c0108b1d 
Call Trace: [<c011d842>] [<c011dc06>] [<c0108ac0>] [<c0108956>] [<c0108b1d>] 
   [<c011663a>] [<c01268f5>] [<c012517b>] [<c011a375>] [<c010838d>] [<c0110068>] 
   [<c011663a>] [<c011d842>] [<c011dc06>] [<c0108ac0>] [<c0108956>] [<c0108b1d>] 
   [<c011663a>] [<c01268f5>] [<c012517b>] [<c0158580>] [<c010838d>] [<c011663a>] 
   [<c011d842>] [<c011dc06>] [<c011dc95>] [<c01079ab>] 
Code: 0f 0b b0 03 45 e7 2d c0 e9 39 fd ff ff 90 90 8d b4 26 00 00 

>>EIP; c011663a <schedule+2ea/300>   <=====
Trace; c011d842 <exit_notify+a2/220>
Trace; c011dc06 <do_exit+246/2a0>
Trace; c0108ac0 <do_invalid_op+0/70>
Trace; c0108956 <die+86/90>
Trace; c0108b1d <do_invalid_op+5d/70>
Trace; c011663a <schedule+2ea/300>
Trace; c01268f5 <wake_up_parent+45/c0>
Trace; c012517b <do_notify_parent+ab/110>
Trace; c011a375 <call_console_drivers+65/120>
Trace; c010838d <error_code+2d/38>
Trace; c0110068 <mtrr_add+28/80>
Trace; c011663a <schedule+2ea/300>
Trace; c011d842 <exit_notify+a2/220>
Trace; c011dc06 <do_exit+246/2a0>
Trace; c0108ac0 <do_invalid_op+0/70>
Trace; c0108956 <die+86/90>
Trace; c0108b1d <do_invalid_op+5d/70>
Trace; c011663a <schedule+2ea/300>
Trace; c01268f5 <wake_up_parent+45/c0>
Trace; c012517b <do_notify_parent+ab/110>
Trace; c0158580 <dput+30/150>
Trace; c010838d <error_code+2d/38>
Trace; c011663a <schedule+2ea/300>
Trace; c011d842 <exit_notify+a2/220>
Trace; c011dc06 <do_exit+246/2a0>
Trace; c011dc95 <sys_exit+15/20>
Trace; c01079ab <syscall_call+7/b>
Code;  c011663a <schedule+2ea/300>
00000000 <_EIP>:
Code;  c011663a <schedule+2ea/300>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011663c <schedule+2ec/300>
   2:   b0 03                     mov    $0x3,%al
Code;  c011663e <schedule+2ee/300>
   4:   45                        inc    %ebp
Code;  c011663f <schedule+2ef/300>
   5:   e7 2d                     out    %eax,$0x2d
Code;  c0116641 <schedule+2f1/300>
   7:   c0 e9 39                  shr    $0x39,%cl
Code;  c0116644 <schedule+2f4/300>
   a:   fd                        std    
Code;  c0116645 <schedule+2f5/300>
   b:   ff                        (bad)  
Code;  c0116646 <schedule+2f6/300>
   c:   ff 90 90 8d b4 26         call   *0x26b48d90(%eax)

kernel BUG at sched.c:944!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c011663a>]    Not tainted
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: d1c26000   edx: 00000008
esi: d1d48600   edi: 0000000b   ebp: d1c27bcc   esp: d1c27bb4
ds: 0068   es: 0068   ss: 0068
Stack: c011d842 d1d48600 00000011 00000000 d1d48600 0000000b d1c27bf0 c011dc06 
       0000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c011663a <schedule+2ea/300>   <=====


1 warning issued.  Results may not be reliable.
Exit 1


My palm didn't got the whole log or???

I put the log under http://ulima.unil.ch/greg/linux/2536-boot in case it could
be needed ;-)

Linux ulima.unil.ch 2.4.20-pre5 #3 Thu Aug 29 13:07:39 CEST 2002 i686 unknown unknown GNU/Linux
 
Gnu C                  gcc-3.2 (GCC) 3.2 (Mandrake Linux 9.0 3.2-1mdk) Copyright (C) 2002 Free Software Foundation, Inc. This is free software; see the source for copying conditions. There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.27ea
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15

[root@ulima ~]# lspci -v
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at f0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff
	Prefetchable memory behind bridge: f6000000-f6ffffff

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at cce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 00000000f5000000-00000000f5f00000
	Capabilities: [dc] Power Management version 1

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
	Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at cc00 [size=128]
	Memory at ff000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at f9000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation Optiplex GX1 Onboard Display Adapter
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at ec00 [size=256]
	Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0

02:09.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 01)
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at faf00000 (32-bit, non-prefetchable) [size=1M]

02:0b.0 SCSI storage controller: Adaptec AHA-2940/2940W / AIC-7871
	Flags: bus master, medium devsel, latency 64, IRQ 10
	I/O ports at dc00 [size=256]
	Memory at faeff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fb000000 [disabled] [size=32K]

Just let me know if I could provide other infos ;-)

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
