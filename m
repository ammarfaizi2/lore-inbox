Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTEKSkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTEKSkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:40:21 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:24547 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP id S261849AbTEKSkN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:40:13 -0400
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
Date: Sun, 11 May 2003 20:52:10 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: [2.420] Unexplained repeatable Oops
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200305112052.51938.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello List;

On my main machine at home I have encountered since this morning an Oops that never happened before. It happened when I was playing a game of Diablo II through Winex (yes, with the Nvidia modules loaded and stuff loaded from VMWare). This oops I didn't bother to capture, since I know that oops'es from a tainted kernel are not accepted.

In the subsequent reboot I removed the nvidia module from the loading list, and the vmware stuff too. I changed the X driver to take nv instead of nvidia (to get XFree86 4.3's nvidia driver).

This, however has changed nothing: I'm still getting frequent oopses whenever I do something that is even only remotely graphically stressing - e.g. playing a movie, or a game.

Hardware:
- ---------------
root@whocares:/home/devilkin# lspci -v
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller (rev 13)
        Flags: bus master, medium devsel, latency 32
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Memory at fb001000 (32-bit, prefetchable) [size=4K]
        I/O ports at d000 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: e8000000-f7ffffff

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: ABIT Computer Corp.: Unknown device a702
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400 [size=16]
        Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 3
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 3
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e000 [size=128]
        Memory at fb000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs: Unknown device 8065
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at e400 [size=32]
        Capabilities: [dc] Power Management version 1

00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at e800 [size=8]
        Capabilities: [dc] Power Management version 1

01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4400] (rev a2) (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd: Unknown device 8711
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
        Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Memory at f0000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0


Modules loaded:
- ------------------------
root@whocares:/home/devilkin# lsmod
Module                  Size  Used by    Not tainted
agpgart                14108   0  (unused)
emu10k1                56072   1
sound                  53452   0  [emu10k1]
ac97_codec             10120   0  [emu10k1]
soundcore               3364   7  [emu10k1 sound]
visor                   8652   0  (unused)
usbserial              16316   0  [visor]
usb-storage            21528   0  (unused)
usb-uhci               21740   0  (unused)
usbcore                55200   1  [visor usbserial usb-storage usb-uhci]
via686a                 7968   0  (unused)
i2c-isa                 1292   0  (unused)
i2c-viapro              3924   0  (unused)
i2c-proc                6384   0  [via686a]
i2c-core               14604   0  [via686a i2c-isa i2c-viapro i2c-proc]
ide-scsi                7696   0
ide-cd                 27172   0
sg                     24668   0  (unused)
sr_mod                 13232   0  (unused)
cdrom                  28768   0  [ide-cd sr_mod]
sd_mod                 10060   0  (unused)
scsi_mod               82904   5  [usb-storage ide-scsi sg sr_mod sd_mod]
smbfs                  32976   0  (unused)
nfs                    65016   1
lockd                  48752   1  [nfs]
sunrpc                 59740   1  [nfs lockd]
loop                    8440   0  (unused)
rtc                     5948   0  (unused)
3c59x                  25264   1


The oops':
- ----------------
ksymoops 2.4.9 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 11 13:44:17 whocares kernel: Unable to handle kernel paging request at virtual address 08447e38
May 11 13:44:17 whocares kernel: c0131d3c
May 11 13:44:17 whocares kernel: *pde = 00000000
May 11 13:44:17 whocares kernel: Oops: 0000
May 11 13:44:17 whocares kernel: CPU:    0
May 11 13:44:17 whocares kernel: EIP:    0010:[<c0131d3c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 11 13:44:17 whocares kernel: EFLAGS: 00013293
May 11 13:44:17 whocares kernel: eax: d91000c0   ebx: d91000c0   ecx: d25db204   edx: 00003293
May 11 13:44:17 whocares kernel: esi: cfe43000   edi: 00000079   ebp: 08447e30   esp: d3e11f54
May 11 13:44:17 whocares kernel: ds: 0018   es: 0018   ss: 0018
May 11 13:44:17 whocares kernel: Process wineserver (pid: 388, stackpage=d3e11000)
May 11 13:44:17 whocares kernel: Stack: cfe43140 cfe43000 cfe43008 d3e11fbc c013e16b 00000000 080b55d8 080b5450 
May 11 13:44:17 whocares kernel:        c013eda4 d3e11fb4 d3e10000 00000022 080b5450 00000040 d23d65a8 00000040 
May 11 13:44:17 whocares kernel:        00000000 00000286 d3e10000 00000031 00000000 d3e11fb4 d28625c0 00000000 
May 11 13:44:17 whocares kernel: Call Trace:    [<c013e16b>] [<c013eda4>] [<c0106cf7>]
May 11 13:44:17 whocares kernel: Code: 8b 75 08 ff 4b 14 0f 94 c0 84 c0 0f 84 b9 00 00 00 53 e8 8d 


>>EIP; c0131d3c <fput+c/e0>   <=====

>>eax; d91000c0 <_end+18e48628/2079c568>
>>ebx; d91000c0 <_end+18e48628/2079c568>
>>ecx; d25db204 <_end+1232376c/2079c568>
>>esi; cfe43000 <_end+fb8b568/2079c568>
>>esp; d3e11f54 <_end+13b5a4bc/2079c568>

Trace; c013e16b <poll_freewait+2b/50>
Trace; c013eda4 <sys_poll+2d4/2f0>
Trace; c0106cf7 <system_call+33/38>

Code;  c0131d3c <fput+c/e0>
00000000 <_EIP>:
Code;  c0131d3c <fput+c/e0>   <=====
   0:   8b 75 08                  mov    0x8(%ebp),%esi   <=====
Code;  c0131d3f <fput+f/e0>
   3:   ff 4b 14                  decl   0x14(%ebx)
Code;  c0131d42 <fput+12/e0>
   6:   0f 94 c0                  sete   %al
Code;  c0131d45 <fput+15/e0>
   9:   84 c0                     test   %al,%al
Code;  c0131d47 <fput+17/e0>
   b:   0f 84 b9 00 00 00         je     ca <_EIP+0xca> c0131e06 <fput+d6/e0>
Code;  c0131d4d <fput+1d/e0>
  11:   53                        push   %ebx
Code;  c0131d4e <fput+1e/e0>
  12:   e8 8d 00 00 00            call   a4 <_EIP+0xa4> c0131de0 <fput+b0/e0>

May 11 13:44:17 whocares kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 11 13:44:17 whocares kernel: c0112cd8
May 11 13:44:17 whocares kernel: *pde = 00000000
May 11 13:44:17 whocares kernel: Oops: 0000
May 11 13:44:17 whocares kernel: CPU:    0
May 11 13:44:17 whocares kernel: EIP:    0010:[<c0112cd8>]    Not tainted
May 11 13:44:17 whocares kernel: EFLAGS: 00013046
May 11 13:44:17 whocares kernel: eax: 00000000   ebx: 00000000   ecx: d3e10000   edx: 00000001
May 11 13:44:17 whocares kernel: esi: d25db844   edi: 00000001   ebp: d3e11dc4   esp: d3e11dac
May 11 13:44:17 whocares kernel: ds: 0018   es: 0018   ss: 0018
May 11 13:44:17 whocares kernel: Process wineserver (pid: 388, stackpage=d3e11000)
May 11 13:44:17 whocares kernel: Stack: d25db840 d1ec1c40 c158d280 d25db844 00003282 00000001 d0b352c0 c01392a5 
May 11 13:44:17 whocares kernel:        d28a5dc0 d1ec1c40 c01392ce d1ec1c40 00000001 00000000 c0131d7c d1ec1c40 
May 11 13:44:17 whocares kernel:        d28a5dc0 d28a5dc0 00000000 d3f53040 00000003 c0130db5 d28a5dc0 d3f53040 
May 11 13:44:17 whocares kernel: Call Trace:    [<c01392a5>] [<c01392ce>] [<c0131d7c>] [<c0130db5>] [<c0117a08>]
May 11 13:44:17 whocares kernel:   [<c0117fdf>] [<c01072d6>] [<c0111f17>] [<c0111bc0>] [<c012b980>] [<c013e21b>]
May 11 13:44:17 whocares kernel:   [<c01a21f3>] [<c01d0ae3>] [<c0106de8>] [<c0131d3c>] [<c013e16b>] [<c013eda4>]
May 11 13:44:17 whocares kernel:   [<c0106cf7>]
May 11 13:44:17 whocares kernel: Code: 8b 03 0f 0d 00 3b 5d f4 75 9e ff 75 f8 9d 5b 5e 5f 89 ec 5d 


>>EIP; c0112cd8 <__wake_up+88/a0>   <=====

>>ecx; d3e10000 <_end+13b58568/2079c568>
>>esi; d25db844 <_end+12323dac/2079c568>
>>ebp; d3e11dc4 <_end+13b5a32c/2079c568>
>>esp; d3e11dac <_end+13b5a314/2079c568>

Trace; c01392a5 <pipe_release+75/90>
Trace; c01392ce <pipe_read_release+e/20>
Trace; c0131d7c <fput+4c/e0>
Trace; c0130db5 <filp_close+55/60>
Trace; c0117a08 <put_files_struct+58/c0>
Trace; c0117fdf <do_exit+af/240>
Trace; c01072d6 <die+56/60>
Trace; c0111f17 <do_page_fault+357/484>
Trace; c0111bc0 <do_page_fault+0/484>
Trace; c012b980 <__alloc_pages+40/160>
Trace; c013e21b <__pollwait+8b/90>
Trace; c01a21f3 <normal_poll+103/11f>
Trace; c01d0ae3 <sock_poll+23/30>
Trace; c0106de8 <error_code+34/3c>
Trace; c0131d3c <fput+c/e0>
Trace; c013e16b <poll_freewait+2b/50>
Trace; c013eda4 <sys_poll+2d4/2f0>
Trace; c0106cf7 <system_call+33/38>

Code;  c0112cd8 <__wake_up+88/a0>
00000000 <_EIP>:
Code;  c0112cd8 <__wake_up+88/a0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0112cda <__wake_up+8a/a0>
   2:   0f 0d 00                  prefetch (%eax)
Code;  c0112cdd <__wake_up+8d/a0>
   5:   3b 5d f4                  cmp    0xfffffff4(%ebp),%ebx
Code;  c0112ce0 <__wake_up+90/a0>
   8:   75 9e                     jne    ffffffa8 <_EIP+0xffffffa8> c0112c80 <__wake_up+30/a0>
Code;  c0112ce2 <__wake_up+92/a0>
   a:   ff 75 f8                  pushl  0xfffffff8(%ebp)
Code;  c0112ce5 <__wake_up+95/a0>
   d:   9d                        popf   
Code;  c0112ce6 <__wake_up+96/a0>
   e:   5b                        pop    %ebx
Code;  c0112ce7 <__wake_up+97/a0>
   f:   5e                        pop    %esi
Code;  c0112ce8 <__wake_up+98/a0>
  10:   5f                        pop    %edi
Code;  c0112ce9 <__wake_up+99/a0>
  11:   89 ec                     mov    %ebp,%esp
Code;  c0112ceb <__wake_up+9b/a0>
  13:   5d                        pop    %ebp

May 11 13:45:14 whocares kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
May 11 20:20:58 whocares kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
May 11 20:28:02 whocares kernel: Unable to handle kernel paging request at virtual address 7a8310cc
May 11 20:28:02 whocares kernel: c0131d3c
May 11 20:28:02 whocares kernel: *pde = 00000000
May 11 20:28:02 whocares kernel: Oops: 0000
May 11 20:28:02 whocares kernel: CPU:    0
May 11 20:28:02 whocares kernel: EIP:    0010:[<c0131d3c>]    Not tainted
May 11 20:28:02 whocares kernel: EFLAGS: 00010293
May 11 20:28:02 whocares kernel: eax: d791aec0   ebx: d791aec0   ecx: d779ae80   edx: 00000293
May 11 20:28:02 whocares kernel: esi: c947b000   edi: 11740038   ebp: 7a8310c4   esp: dc1dff20
May 11 20:28:02 whocares kernel: ds: 0018   es: 0018   ss: 0018
May 11 20:28:02 whocares kernel: Process X (pid: 227, stackpage=dc1df000)
May 11 20:28:03 whocares kernel: Stack: c947b170 c947b000 c947b008 dc1dff74 c013e16b 00000000 d5838d40 00000001 
May 11 20:28:03 whocares kernel:        c013e498 dc1dff6c 00000020 00000008 dc39c180 00000304 08000000 dc1de000 
May 11 20:28:03 whocares kernel:        00002d90 0000001c 00000000 00000000 c947b000 00000000 c013e820 0000001c 
May 11 20:28:03 whocares kernel: Call Trace:    [<c013e16b>] [<c013e498>] [<c013e820>] [<c0106cf7>]
May 11 20:28:03 whocares kernel: Code: 8b 75 08 ff 4b 14 0f 94 c0 84 c0 0f 84 b9 00 00 00 53 e8 8d 


>>EIP; c0131d3c <fput+c/e0>   <=====

>>eax; d791aec0 <_end+17663428/2079c568>
>>ebx; d791aec0 <_end+17663428/2079c568>
>>ecx; d779ae80 <_end+174e33e8/2079c568>
>>esi; c947b000 <_end+91c3568/2079c568>
>>esp; dc1dff20 <_end+1bf28488/2079c568>

Trace; c013e16b <poll_freewait+2b/50>
Trace; c013e498 <do_select+1c8/1e0>
Trace; c013e820 <sys_select+340/480>
Trace; c0106cf7 <system_call+33/38>

Code;  c0131d3c <fput+c/e0>
00000000 <_EIP>:
Code;  c0131d3c <fput+c/e0>   <=====
   0:   8b 75 08                  mov    0x8(%ebp),%esi   <=====
Code;  c0131d3f <fput+f/e0>
   3:   ff 4b 14                  decl   0x14(%ebx)
Code;  c0131d42 <fput+12/e0>
   6:   0f 94 c0                  sete   %al
Code;  c0131d45 <fput+15/e0>
   9:   84 c0                     test   %al,%al
Code;  c0131d47 <fput+17/e0>
   b:   0f 84 b9 00 00 00         je     ca <_EIP+0xca> c0131e06 <fput+d6/e0>
Code;  c0131d4d <fput+1d/e0>
  11:   53                        push   %ebx
Code;  c0131d4e <fput+1e/e0>
  12:   e8 8d 00 00 00            call   a4 <_EIP+0xa4> c0131de0 <fput+b0/e0>

May 11 20:28:28 whocares kernel:  <1>Unable to handle kernel paging request at virtual address fbc442e1
May 11 20:28:28 whocares kernel: c0141f86
May 11 20:28:28 whocares kernel: *pde = 00000000
May 11 20:28:28 whocares kernel: Oops: 0002
May 11 20:28:28 whocares kernel: CPU:    0
May 11 20:28:28 whocares kernel: EIP:    0010:[<c0141f86>]    Not tainted
May 11 20:28:28 whocares kernel: EFLAGS: 00010202
May 11 20:28:28 whocares kernel: eax: 00000002   ebx: fbc44285   ecx: 00000000   edx: d6aadf54
May 11 20:28:28 whocares kernel: esi: dc5dd006   edi: fbc442e1   ebp: c1588940   esp: d6aadef4
May 11 20:28:28 whocares kernel: ds: 0018   es: 0018   ss: 0018
May 11 20:28:28 whocares kernel: Process dircolors (pid: 1538, stackpage=d6aad000)
May 11 20:28:28 whocares kernel: Stack: 00000000 c15e3cc0 c15e3d28 c1588940 fbc442e1 c0139bc8 c1588940 d6aadf54 
May 11 20:28:28 whocares kernel:        d6aadf54 00000000 d6aadfa4 c15e3cc0 c013a327 c1588940 d6aadf54 00000000 
May 11 20:28:28 whocares kernel:        d6aadfa4 dc5dd000 00000000 00000009 bffff4dc 00000009 dc5dd008 00000000 
May 11 20:28:28 whocares kernel: Call Trace:    [<c0139bc8>] [<c013a327>] [<c013a5ca>] [<c013a74b>] [<c013a9a6>]
May 11 20:28:28 whocares kernel:   [<c0130340>] [<c0106cf7>]
May 11 20:28:28 whocares kernel: Code: 66 a5 a8 01 74 01 a4 eb 10 90 50 56 8b 44 24 18 50 e8 64 9a 


>>EIP; c0141f86 <d_alloc+96/180>   <=====

>>edx; d6aadf54 <_end+167f64bc/2079c568>
>>esi; dc5dd006 <_end+1c32556e/2079c568>
>>ebp; c1588940 <_end+12d0ea8/2079c568>
>>esp; d6aadef4 <_end+167f645c/2079c568>

Trace; c0139bc8 <real_lookup+38/c0>
Trace; c013a327 <link_path_walk+5d7/860>
Trace; c013a5ca <path_walk+1a/20>
Trace; c013a74b <path_lookup+1b/30>
Trace; c013a9a6 <__user_walk+26/40>
Trace; c0130340 <sys_access+90/130>
Trace; c0106cf7 <system_call+33/38>

Code;  c0141f86 <d_alloc+96/180>
00000000 <_EIP>:
Code;  c0141f86 <d_alloc+96/180>   <=====
   0:   66 a5                     movsw  %ds:(%esi),%es:(%edi)   <=====
Code;  c0141f88 <d_alloc+98/180>
   2:   a8 01                     test   $0x1,%al
Code;  c0141f8a <d_alloc+9a/180>
   4:   74 01                     je     7 <_EIP+0x7> c0141f8d <d_alloc+9d/180>
Code;  c0141f8c <d_alloc+9c/180>
   6:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c0141f8d <d_alloc+9d/180>
   7:   eb 10                     jmp    19 <_EIP+0x19> c0141f9f <d_alloc+af/180>
Code;  c0141f8f <d_alloc+9f/180>
   9:   90                        nop    
Code;  c0141f90 <d_alloc+a0/180>
   a:   50                        push   %eax
Code;  c0141f91 <d_alloc+a1/180>
   b:   56                        push   %esi
Code;  c0141f92 <d_alloc+a2/180>
   c:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c0141f96 <d_alloc+a6/180>
  10:   50                        push   %eax
Code;  c0141f97 <d_alloc+a7/180>
  11:   e8 64 9a 00 00            call   9a7a <_EIP+0x9a7a> c014ba00 <parse_options+a0/120>

May 11 20:28:28 whocares kernel:  <1>Unable to handle kernel paging request at virtual address a5c8de24
May 11 20:28:28 whocares kernel: c0129ae3
May 11 20:28:28 whocares kernel: *pde = 00000000
May 11 20:28:28 whocares kernel: Oops: 0000
May 11 20:28:28 whocares kernel: CPU:    0
May 11 20:28:28 whocares kernel: EIP:    0010:[<c0129ae3>]    Not tainted
May 11 20:28:28 whocares kernel: EFLAGS: 00010002
May 11 20:28:28 whocares kernel: eax: 74003f83   ebx: 001fc185   ecx: d5c7e000   edx: dff00000
May 11 20:28:28 whocares kernel: esi: c158e0c0   edi: 00000246   ebp: 000001f0   esp: d6e5fee8
May 11 20:28:28 whocares kernel: ds: 0018   es: 0018   ss: 0018
May 11 20:28:28 whocares kernel: Process bash (pid: 1530, stackpage=d6e5f000)
May 11 20:28:28 whocares kernel: Stack: 00000000 df721700 df721768 df777940 c0141f0b c158e0c0 000001f0 00000000 
May 11 20:28:28 whocares kernel:        df721700 df721768 df777940 00000004 c0139bc8 df777940 d6e5ff64 d6e5ff64 
May 11 20:28:28 whocares kernel:        00000000 d6e5ffa4 df721700 c013a327 df777940 d6e5ff64 00000000 d6e5ffa4 
May 11 20:28:28 whocares kernel: Call Trace:    [<c0141f0b>] [<c0139bc8>] [<c013a327>] [<c013a5ca>] [<c013a74b>]
May 11 20:28:28 whocares kernel:   [<c013a9a6>] [<c0137959>] [<c0106cf7>]
May 11 20:28:28 whocares kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75 23 8b 41 04 8b 11 89 42 04 


>>EIP; c0129ae3 <kmem_cache_alloc+83/e0>   <=====

>>ecx; d5c7e000 <_end+159c6568/2079c568>
>>edx; dff00000 <_end+1fc48568/2079c568>
>>esi; c158e0c0 <_end+12d6628/2079c568>
>>esp; d6e5fee8 <_end+16ba8450/2079c568>

Trace; c0141f0b <d_alloc+1b/180>
Trace; c0139bc8 <real_lookup+38/c0>
Trace; c013a327 <link_path_walk+5d7/860>
Trace; c013a5ca <path_walk+1a/20>
Trace; c013a74b <path_lookup+1b/30>
Trace; c013a9a6 <__user_walk+26/40>
Trace; c0137959 <sys_stat64+19/70>
Trace; c0106cf7 <system_call+33/38>

Code;  c0129ae3 <kmem_cache_alloc+83/e0>
00000000 <_EIP>:
Code;  c0129ae3 <kmem_cache_alloc+83/e0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c0129ae7 <kmem_cache_alloc+87/e0>
   4:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0129aea <kmem_cache_alloc+8a/e0>
   7:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  c0129aed <kmem_cache_alloc+8d/e0>
   a:   75 23                     jne    2f <_EIP+0x2f> c0129b12 <kmem_cache_alloc+b2/e0>
Code;  c0129aef <kmem_cache_alloc+8f/e0>
   c:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  c0129af2 <kmem_cache_alloc+92/e0>
   f:   8b 11                     mov    (%ecx),%edx
Code;  c0129af4 <kmem_cache_alloc+94/e0>
  11:   89 42 04                  mov    %eax,0x4(%edx)

May 11 20:29:13 whocares kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html

1 warning issued.  Results may not be reliable.

Any idea what this might be?

Thanks!

Jan
- -- 
"These are DARK TIMES for all mankind's HIGHEST VALUES!"
"These are DARK TIMES for FREEDOM and PROSPERITY!"
"These are GREAT TIMES to put your money on BAD GUY to kick the CRAP
out of MEGATON MAN!"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vpwDpuyeqyCEh60RAjLVAJ0WpckgUmK2aPruDHt5WWLoJKnlMgCfQ63W
7wViUGR1Aots2MW2MOla1wY=
=bfac
-----END PGP SIGNATURE-----

