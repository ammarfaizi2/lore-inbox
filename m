Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSCXOcB>; Sun, 24 Mar 2002 09:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293348AbSCXObw>; Sun, 24 Mar 2002 09:31:52 -0500
Received: from smtp.comcast.net ([24.153.64.2]:54209 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S293314AbSCXObn>;
	Sun, 24 Mar 2002 09:31:43 -0500
Date: Sun, 24 Mar 2002 09:28:16 -0500
From: Mike Farrell <gcckain@comcast.net>
Subject: Bug Report (paging request)
To: linux-kernel@vger.kernel.org
Message-id: <0GTH00H0EF0QUJ@mtaout03.icomcast.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes when I'm using my computer normally, all of my programs will 
segfault usually resulting in a kernel lockup (no alt+printscr response).

I am using "Linux 2.4.7 #7 SMP Wed Feb 13 15:20:25 EST 2002 i686"
and I have had NO other problems with this kernel until now.  I have recently 
added 256 mb of ram to my system but I don't think that should cause a 
problem since the system runs it well.

Here is the output of the kernel:

================kernel log output========================

Mar 24 08:52:21 darkbox kernel: Unable to handle kernel paging request at 
virtual address 0000ef08
Mar 24 08:52:21 darkbox kernel:  printing eip:
Mar 24 08:52:21 darkbox kernel: c0130c1e
Mar 24 08:52:21 darkbox kernel: *pde = 00000000
Mar 24 08:52:21 darkbox kernel: Oops: 0000
Mar 24 08:52:21 darkbox kernel: CPU:    0
Mar 24 08:52:21 darkbox kernel: EIP:    0010:[fput+6/212]
Mar 24 08:52:21 darkbox kernel: EFLAGS: 00010297
Mar 24 08:52:21 darkbox kernel: eax: 0000ef00   ebx: 0000ef00   ecx: ca4723ac
edx: ca0023ac
Mar 24 08:52:21 darkbox kernel: esi: c7bea000   edi: c7bea008   ebp: ca487f74
esp: ca487f20
Mar 24 08:52:21 darkbox kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 08:52:21 darkbox kernel: Process kdeinit (pid: 581, stackpage=ca487000)
Mar 24 08:52:21 darkbox kernel: Stack: c7bea050 c7bea000 c7bea008 ca487f74 
c013f29b 00000000 cc52ef00 00000080
Mar 24 08:52:21 darkbox kernel:        c013f5cf ca487f6c 00000004 00000001 
c7f51a58 00000001 00000304 ca486000
Mar 24 08:52:21 darkbox kernel:        00000049 00000008 00000000 00000000 
c7bea000 00000000 c013f950 00000008
Mar 24 08:52:21 darkbox kernel: Call Trace: [poll_freewait+43/68] 
[do_select+491/516] [sys_select+832/1148] [system_call+51/56]
Mar 24 08:52:21 darkbox kernel:
Mar 24 08:52:21 darkbox kernel: Code: 8b 6b 08 8b 73 0c 8b 7d 08 f0 ff 4b 14 
0f 94 c0 84 c0 0f 84
Mar 24 08:52:21 darkbox kernel: Unable to handle kernel paging request at 
virtual address 00006000
Mar 24 08:52:21 darkbox kernel:  printing eip:
Mar 24 08:52:21 darkbox kernel: c0110923
Mar 24 08:52:21 darkbox kernel: *pde = 00000000
Mar 24 08:52:21 darkbox kernel: Oops: 0000
Mar 24 08:52:21 darkbox kernel: CPU:    0
Mar 24 08:52:21 darkbox kernel: EIP:    0010:[__wake_up+67/200]
Mar 24 08:52:21 darkbox kernel: EFLAGS: 00010087
Mar 24 08:52:21 darkbox kernel: eax: c7bea03c   ebx: cd00f5e4   ecx: 00006000
edx: 00000001
Mar 24 08:52:21 darkbox kernel: esi: ca472460   edi: cdbdf5e0   ebp: ca487d98
esp: ca487d78
Mar 24 08:52:21 darkbox kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 08:52:21 darkbox kernel: Process kdeinit (pid: 581, stackpage=ca487000)
Mar 24 08:52:21 darkbox kernel: Stack: cdbdf5e0 ca472460 ca472460 c7bea03c 
cdbdf5e4 00000001 00000282 00000001
Mar 24 08:52:21 darkbox kernel:        ca78c760 c013a099 cc52e540 c1444f00 
c013a0ce ca472460 00000000 00000001
Mar 24 08:52:21 darkbox kernel:        c0130c51 ca472460 cc52e540 cc52e540 
00000006 00000000 00000001 c012fbf2
Mar 24 08:52:21 darkbox kernel: Call Trace: [pipe_release+117/136] 
[pipe_write_release+14/20] [fput+57/212] [filp_close+178/188] 
[put_files_struct+79/184] [do_exit+296/632] [die+86/88]
Mar 24 08:52:21 darkbox kernel:        [do_page_fault+883/1164] 
[do_page_fault+0/1164] [sock_def_readable+54/96] 
[unix_stream_sendmsg+630/824] [schedule+926/1448] [error_code+52/60] 
[fput+6/212] [poll_freewait+43/68]
Mar 24 08:52:21 darkbox kernel:        [do_select+491/516] 
[sys_select+832/1148] [system_call+51/56]
Mar 24 08:52:21 darkbox kernel:
Mar 24 08:52:21 darkbox kernel: Code: 8b 01 85 45 fc 74 66 31 c0 9c 5e fa f0 
fe 0d 00 e4 33 c0 0f
Mar 24 08:54:46 darkbox kernel: Bad swap offset entry 00c60000
Mar 24 08:54:46 darkbox kernel: swap_free: offset exceeds max
Mar 24 08:54:49 darkbox kernel: swap_free: offset exceeds max
Mar 24 08:55:59 darkbox su: (to root) kain on /dev/pts/1
Mar 24 08:56:05 darkbox kernel: VM: Bad swap entry 000a0000
Mar 24 08:56:05 darkbox kernel: VM: Bad swap entry 00050000
Mar 24 08:56:09 darkbox kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000008
Mar 24 08:56:09 darkbox kernel:  printing eip:
Mar 24 08:56:09 darkbox kernel: c0110923
Mar 24 08:56:09 darkbox kernel: *pde = 00000000
Mar 24 08:56:09 darkbox kernel: Oops: 0000
Mar 24 08:56:09 darkbox kernel: CPU:    0
Mar 24 08:56:09 darkbox kernel: EIP:    0010:[__wake_up+67/200]
Mar 24 08:56:09 darkbox kernel: EFLAGS: 00010087
Mar 24 08:56:09 darkbox kernel: eax: ca0023a4   ebx: 0012a1c0   ecx: 00000008
edx: 00000001
Mar 24 08:56:09 darkbox kernel: esi: ca8d5b00   edi: ca4723a8   ebp: cbbd5ee4
esp: cbbd5ec4
Mar 24 08:56:09 darkbox kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 08:56:09 darkbox kernel: Process ksmserver (pid: 576, 
stackpage=cbbd5000)Mar 24 08:56:09 darkbox kernel: Stack: ca4723a8 ca8d5b00 
ca8d5b54 ca0023a4 ca4723ac 00000001 00000282 00000001
Mar 24 08:56:09 darkbox kernel:        ca8d5b00 c021cf02 c9c01160 00000010 
c02502ae ca8d5b00 00000010 cbbd5f48
Mar 24 08:56:09 darkbox kernel:        cbbd5f80 cbbd5f48 ca4721ac c72c83a0 
00000000 ca8d5b00 ca8d57c0 00000000
Mar 24 08:56:09 darkbox kernel: Call Trace: [sock_def_readable+54/96] 
[unix_stream_sendmsg+630/824] [sock_sendmsg+105/136] [sock_write+178/188] 
[sys_write+143/196] [system_call+51/56]
Mar 24 08:56:09 darkbox kernel:
Mar 24 08:56:09 darkbox kernel: Code: 8b 01 85 45 fc 74 66 31 c0 9c 5e fa f0 
fe 0d 00 e4 33 c0 0f

====================Output of ver_linux script=============

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.24
util-linux             2.10m
mount                  2.10m
modutils               2.4.6
e2fsprogs              1.18
pcmcia-cs              3.1.17
PPP                    2.3.11
isdn4k-utils           3.1pre1a
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.6
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss NVdriver 
snd-seq-midi snd-seq-midi-event snd-seq snd-card-ens1371 snd-ens1371 snd-pcm 
snd-timer
snd-rawmidi snd-seq-device snd-ac97-codec snd-mixer snd tulip hid

============Other misc information===============

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 730.917
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1458.17

==========

snd-pcm-oss            18176   1 (autoclean)
snd-pcm-plugin         15664   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           4768   1 (autoclean) [snd-pcm-oss]
NVdriver              723584  17 (autoclean)
snd-seq-midi            3280   0 (unused)
snd-seq-midi-event      3440   0 [snd-seq-midi]
snd-seq                42176   0 [snd-seq-midi snd-seq-midi-event]
snd-card-ens1371        2176   2 (autoclean)
snd-ens1371            10288   0 (autoclean) [snd-card-ens1371]
snd-pcm                32544   0 (autoclean) [snd-pcm-oss snd-pcm-plugin 
snd-ens1371]
snd-timer               9088   0 (autoclean) [snd-seq snd-pcm]
snd-rawmidi            10464   0 (autoclean) [snd-seq-midi snd-ens1371]
snd-seq-device          4032   0 (autoclean) [snd-seq-midi snd-seq 
snd-rawmidi]
snd-ac97-codec         23840   0 (autoclean) [snd-ens1371]
snd-mixer              24432   0 (autoclean) [snd-mixer-oss snd-ens1371 
snd-ac97-codec]
snd                    35104   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss 
snd-seq-midi snd-seq-midi-event snd-seq snd-card-ens1371 snd-ens1371 snd-pcm 
snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd-mixer]
tulip                  37760   1 (autoclean)
hid                    11872   0 (unused)

======================
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffbffff : System RAM
  00100000-0026875e : Kernel code
  0026875f-002fadbf : Kernel data
0ffc0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
f0600000-f06fffff : PCI Bus #01
f0700000-f47fffff : PCI Bus #02
  f2000000-f3ffffff : nVidia Corporation Vanta [NV6]
f8000000-fbffffff : PCI device 8086:1130 (Intel Corporation)
fc900000-fc9fffff : PCI Bus #01
  fc9efc00-fc9efcff : Lite-On Communications Inc LNE100TX
    fc9efc00-fc9efcff : tulip
  fc9f0000-fc9fffff : PCI device 14f1:1036 (CONEXANT)
fca00000-feafffff : PCI Bus #02
  fd000000-fdffffff : nVidia Corporation Vanta [NV6]
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved





Ok, thanks for looking at this and good luck with your kernel development .

~Mike Farrell
