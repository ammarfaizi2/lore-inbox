Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTFOSG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 14:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFOSG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 14:06:59 -0400
Received: from franka.aracnet.com ([216.99.193.44]:23225 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262568AbTFOSGf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 14:06:35 -0400
Date: Sun, 15 Jun 2003 11:20:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 810] New: Kernel BUG at mm/slab.c:981 
Message-ID: <469250000.1055701220@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Kernel BUG at mm/slab.c:981
    Kernel Version: 2.5.70-71
            Status: NEW
          Severity: blocking
             Owner: akpm@digeo.com
         Submitter: s_aldinger@hotmail.com


Since .69 I've been unable to boot. no config changes. I had to write this out and then 
type so if something looks really off it might be a typo, give a shout and I'll check it.  
 
Kernel BUG at mm/slab.c:981 
invalid operand:0000 [#1] 
cpu: 0 
EIP: 0060:[<c0136eca>]		Not tainted 
Eflags: 00010202 
eax: 000001a8		ebx:c053a5c0		ecx:c04ae990		edx:00001797		
esi:00000000 		edi:00000000		esp:c153ff6c 
ds:007b		es:007b		ss:0068 
Process swapper (pid: 1, threadinfo=c153e000 task=c151d880) 
Stack:	ffffe869	00000029 	0000000292	0000176b	00001797	c0546829	
00000246	c011b51e	c053a5c0 
00000000	00000000	00000000	c01d5046	c04464b8	000001a8	00000000	
00000001 
c01d4ff2 		00000000 	c0527e9c	c0451f20		c053a5c0	c051cbbd	
00000000 
Call Trace	[<c011b51e>]	[<c01d5046>]	[<c01d4ff2>]	[<c0527e9c>]	
[<c051c6bd>]	[<c0128542>]	[<c0105051>]	[<c010502c>] 
[<c010895d>] 
code: 0f 0b d5 03 60 28 44 c0 c7 44 24 04 d0 00 00 00 c7 04 24 e0 
<0> Kernel panic: Attempted to kill init! 
 
2.5.69 #1 Thu May 8 22:26:56 EDT 2003 i686 Intel(R) Pentium(R) 4 Mobile CPU 
2.00GHz GenuineIntel GNU/Linux 
 
Gnu C                  3.2.3 
Gnu make               3.80 
util-linux             2.11z 
mount                  2.11z 
e2fsprogs              1.33 
Linux C Library        2.3.2 
Dynamic linker (ldd)   2.3.2 
Procps                 3.1.9 
Net-tools              1.60 
Kbd                    1.06 
Sh-utils               2.0.15 
Modules Loaded         nvidia 
 
processor       : 0 
vendor_id       : GenuineIntel 
cpu family      : 15 
model           : 2 
model name      : Intel(R) Pentium(R) 4 Mobile CPU 2.00GHz 
stepping        : 4 
cpu MHz         : 1993.851 
cache size      : 512 KB 
fdiv_bug        : no 
hlt_bug         : no 
f00f_bug        : no 
coma_bug        : no 
fpu             : yes 
fpu_exception   : yes 
cpuid level     : 2 
wp              : yes 
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
clflush dts acpi mmx fxsr sse sse2 ss ht tm 
bogomips        : 3940.35 
 
/proc/ioports 
0000-001f : dma1 
0020-003f : pic1 
0040-005f : timer 
0060-006f : keyboard 
0070-0077 : rtc 
0080-008f : dma page reg 
00a0-00bf : pic2 
00c0-00df : dma2 
00f0-00ff : fpu 
01f0-01f7 : ide0 
03c0-03df : vga+ 
03f6-03f6 : ide0 
0cf8-0cff : PCI conf1 
1000-10ff : Intel Corp. 82801CA/CAM AC'97 Au 
  1000-10ff : Intel 82801CA-ICH3 - AC'97 
1400-143f : Intel Corp. 82801CA/CAM AC'97 Au 
  1400-143f : Intel 82801CA-ICH3 - Controller 
1480-14ff : Intel Corp. 82801CA/CAM AC'97 Mo 
1800-18ff : Intel Corp. 82801CA/CAM AC'97 Mo 
1c00-1cff : PCI CardBus #03 
2000-20ff : PCI CardBus #03 
2400-24ff : PCI CardBus #07 
2800-28ff : PCI CardBus #07 
cfa0-cfaf : Intel Corp. 82801CAM IDE U100 
  cfa0-cfa7 : ide0 
  cfa8-cfaf : ide1 
df40-df7f : Intel Corp. 82801CAM (ICH3) PRO/ 
  df40-df7f : e100 
 
  /proc/iomem 
00000000-0009fbff : System RAM 
0009fc00-0009ffff : reserved 
000a0000-000bffff : Video RAM area 
000e0000-000effff : Extension ROM 
000f0000-000fffff : System ROM 
00100000-1ffcbfff : System RAM 
  00100000-0044c0d8 : Kernel code 
  0044c0d9-0053d283 : Kernel data 
1ffcc000-1ffcffff : reserved 
1ffd0000-1ffdffff : ACPI Tables 
1ffe0000-1fffffff : reserved 
20000000-200003ff : Intel Corp. 82801CAM IDE U100 
20000400-200004ff : NEC Corporation USB 2.0 
  20000400-200004ff : ehci-hcd 
20000600-200007ff : Toshiba America Info SD TypA Controller 
20000800-20000fff : Texas Instruments TSB43AB22/A IEEE-139 
  20000800-20000fff : ohci1394 
20001000-20001fff : Texas Instruments PCI1410 PC card Card 
20002000-20002fff : Toshiba America Info ToPIC95 PCI to Cardb 
20004000-20007fff : Texas Instruments TSB43AB22/A IEEE-139 
20400000-207fffff : PCI CardBus #03 
20800000-20bfffff : PCI CardBus #03 
20c00000-20ffffff : PCI CardBus #07 
21000000-213fffff : PCI CardBus #07 
d7f00000-dfffffff : PCI Bus #01 
  d7f80000-d7ffffff : PCI device 10de:0177 (nVidia Corporation) 
  d8000000-dfffffff : PCI device 10de:0177 (nVidia Corporation) 
e0000000-efffffff : Intel Corp. 82845 845 (Brookdale 
fcefd000-fcefdfff : Intel Corp. 82801CAM (ICH3) PRO/ 
  fcefd000-fcefdfff : e100 
fcefe000-fcefefff : NEC Corporation USB (#2) 
fceff000-fcefffff : NEC Corporation USB 
fd000000-fdffffff : PCI Bus #01 
  fd000000-fdffffff : PCI device 10de:0177 (nVidia Corporation) 
feda0000-fedbffff : reserved 
ffb80000-ffbfffff : reserved 
fff80000-ffffffff : reserved

