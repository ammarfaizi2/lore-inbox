Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133025AbRDLAgF>; Wed, 11 Apr 2001 20:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133031AbRDLAfz>; Wed, 11 Apr 2001 20:35:55 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:58421 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S133025AbRDLAfq>; Wed, 11 Apr 2001 20:35:46 -0400
Date: Wed, 11 Apr 2001 20:35:28 -0400 (EDT)
From: Jon Eisenstein <jeisen@mindspring.com>
Reply-To: jeisen@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: Problem: Random paging request errors
Message-ID: <Pine.LNX.4.21.0104112020050.529-100000@dominia.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) Random paging request errors

(2) Every so often, I get a non-fatal error on my screen about a kernel
paging request error. I can't identify when it happens, or why, but I
thought people on this list might be able to interpret the message. If
more information from the moment of error is needed, I'm sure it'll happen
many more times after this message is sent.

Unable to handle kernel paging request at virtual address bbb49db8
 printing eip:
c01352ba
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01352ba>]
EFLAGS: 00010286
eax: c2dedec0   ebx: bbb49d8e   ecx: c18a1f84   edx: 00000001
esi: fffffffe   edi: 40191519   ebp: 00000001   esp: c18a1f4c
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 2174, stackpage=c18a1000)
Stack: 00000000 080b580c 40191519 c0d96000 c0d71be0 00000000 00000004
c2dedec0
       c012a09f c0d96000 00000001 000001b6 c18a1f84 00000003 c2ca5ec0
c11c0720
       40191519 c0d96000 00000000 00000001 00000001 c012a3ac c0d96000
00000000
Call Trace: [<c012a09f>] [<c012a3ac>] [<c0106da3>]

Code: 66 8b 43 2a be d8 ff ff ff 25 00 f0 ff ff 66 3d 00 a0 0f 84


(3) paging virtual

(4) Linux version 2.4.3 (root@dominia.dyn.dhs.org) (gcc version 2.95.3
20010315 (Debian release)) #2 Tue Apr 10 18:19:30 EDT 2001

(5) I'm not sure how to do this. In any case, the oops was 0000, which I
think means I'm not supposed to do a trace.

(6) None known

(7.1) 
 
Linux dominia.dyn.dhs.org 2.4.3 #2 Tue Apr 10 18:19:30 EDT 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.1
util-linux             2.11b
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         parport_pc lp parport isa-pnp

(7.2) 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 5
cpu MHz         : 120.274
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 240.02
 
(7.3)
parport_pc             10448   1 (autoclean)
lp                      5392   0 (autoclean)
parport                15072   1 (autoclean) [parport_pc lp]
isa-pnp                28624   0 (unused)

(7.4)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
3000-300f : Intel Corporation 82371FB PIIX IDE [Triton I]
  3000-3007 : ide0
  3008-300f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-02ffffff : System RAM
  00100000-001b59a1 : Kernel code
  001b59a2-001f22ff : Kernel data
f0000000-f01fffff : Trident Microsystems TGUI 9440
f0200000-f020ffff : Trident Microsystems TGUI 9440
ffff0000-ffffffff : reserved

(7.5) I don't have the lspci command.

(7.6) No SCSI on system

