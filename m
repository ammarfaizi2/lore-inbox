Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbUCZIu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUCZIu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:50:28 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:13233 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263969AbUCZIuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:50:16 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Is irqbalance working?
Date: Fri, 26 Mar 2004 02:49:42 -0600
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403260249.42926.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
	vanilla 2.6.4 with kernel irqbalance enabled. Dual athlon MP 2000. I do not 
think that irqbalance is working correctly. Should most of the interrupts 
still be handled by cpu0? Is this a bug or am I misunderstanding how 
irqbalance works? Do other machines show about the same #'s with irqbalance 
enabled  or do I have devices that can't be load balanced nicely? More 
information available upon request.

cat /proc/interrupts
         CPU0       CPU1
  0:     802023        410    IO-APIC-edge  timer
  1:        994          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:      15692          1    IO-APIC-edge  i8042
 14:         86          1    IO-APIC-edge  ide0
 15:       2682          1    IO-APIC-edge  ide1
169:      24384          0   IO-APIC-level  sym53c8xx, eth0
177:          0          0   IO-APIC-level  eth1, sym53c8xx
185:       3605          1   IO-APIC-level  EMU10K1
193:          3          0   IO-APIC-level  ohci1394, ohci_hcd
NMI:          0          0
LOC:     802246     802264
ERR:          0
MIS:          0

cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2000+
stepping        : 1
cpu MHz         : 1667.572
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3284.99

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 1667.572
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3325.95

lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 
04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI 
Adapter (rev 01)
00:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI 
Adapter (rev 01)
00:09.0 Ethernet controller: National Semiconductor Corporation DP83820 
10/100/1000 Ethernet Controller
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05)
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 
8500 LE]
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 
07)
02:04.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
02:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 02)
02:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
02)
02:06.0 Multimedia audio controller: Creative Labs SB Audigy (rev 03)
02:06.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
03)
02:06.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port




-- 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
