Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTFDUy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTFDUy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:54:56 -0400
Received: from mail6.home.nl ([213.51.128.22]:31181 "EHLO mail6-sh.home.nl")
	by vger.kernel.org with ESMTP id S264151AbTFDUyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:54:46 -0400
Date: Wed, 4 Jun 2003 23:08:28 +0200
From: Robert Winder <r.winder@home.nl>
X-Mailer: The Bat! (v1.62i) Business
Reply-To: Robert Winder <r.winder@home.nl>
X-Priority: 3 (Normal)
Message-ID: <620183472.20030604230828@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Oops: with via82cxxx_audio  2.4.21-rc7-ac1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More uniproccesor glitches with AC97. Loading via82cxxx_audio module on EPIA-M9000
(VT8235) results in oops.

Linux version 2.4.21-rc7-ac1 (root@mediabox) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #2 Wed Jun 4 21:32:26 CEST 2003

Jun  4 21:36:33 mediabox kernel: Via 686a/8233/8235 audio driver 1.9.1-ac2
Jun  4 21:36:33 mediabox kernel: via82cxxx: Six channel audio available
Jun  4 21:36:33 mediabox kernel: PCI: Setting latency timer of device 00:11.5 to 64
Jun  4 21:36:33 mediabox kernel: spurious 8259A interrupt: IRQ4.
Jun  4 21:36:33 mediabox kernel: Unable to handle kernel paging request at virtual address 9a1c3543
Jun  4 21:36:33 mediabox kernel:  printing eip:
Jun  4 21:36:33 mediabox kernel: cd411829
Jun  4 21:36:33 mediabox kernel: *pde = 00000000
Jun  4 21:36:33 mediabox kernel: Oops: 0002
Jun  4 21:36:33 mediabox kernel: CPU:    0
Jun  4 21:36:33 mediabox kernel: EIP:    0010:[<cd411829>]    Not tainted
Jun  4 21:36:33 mediabox kernel: EFLAGS: 00010282
Jun  4 21:36:33 mediabox kernel: eax: cd411808   ebx: cd411808   ecx: 9a1c3576   edx: 0000001f
Jun  4 21:36:33 mediabox kernel: esi: cd411800   edi: cdf3d400   ebp: d290e65c   esp: c7959e60
Jun  4 21:36:33 mediabox kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 21:36:33 mediabox kernel: Process modprobe (pid: 693, stackpage=c7959000)
Jun  4 21:36:33 mediabox kernel: Stack: c01dc533 cd411808 00000000 00000000 99c70465 0000001f cd411800 cdf3d400 
Jun  4 21:36:33 mediabox kernel:        d290e65c 99c76787 00000018 00000018 ffffff00 ffffffff cd411800 cdf3d400 
Jun  4 21:36:33 mediabox kernel:        d290e65c d290a37a cd411808 00000000 cd411800 d290ca44 cd411800 cdf3d400 
Jun  4 21:36:33 mediabox kernel: Call Trace:    [<c01dc533>] [<d290e65c>] [<d290e65c>] [<d290a37a>] [<d290ca44>]
Jun  4 21:36:33 mediabox kernel:   [<d290e65c>] [<d290e6a0>] [<c01ddb61>] [<d290e65c>] [<d290e6a0>] [<c01ddbf7>]
Jun  4 21:36:33 mediabox kernel:   [<d290e6a0>] [<d290ccea>] [<d290e6a0>] [<c01180fd>] [<d290dc7c>] [<d2909060>]
Jun  4 21:36:33 mediabox kernel:   [<d2909060>] [<c0107113>]
Jun  4 21:36:33 mediabox kernel: 
Jun  4 21:36:33 mediabox kernel: Code: 18 41 cd 01 00 00 00 00 00 00 00 34 18 41 cd 34 18 41 cd 00 
Jun  4 21:36:33 mediabox modprobe: modprobe: Can't locate module sound-service-0-0

===

>>EIP; cd411829 <_end+d12d1b1/e56b9e8>   <=====

>>eax; cd411808 <_end+d12d190/e56b9e8>
>>ebx; cd411808 <_end+d12d190/e56b9e8>
>>ecx; 9a1c3576 Before first symbol
>>esi; cd411800 <_end+d12d188/e56b9e8>
>>edi; cdf3d400 <_end+dc58d88/e56b9e8>
>>ebp; d290e65c <[via82cxxx_audio]via_pci_tbl+1c/54>
>>esp; c7959e60 <_end+76757e8/e56b9e8>

