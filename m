Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRJQPAw>; Wed, 17 Oct 2001 11:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276920AbRJQPAe>; Wed, 17 Oct 2001 11:00:34 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:59599 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S276914AbRJQPAT>; Wed, 17 Oct 2001 11:00:19 -0400
Date: Wed, 17 Oct 2001 11:00:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.10-- Unable to handle kernel paging request
Message-ID: <20011017110045.A5444@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: jstrand1@rochester.rr.com (James D Strandboge)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Oops:  Unable to handle kernel paging request

[2.] Last night I got 31 oops starting  at about 6:30am.  This is right 
when my cron.daily scripts run (which include updatedb and others).  This
is an nfs server for my LAN, and I have a worstation that also runs
cron.daily at the same time, and therefore over the nfs volumes (if
this matters).  I have not been able to reproduce this at will, though
it has happened several times.  The filesystem used for the nfs export
is ext2 (reiserfs and xfs were also used and oops'd too).  The kernel
is vanilla 2.4.10-- no patches.

[3.] Keywords:  kernel paging

[4.] Linux version 2.4.10-nfs1 (root@hagrid) (gcc version 2.95.4 
	20010902 (Debian prerelease)) #1 Thu Oct 4 19:35:45 EDT 2001

[5.] This is the first oops message.  There are over 1000 lines of the
oops messages that occured.  Please let me know if you need more.

ksymoops 2.4.3 on i586 2.4.10-nfs1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-nfs1/ (default)
     -m /boot/System.map-2.4.10-nfs1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct 14 17:37:44 hagrid kernel: Intel Pentium with F0 0F bug - workaround enabled.
Oct 15 15:22:08 hagrid kernel: Intel Pentium with F0 0F bug - workaround enabled.
Oct 16 09:30:28 hagrid kernel: Intel Pentium with F0 0F bug - workaround enabled.
Oct 17 06:29:06 hagrid kernel: Unable to handle kernel paging request at virtual address b4d5eec8
Oct 17 06:29:06 hagrid kernel: c0140b99
Oct 17 06:29:06 hagrid kernel: *pde = 00000000
Oct 17 06:29:06 hagrid kernel: Oops: 0002
Oct 17 06:29:06 hagrid kernel: CPU:    0
Oct 17 06:29:06 hagrid kernel: EIP:    0010:[get_new_inode+93/368]
Oct 17 06:29:06 hagrid kernel: EFLAGS: 00010202
Oct 17 06:29:06 hagrid kernel: eax: b4d5eec8   ebx: 00000000   ecx: c1d61060   edx: c1d61be8
Oct 17 06:29:06 hagrid kernel: esi: b4d5eec0   edi: c109c2e8   ebp: c10f9a00   esp: c1a7becc
Oct 17 06:29:06 hagrid kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 06:29:06 hagrid kernel: Process find (pid: 23767, stackpage=c1a7b000)
Oct 17 06:29:06 hagrid kernel: Stack: 00000000 c109c2e8 000eb2c8 c10f9a00 c0140e62 c10f9a00 000eb2c8 c109c2e8 
Oct 17 06:29:06 hagrid kernel:        00000000 00000000 c05260b0 c0383640 c05260b0 c05265f0 c01508e2 c10f9a00 
Oct 17 06:29:06 hagrid kernel:        000eb2c8 00000000 00000000 fffffff4 c0383640 c0137607 c0383640 c05260b0 
Oct 17 06:29:06 hagrid kernel: Call Trace: [iget4+206/216] [ext2_lookup+66/104] [real_lookup+83/196] [path_walk+1191/1720] [getname+94/156] 
Oct 17 06:29:06 hagrid kernel: Code: 89 56 08 c7 40 04 1c a1 23 c0 a3 1c a1 23 c0 8b 07 89 70 04 
Using defaults from ksymoops -t elf32-i386 -a i386 

Code;  00000000 Before first symbol
00000000 <_EIP>: 
Code;  00000000 Before first symbol
   0:   89 56 08                  mov    %edx,0x8(%esi)
Code;  00000002 Before first symbol
   3:   c7 40 04 1c a1 23 c0      movl   $0xc023a11c,0x4(%eax)
Code;  0000000a Before first symbol
   a:   a3 1c a1 23 c0            mov    %eax,0xc023a11c
Code;  0000000e Before first symbol
   f:   8b 07                     mov    (%edi),%eax
Code;  00000010 Before first symbol
  11:   89 70 04                  mov    %esi,0x4(%eax)

[6.] couldn't find a reproducible situation

[7.1.]
sh scripts/ver_linux
Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.31
util-linux             2.11h
mount                  2.11h
modutils               2.4.8
e2fsprogs              1.25
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         rtc tulip ipchains

[7.2.]
cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 2
model name      : Pentium 75 - 200
stepping        : 11
cpu MHz         : 132.956
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8
bogomips        : 265.42

[7.3.]
cat /proc/modules
rtc                     5696   0 (autoclean)
tulip                  35360   1
ipchains               39168   0 (unused)

[7.4.]
cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02e8-02ef : serial(set)
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
fc00-fcff : Lite-On Communications Inc LNE100TX
  fc00-fcff : tulip

cat /proc/iomem
00000000-0009fbff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-01ffffff : System RAM
  00100000-00206a71 : Kernel code
  00206a72-00248fdf : Kernel data
ff000000-ff7fffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
fffbfc00-fffbfcff : Lite-On Communications Inc LNE100TX
  fffbfc00-fffbfcff : tulip
fffc0000-ffffffff : reserved

[7.5.]
lspci -vvv
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64

00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at fc00 [size=256]
        Region 1: Memory at fffbfc00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

[7.6.] no scsi

[7.7.] none

[X.] no patches applied, no patches submitted


Let me know if you need all the other oops messages.

James Strandboge

-- 
GPG/PGP Info
Email:        jstrand1@rochester.rr.com
ID:           26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A
--
