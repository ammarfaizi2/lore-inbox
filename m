Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbRLSQXL>; Wed, 19 Dec 2001 11:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285377AbRLSQWy>; Wed, 19 Dec 2001 11:22:54 -0500
Received: from f187.law15.hotmail.com ([64.4.23.187]:28941 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S285369AbRLSQWl>;
	Wed, 19 Dec 2001 11:22:41 -0500
X-Originating-IP: [24.200.0.247]
From: "Andre Couture" <nomade1999@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: bug/problem  on 2.4.16 ??? 
Date: Wed, 19 Dec 2001 17:22:35 +0100
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_5ba4_3ad3_5dbf"
Message-ID: <F187Z1i6bdVJWrGW6Ex00007bcf@hotmail.com>
X-OriginalArrivalTime: 19 Dec 2001 16:22:35.0314 (UTC) FILETIME=[5E20C120:01C188A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_5ba4_3ad3_5dbf
Content-Type: text/plain; format=flowed

kernel 2.4.16 SMP PIII Katmai

the system is installed from mandrake 8.1 CD's.

then I've installed and recompile a new kernel.

i've attached the .config (just in case)

see below for more info

Any help would be appreciated, in the mean while i will recompile the kswapd 
and ipopd3

Thanks
Andre



Here is the ERROR reported;
...
kernel BUG at page_alloc.c:76!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01391f5>]    Not tainted
EFLAGS: 00010286
eax: 0000001f   ebx: c153a7d0   ecx: c0263624   edx: 00004646
esi: c153a7d0   edi: d7914ec8   ebp: 00000000   esp: d7ef3f08
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=d7ef3000)
Stack: c023c695 0000004c c1044010 c0264ac8 00000203 000001d0 c153a7d0 
d7914ec8
       c153a7d0 00000012 000026b0 c01387c7 d7ed08cc 00000100 000001d0 
c0264aac
       00000000 00000000 00000000 00000000 00000020 000001d0 00000006 
00000020
Call Trace: [<c01387c7>] [<c0138ca2>] [<c0138d0c>] [<c0138db1>] [<c0138e26>]
   [<c0138f61>] [<c0138ec0>] [<c0105000>] [<c0105756>] [<c0138ec0>]

Code: 0f 0b 59 5e 8b 15 6c 2a 2e c0 89 d8 29 d0 69 c0 f1 f0 f0 f0
kernel BUG at page_alloc.c:76!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01391f5>]    Not tainted
EFLAGS: 00010282
eax: 0000001f   ebx: c153a7d0   ecx: c0263624   edx: 0000497e
esi: c153a7d0   edi: d7914ec8   ebp: 00000000   esp: cb143ed4
ds: 0018   es: 0018   ss: 0018
Process ipop3d (pid: 32071, stackpage=cb143000)
Stack: c023c695 0000004c c6c15254 00000020 c012fd45 0000001f 00005a3c 
00001000
       c153a7d0 d7914ec8 0000475f c013006c cb143f5c c153a7d0 00000000 
00001000
       00001000 00000001 00000000 00000000 d7914e0c 00000000 d7ed1d9c 
c02fd6e0
Call Trace: [<c012fd45>] [<c013006c>] [<c01beb10>] [<c01305fc>] [<c0130520>]
   [<c0141166>] [<c0140cb0>] [<c0140f1e>] [<c010758b>]

Code: 0f 0b 59 5e 8b 15 6c 2a 2e c0 89 d8 29 d0 69 c0 f1 f0 f0 f0
...



cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.257
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1101.00

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 551.257
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1101.00

cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=136.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      IRQ 19.
      Master Capable.  Latency=32.
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device  11, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe10000ff].
  Bus  0, device  12, function  0:
    SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] 
(rev 8).
      IRQ 16.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0xa800 [0xa803].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0800fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
(rev 92).
      Master Capable.  Latency=64.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe2ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe1800000 [0xe1800fff].



_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

------=_NextPart_000_5ba4_3ad3_5dbf
Content-Type: application/octet-stream; name="dot-config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dot-config.gz"

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
8NZX7VfqWpov/79CjJu/JTfWSP4HQxZymNxkAAA=


------=_NextPart_000_5ba4_3ad3_5dbf--