Trace; c01dc533 <ac97_probe_codec+13/1d0>
Trace; d290e65c <[via82cxxx_audio]via_pci_tbl+1c/54>
Trace; d290e65c <[via82cxxx_audio]via_pci_tbl+1c/54>
Trace; d290a37a <[via82cxxx_audio]via_ac97_init+aa/1b0>
Trace; d290ca44 <[via82cxxx_audio]via_init_one+194/350>
Trace; d290e65c <[via82cxxx_audio]via_pci_tbl+1c/54>
Trace; d290e6a0 <[via82cxxx_audio]via_driver+0/40>
Trace; c01ddb61 <pci_announce_device+21/60>
Trace; d290e65c <[via82cxxx_audio]via_pci_tbl+1c/54>
Trace; d290e6a0 <[via82cxxx_audio]via_driver+0/40>
Trace; c01ddbf7 <pci_register_driver+57/60>
Trace; d290e6a0 <[via82cxxx_audio]via_driver+0/40>
Trace; d290ccea <[via82cxxx_audio]init_via82cxxx_audio+a/40>
Trace; d290e6a0 <[via82cxxx_audio]via_driver+0/40>
Trace; c01180fd <sys_init_module+4fd/660>
Trace; d290dc7c <[via82cxxx_audio]__module_license+c0c/15b0>
Trace; d2909060 <[via82cxxx_audio]sg_active+0/30>
Trace; d2909060 <[via82cxxx_audio]sg_active+0/30>
Trace; c0107113 <system_call+33/40>

Code;  cd411829 <_end+d12d1b1/e56b9e8>
00000000 <_EIP>:
Code;  cd411829 <_end+d12d1b1/e56b9e8>   <=====
   0:   18 41 cd                  sbb    %al,0xffffffcd(%ecx)   <=====
Code;  cd41182c <_end+d12d1b4/e56b9e8>
   3:   01 00                     add    %eax,(%eax)
Code;  cd41182e <_end+d12d1b6/e56b9e8>
   5:   00 00                     add    %al,(%eax)
Code;  cd411830 <_end+d12d1b8/e56b9e8>
   7:   00 00                     add    %al,(%eax)
Code;  cd411832 <_end+d12d1ba/e56b9e8>
   9:   00 00                     add    %al,(%eax)
Code;  cd411834 <_end+d12d1bc/e56b9e8>
   b:   34 18                     xor    $0x18,%al
Code;  cd411836 <_end+d12d1be/e56b9e8>
   d:   41                        inc    %ecx
Code;  cd411837 <_end+d12d1bf/e56b9e8>
   e:   cd 34                     int    $0x34
Code;  cd411839 <_end+d12d1c1/e56b9e8>
  10:   18 41 cd                  sbb    %al,0xffffffcd(%ecx)

===

cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 8
model name      : VIA C3 Ezra
stepping        : 9
cpu MHz         : 932.914
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1861.22

===

cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  229908480 138338304 91570176        0 13086720 82006016
Swap: 542826496        0 542826496
MemTotal:       224520 kB
MemFree:         89424 kB
MemShared:           0 kB
Buffers:         12780 kB
Cached:          80084 kB
SwapCached:          0 kB
Active:          67328 kB
Inactive:        35528 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       224520 kB
LowFree:         89424 kB
SwapTotal:      530104 kB
SwapFree:       530104 kB

===

cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266] (rev 0).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device  13, function  0:
    FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 128).
      IRQ 10.
      Master Capable.  Latency=32.  Max Lat=32.
      Non-prefetchable 32 bit memory at 0xee002000 [0xee0027ff].
      I/O at 0xd000 [0xd07f].
  Bus  0, device  16, function  0:
    USB Controller: VIA Technologies, Inc. USB (rev 128).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device  16, function  1:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 128).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device  16, function  2:
    USB Controller: VIA Technologies, Inc. USB (#3) (rev 128).
      IRQ 12.
      Master Capable.  Latency=32.  
      I/O at 0xdc00 [0xdc1f].
  Bus  0, device  16, function  3:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
      IRQ 5.
      Master Capable.  Latency=32.  
      Non-prefetchable 32 bit memory at 0xee000000 [0xee0000ff].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xe000 [0xe00f].
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 80).
      IRQ 12.
      I/O at 0xe400 [0xe4ff].
  Bus  0, device  18, function  0:
    Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 116).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xee001000 [0xee0010ff].
  Bus  0, device  20, function  0:
    Multimedia video controller: Internext Compression Inc iTVC15 MPEG-2 Encoder (rev 1).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=128.Max Lat=8.
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics (rev 3).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=2.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
      Non-prefetchable 32 bit memory at 0xec000000 [0xecffffff].


Kind regards,
      
   /Robert

