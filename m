Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132618AbRDGJgw>; Sat, 7 Apr 2001 05:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132619AbRDGJgo>; Sat, 7 Apr 2001 05:36:44 -0400
Received: from graph.z-trading.fi ([195.255.230.122]:35539 "HELO
	graph.z-trading.fi") by vger.kernel.org with SMTP
	id <S132618AbRDGJgd>; Sat, 7 Apr 2001 05:36:33 -0400
Message-ID: <3ACEDF31.AD9C8806@z-trading.fi>
Date: Sat, 07 Apr 2001 12:34:41 +0300
From: Petri =?iso-8859-1?Q?J=E4rvinen?= <petri.jarvinen@z-trading.fi>
Organization: Z-Trading Oy
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3s1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: reporting a kernel bug
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
machine freezes

[2.] Full description of the problem/report:
machine freezes when daily.cron runs itself

[3.] Keywords (i.e., modules, networking, kernel):
kernel

[4.] Kernel version (from /proc/version):
Linux version 2.4.3s1 (root@setri) (gcc version 2.95.2.1 19991024
(release)) #1 Sun Apr 1 00:22:43 EEST 2001

[5.] Output of Oops.. message (ifapplicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
Everything from "messages" -log file:

Apr  7 04:02:00 setri anacron[15066]: Updated timestamp for job
`cron.daily' to 2001-04-07
Apr  7 04:03:02 setri kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000028
Apr  7 04:03:02 setri kernel:  printing eip:
Apr  7 04:03:02 setri kernel: c0130374
Apr  7 04:03:02 setri kernel: *pde = 00000000
Apr  7 04:03:02 setri kernel: Oops: 0000
Apr  7 04:03:02 setri kernel: CPU:    0
Apr  7 04:03:02 setri kernel: EIP:    0010:[try_to_free_buffers+52/364]
Apr  7 04:03:02 setri kernel: EFLAGS: 00010203
Apr  7 04:03:02 setri kernel: eax: 00000000   ebx: 00000000   ecx:
00000000   edx: 00000000
Apr  7 04:03:02 setri kernel: esi: 00000000   edi: c3a446e0   ebp:
c11152f0   esp: c12e5f8c
Apr  7 04:03:02 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:02 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:02 setri kernel: Stack: c11152f0 c111530c 00000000 000014fe
00000000 00000000 c0127007 c11152f0
Apr  7 04:03:02 setri kernel:        00000000 c12e4000 00000041 c12e423a
c12fbfc4 00000000 00000004 00000000
Apr  7 04:03:02 setri kernel:        000009b2 00000000 c0130733 00000007
00000000 00010f00 c12fbf88 c12fbfc4
Apr  7 04:03:02 setri kernel: Call Trace: [page_launder+855/2132]
[bdflush+131/200] [kernel_thread+40/56]
Apr  7 04:03:02 setri kernel:
Apr  7 04:03:02 setri kernel: Code: 8b 76 28 8b 50 18 8b 40 10 83 e2 46
09 d0 0f 85 e8 00 00 00
Apr  7 04:03:06 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:06 setri kernel: invalid operand: 0000
Apr  7 04:03:06 setri kernel: CPU:    0
Apr  7 04:03:06 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:06 setri kernel: EFLAGS: 00010282
Apr  7 04:03:06 setri kernel: eax: 0000001a   ebx: c02112c0   ecx:
c12e4000   edx: 00000000
Apr  7 04:03:06 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e5e84
Apr  7 04:03:06 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:06 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:06 setri kernel: Stack: c01ddce5 c01ddd7c 000001ca 00000000
00000000 00000028 c010724e 0000000b
Apr  7 04:03:06 setri kernel:        c0110247 c01dc9de c12e5f58 00000000
c12e4000 00000000 c010ff24 c11152f0
Apr  7 04:03:06 setri kernel:        c12c1f80 00000000 00000001 c3394180
00030001 c027d8a0 00000286 c12fd2a0
Apr  7 04:03:07 setri kernel: Call Trace: [die+66/68]
[do_page_fault+803/1036] [do_page_fault+0/1036]
[cursor_timer_handler+34/40] [timer_bh+546/604] [tqueue_bh+22/28]
[bh_action+27/96]
Apr  7 04:03:07 setri kernel:        [tasklet_hi_action+60/96]
[error_code+52/60] [try_to_free_buffers+52/364] [page_launder+855/2132]
[bdflush+131/200] [kernel_thread+40/56]
Apr  7 04:03:07 setri kernel:
Apr  7 04:03:07 setri kernel: Code: 0f 0b 83 c4 0c e9 2b fe ff ff 8b 4c
24 04 85 c9 74 08 ff 01
Apr  7 04:03:07 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:07 setri kernel: invalid operand: 0000
Apr  7 04:03:07 setri kernel: CPU:    0
Apr  7 04:03:07 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:07 setri kernel: EFLAGS: 00010286
Apr  7 04:03:07 setri kernel: eax: 0000001a   ebx: 00000000   ecx:
00000001   edx: c0213308
Apr  7 04:03:07 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e5d8c
Apr  7 04:03:07 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:07 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:07 setri kernel: Stack: c01ddce5 c01ddd7c 000001ca c12e5e50
00000000 c0107464 c010724e 0000000b
Apr  7 04:03:07 setri kernel:        c01074e3 c01d809a c12e5e50 00000000
c12e4000 00000000 00000004 00000000
Apr  7 04:03:07 setri kernel:        00030002 c011561e c12fa000 00000000
c12e5df0 c12fa000 c12e4000 c12fa000
Apr  7 04:03:07 setri kernel: Call Trace: [do_invalid_op+0/136]
[die+66/68] [do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560]
Apr  7 04:03:07 setri kernel:        [die+66/68]
[do_page_fault+803/1036] [do_page_fault+0/1036]
[cursor_timer_handler+34/40] [timer_bh+546/604] [tqueue_bh+22/28]
[bh_action+27/96] [tasklet_hi_action+60/96]
Apr  7 04:03:07 setri kernel:        [error_code+52/60]
[try_to_free_buffers+52/364] [page_launder+855/2132] [bdflush+131/200]
[kernel_thread+40/56]
Apr  7 04:03:07 setri kernel:
Apr  7 04:03:07 setri kernel: Code: 0f 0b 83 c4 0c e9 2b fe ff ff 8b 4c
24 04 85 c9 74 08 ff 01
Apr  7 04:03:07 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:07 setri kernel: invalid operand: 0000
Apr  7 04:03:07 setri kernel: CPU:    0
Apr  7 04:03:07 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:07 setri kernel: EFLAGS: 00010286
Apr  7 04:03:07 setri kernel: eax: 0000001a   ebx: 00000000   ecx:
00000001   edx: c0213308
Apr  7 04:03:07 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e5c94
Apr  7 04:03:07 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:07 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:07 setri kernel: Stack: c01ddce5 c01ddd7c 000001ca c12e5d58
00000000 c0107464 c010724e 0000000b
Apr  7 04:03:07 setri kernel:        c01074e3 c01d809a c12e5d58 00000000
c12e4000 00000000 00000004 00000000
Apr  7 04:03:07 setri kernel:        00030002 c011561e c12fa000 00000000
c12e5cf8 c12fa000 c12e4000 c12fa000
Apr  7 04:03:07 setri kernel: Call Trace: [do_invalid_op+0/136]
[die+66/68] [do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560]
Apr  7 04:03:07 setri kernel:        [do_invalid_op+0/136] [die+66/68]
[do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560] [die+66/68]
Apr  7 04:03:07 setri kernel:        [do_page_fault+803/1036]
[do_page_fault+0/1036] [cursor_timer_handler+34/40] [timer_bh+546/604]
[tqueue_bh+22/28] [bh_action+27/96] [tasklet_hi_action+60/96]
[error_code+52/60]
Apr  7 04:03:07 setri kernel:        [try_to_free_buffers+52/364]
[page_launder+855/2132] [bdflush+131/200] [kernel_thread+40/56]
Apr  7 04:03:07 setri kernel:
Apr  7 04:03:07 setri kernel: Code: 0f 0b 83 c4 0c e9 2b fe ff ff 8b 4c
24 04 85 c9 74 08 ff 01
Apr  7 04:03:07 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:07 setri kernel: invalid operand: 0000
Apr  7 04:03:07 setri kernel: CPU:    0
Apr  7 04:03:07 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:07 setri kernel: EFLAGS: 00010282
Apr  7 04:03:07 setri kernel: eax: 0000001a   ebx: 00000000   ecx:
00000001   edx: c0213308
Apr  7 04:03:07 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e5b9c
Apr  7 04:03:07 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:07 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:07 setri kernel: Stack: c01ddce5 c01ddd7c 000001ca c12e5c60
00000000 c0107464 c010724e 0000000b
Apr  7 04:03:07 setri kernel:        c01074e3 c01d809a c12e5c60 00000000
c12e4000 00000000 00000004 00000000
Apr  7 04:03:07 setri kernel:        00030002 c011561e c12fa000 00000000
c12e5c00 c12fa000 c12e4000 c12fa000
Apr  7 04:03:07 setri kernel: Call Trace: [do_invalid_op+0/136]
[die+66/68] [do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560]
Apr  7 04:03:07 setri kernel:        [do_invalid_op+0/136] [die+66/68]
[do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560] [do_invalid_op+0/136]
Apr  7 04:03:07 setri kernel:        [die+66/68] [do_invalid_op+127/136]
[do_exit+550/560] [vsprintf+830/876] [error_code+52/60]
[do_exit+550/560] [die+66/68] [do_page_fault+803/1036]
Apr  7 04:03:07 setri kernel:        [do_page_fault+0/1036]
[cursor_timer_handler+34/40] [timer_bh+546/604] [tqueue_bh+22/28]
[bh_action+27/96] [tasklet_hi_action+60/96] [error_code+52/60]
[try_to_free_buffers+52/364]
Apr  7 04:03:07 setri kernel:        [page_launder+855/2132]
[bdflush+131/200] [kernel_thread+40/56]
Apr  7 04:03:08 setri kernel:
Apr  7 04:03:08 setri kernel: Code: 0f 0b 83 c4 0c e9 2b fe ff ff 8b 4c
24 04 85 c9 74 08 ff 01
Apr  7 04:03:08 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:08 setri kernel: invalid operand: 0000
Apr  7 04:03:08 setri kernel: CPU:    0
Apr  7 04:03:08 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:08 setri kernel: EFLAGS: 00010286
Apr  7 04:03:08 setri kernel: eax: 0000001a   ebx: 00000000   ecx:
00000001   edx: c0213308
Apr  7 04:03:08 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e5aa4
Apr  7 04:03:08 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:08 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:08 setri kernel: Stack: c01ddce5 c01ddd7c 000001ca c12e5b68
00000000 c0107464 c010724e 0000000b
Apr  7 04:03:08 setri kernel:        c01074e3 c01d809a c12e5b68 00000000
c12e4000 00000000 00000004 00000000
Apr  7 04:03:08 setri kernel:        00030002 c011561e c12fa000 00000000
c12e5b08 c12fa000 c12e4000 c12fa000
Apr  7 04:03:08 setri kernel: Call Trace: [do_invalid_op+0/136]
[die+66/68] [do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560]
Apr  7 04:03:08 setri kernel:        [do_invalid_op+0/136] [die+66/68]
[do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560] [do_invalid_op+0/136]
Apr  7 04:03:08 setri kernel:        [die+66/68] [do_invalid_op+127/136]
[do_exit+550/560] [vsprintf+830/876] [error_code+52/60]
[do_exit+550/560] [do_invalid_op+0/136] [die+66/68]
Apr  7 04:03:08 setri kernel:        [do_invalid_op+127/136]
[do_exit+550/560] [vsprintf+830/876] [error_code+52/60]
[do_exit+550/560] [die+66/68] [do_page_fault+803/1036]
[do_page_fault+0/1036]
Apr  7 04:03:08 setri kernel:        [cursor_timer_handler+34/40]
[timer_bh+546/604] [tqueue_bh+22/28] [bh_action+27/96]
[tasklet_hi_action+60/96] [error_code+52/60]
[try_to_free_buffers+52/364] [page_launder+855/2132]
Apr  7 04:03:08 setri kernel:        [bdflush+131/200]
[kernel_thread+40/56]
Apr  7 04:03:08 setri kernel:
Apr  7 04:03:08 setri kernel: Code: 0f 0b 83 c4 0c e9 2b fe ff ff 8b 4c
24 04 85 c9 74 08 ff 01
Apr  7 04:03:08 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:08 setri kernel: invalid operand: 0000
Apr  7 04:03:08 setri kernel: CPU:    0
Apr  7 04:03:08 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:08 setri kernel: EFLAGS: 00010282
Apr  7 04:03:08 setri kernel: eax: 0000001a   ebx: 00000000   ecx:
00000001   edx: c0213308
Apr  7 04:03:08 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e59ac
Apr  7 04:03:08 setri kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 04:03:08 setri kernel: Process bdflush (pid: 6,
stackpage=c12e5000)
Apr  7 04:03:08 setri kernel: Stack: c01ddce5 c01ddd7c 000001ca c12e5a70
00000000 c0107464 c010724e 0000000b
Apr  7 04:03:08 setri kernel:        c01074e3 c01d809a c12e5a70 00000000
c12e4000 00000000 00000004 00000000
Apr  7 04:03:08 setri kernel:        00030002 c011561e c12fa000 00000000
c12e5a10 c12fa000 c12e4000 c12fa000
Apr  7 04:03:08 setri kernel: Call Trace: [do_invalid_op+0/136]
[die+66/68] [do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560]
Apr  7 04:03:08 setri kernel:        [do_invalid_op+0/136] [die+66/68]
[do_invalid_op+127/136] [do_exit+550/560] [vsprintf+830/876]
[error_code+52/60] [do_exit+550/560] [do_invalid_op+0/136]
Apr  7 04:03:08 setri kernel:        [die+66/68] [do_invalid_op+127/136]
[do_exit+550/560] [vsprintf+830/876] [error_code+52/60]
[do_exit+550/560] [do_invalid_op+0/136] [die+66/68]
Apr  7 04:03:08 setri kernel:        [do_invalid_op+127/136]
[do_exit+550/560] [vsprintf+830/876] [error_code+52/60]
[do_exit+550/560] [do_invalid_op+0/136] [die+66/68]
[do_invalid_op+127/136]
Apr  7 04:03:08 setri kernel:        [do_exit+550/560]
[vsprintf+830/876] [error_code+52/60] [do_exit+550/560] [die+66/68]
[do_page_fault+803/1036] [do_page_fault+0/1036]
[cursor_timer_handler+34/40]
Apr  7 04:03:08 setri kernel:        [timer_bh+546/604]
[tqueue_bh+22/28] [bh_action+27/96] [tasklet_hi_action+60/96]
[error_code+52/60] [try_to_free_buffers+52/364] [page_launder+855/2132]
[bdflush+131/200]
Apr  7 04:03:08 setri kernel:        [kernel_thread+40/56]
Apr  7 04:03:08 setri kernel:
Apr  7 04:03:08 setri kernel: Code: 0f 0b 83 c4 0c e9 2b fe ff ff 8b 4c
24 04 85 c9 74 08 ff 01
Apr  7 04:03:09 setri kernel: kernel BUG at exit.c:458!
Apr  7 04:03:09 setri kernel: invalid operand: 0000
Apr  7 04:03:09 setri kernel: CPU:    0
Apr  7 04:03:09 setri kernel: EIP:    0010:[do_exit+550/560]
Apr  7 04:03:09 setri kernel: EFLAGS: 00010282
Apr  7 04:03:09 setri kernel: eax: 0000001a   ebx: 00000000   ecx:
c12e4000   edx: 00000000
Apr  7 04:03:09 setri kernel: esi: c12e4000   edi: 0000000b   ebp:
c12e4000   esp: c12e58b4
Apr  7 04:03:09 setri kernel: ds: 0018   es: 0018   ss: 0018
[6.] A small shell script or example program which triggers the
     problem (if possible)
-
[7.] Environment
-
[7.1.] Software (add the output of the ver_linux script here)

Gnu C                  2.95.2.1
Gnu make               3.79.1
binutils               2.9.5.0.22
util-linux             2.10f
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.8
PPP                    2.3.11
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ipchains 3c509 via-rhine

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 400.947
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov
pat pse36 mmx fxsr
bogomips        : 799.53

[7.3.] Module information (from /proc/modules):
ipchains               30752   0 (unused)
3c509                   5936   1 (autoclean)
via-rhine               9664   1 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
d000-dfff : PCI Bus #01
  d000-d0ff : 3Dfx Interactive, Inc. Voodoo 3
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e800-e87f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  e800-e87f : via-rhine

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001d720d : Kernel code
  001d720e-00221e1b : Kernel data
e0000000-e3ffffff : PCI Bus #01
  e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
e6000000-e6ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x]
e8000000-e800007f : VIA Technologies, Inc. VT86C100A [Rhine 10/100]
  e8000000-e800007f : via-rhine
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-

<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0 set
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-

<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e0000000-e3ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo PRO]
(rev
06)
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev

06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at e000 [size=16]

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-

<TAbort- <MAbort- >SERR- <PERR-

00:14.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine
10/100] (rev 06)
        Subsystem: D-Link System Inc DFE-530TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 118 min, 152 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=128]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at e7000000 [disabled] [size=64K]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
<MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e0000000 (32-bit, non-prefetchable)
[size=32M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at d000 [size=256]
        Expansion ROM at e2000000 [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI+ D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
no scsi card

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
Programs and scripts in cron.daily:

0anacron
logrotate
makewhatis.cron
slocate.cron
tetex.cron
tmpwatch

Thank you

-- cut

Best regards
Petri Järvinen

