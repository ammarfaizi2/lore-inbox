Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129277AbQKBXYe>; Thu, 2 Nov 2000 18:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129963AbQKBXYZ>; Thu, 2 Nov 2000 18:24:25 -0500
Received: from smtp-2u-1.atlantic.net ([209.208.25.2]:63753 "EHLO
	smtp-2u-1.atlantic.net") by vger.kernel.org with ESMTP
	id <S129277AbQKBXYP>; Thu, 2 Nov 2000 18:24:15 -0500
Date: Thu, 2 Nov 2000 19:26:23 -0500 (EST)
From: Burton Windle <burton@fint.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test10 Oops
Message-ID: <Pine.LNX.4.21.0011021917020.15757-100000@fint.staticky.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
Kernel 2.4.0-test10 Multiple oops

[2.] Full description of the problem/report:
When running dselect from Debian Woody, after all the packages were
downloaded, it began to install them, and then oopsed twice. The system
seemed normal after words, but would not compile ksymoops, so I had to
reboot to compile/run it.

[3.] Keywords (i.e., modules, networking, kernel):
2.4.0-test10 oops

[4.] Kernel version (from /proc/version):
Linux version 2.4.0-test10 (root@toy) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #3 Wed Nov 1 23:29:21 EST 2000


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.3.4 on i586 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map-2.4.0-test10 (specified)

ac97_codec: AC97 Audio codec, id: 0x4352:0x5903 (Cirrus Logic CS4297)
Unable to handle kernel NULL pointer dereference at virtual address 00000023
c0113ef0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0113ef0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010207
eax: ffffa4fc   ebx: 00000014   ecx: 00000003   edx: e325b51b
esi: c674a000   edi: c674a000   ebp: c674bfbc   esp: c674bf98
ds: 0018   es: 0018   ss: 0018
Process distributed-net (pid: 152, stackpage=c674b000)
Stack: c674a000 0ba659a4 080ea448 c674a000 c010b9d2 c6f493a0 00000000 00000000 
       c024b540 080ea998 c010a705 080ea9dc 080ea9e0 00000009 0ba659a4 080ea448 
       080ea998 00010000 0000002b 0000002b ffffff00 08070c7b 00000023 00000282 
Call Trace: [<c010b9d2>] [<c010a705>] 
Code: 8b 51 20 c1 fa 01 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 

>>EIP; c0113ef0 <schedule+2ac/3f4>   <=====
Trace; c010b9d2 <do_IRQ+a2/b0>
Trace; c010a705 <reschedule+5/10>
Code;  c0113ef0 <schedule+2ac/3f4>
00000000 <_EIP>:
Code;  c0113ef0 <schedule+2ac/3f4>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113ef3 <schedule+2af/3f4>
   3:   c1 fa 01                  sar    $0x1,%edx
Code;  c0113ef6 <schedule+2b2/3f4>
   6:   89 d8                     mov    %ebx,%eax
Code;  c0113ef8 <schedule+2b4/3f4>
   8:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113efb <schedule+2b7/3f4>
   b:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113efe <schedule+2ba/3f4>
   e:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113f02 <schedule+2be/3f4>
  12:   89 51 00                  mov    %edx,0x0(%ecx)

Unable to handle kernel NULL pointer dereference at virtual address 00000023
c0113ef0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0113ef0>]
EFLAGS: 00010207
eax: ffffa4fc   ebx: 00000014   ecx: 00000003   edx: f1927f8a
esi: c2cec000   edi: c2cec000   ebp: c2cedfbc   esp: c2cedf98
ds: 0018   es: 0018   ss: 0018
Process dpkg (pid: 396, stackpage=c2ced000)
Stack: c2cec000 081cd2c0 bffff848 c2cec000 c010b9d2 c6f493a0 00000000 00000000 
       c024b540 bffff794 c010a705 401201e8 081cd279 00000000 081cd2c0 bffff848 
       bffff794 081cd200 0000002b 0000002b ffffff00 40087fc7 00000023 00000202 
Call Trace: [<c010b9d2>] [<c010a705>] 
Code: 8b 51 20 c1 fa 01 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 

>>EIP; c0113ef0 <schedule+2ac/3f4>   <=====
Trace; c010b9d2 <do_IRQ+a2/b0>
Trace; c010a705 <reschedule+5/10>
Code;  c0113ef0 <schedule+2ac/3f4>
00000000 <_EIP>:
Code;  c0113ef0 <schedule+2ac/3f4>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113ef3 <schedule+2af/3f4>
   3:   c1 fa 01                  sar    $0x1,%edx
Code;  c0113ef6 <schedule+2b2/3f4>
   6:   89 d8                     mov    %ebx,%eax
Code;  c0113ef8 <schedule+2b4/3f4>
   8:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113efb <schedule+2b7/3f4>
   b:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113efe <schedule+2ba/3f4>
   e:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113f02 <schedule+2be/3f4>
  12:   89 51 00                  mov    %edx,0x0(%ecx)


[6.] A small shell script or example program which triggers the
     problem (if possible)
dselect ;)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux toy 2.4.0-test10 #3 Wed Nov 1 23:29:21 EST 2000 i586 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.91
Linux C Library        2.1.95
Dynamic linker         ldd (GNU libc) 2.1.95
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i
Modules Loaded         es1371 ac97_codec ne 8390 tdfx

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 400.000896
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
bogomips        : 799.54

[7.3.] Module information (from /proc/modules):
es1371                 24144   0
ac97_codec              7440   0 [es1371]
ne                      7072   1
8390                    6128   0 [ne]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
0280-029f : NE2000
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5c20-5c3f : PCI device 10b9:7101
d000-d00f : PCI device 10b9:5229
d400-d4ff : PCI device 121a:0005
d800-d83f : PCI device 1274:1371
  d800-d83f : es1371

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-06ffffff : System RAM
  00100000-00225427 : Kernel code
  00225428-00237d03 : Kernel data
dc000000-ddffffff : PCI device 121a:0005
e0000000-e3ffffff : PCI device 10b9:1541
e6000000-e7ffffff : PCI device 121a:0005
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:0b.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)


[7.6.] SCSI information (from /proc/scsi/scsi)
n/a

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
I was on tty1 when the oops happened. I was running the beta Debian XF4 at
the time, and most likely had the tdfx module loaded.


Thank you

-- 
Burton Windle				burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux/init/main.c:1384

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
