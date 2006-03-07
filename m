Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWCGPxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWCGPxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWCGPxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:53:25 -0500
Received: from iron.webpack.hosteurope.de ([217.115.142.114]:26016 "EHLO
	iron.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S1751336AbWCGPxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:53:24 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: PROBLEM: Kernel Bug mm/mmap.c:1956
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Tue, 7 Mar 2006 16:53:11 +0100
Message-ID: <D9CCF8787CFEEA4DA0C3FCFFD027AE24111488@SERVER2000.merkle-partner.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Kernel Bug mm/mmap.c:1956
thread-index: AcZB/zxF9QvhTDCPQxujXml1qSWVTA==
From: "Christian Hopfensitz" <c.hopfensitz@merkle-partner.de>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Kernel Bug mm/mmap.c:1956 while compiling kernel on 4 cpus
[2.] kernel compiling is not possible on smp system. the job crashes. i used a script to test system stability with kernel compiling. 
[3.] kernel
[4.] 2.6.15-4-smp
[5.]

Mar  7 16:11:20 jana kernel: cc1: Corrupted page table at address ae4000
Mar  7 16:11:20 jana kernel: PGD 42ba3e067 PUD 202302000000796d BAD
Mar  7 16:11:20 jana kernel: Bad pagetable: 000f [1] SMP 
Mar  7 16:11:20 jana kernel: CPU 3 
Mar  7 16:11:20 jana kernel: Modules linked in: iptable_filter ip_tables forcedeth nvidia usbserial nfsd exportfs freq_table thermal ipv6 processor button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc af_packet edd evdev joydev st sr_mod sg ohci_hcd ehci_hcd usbcore nvnet i2c_nforce2 i2c_core parport_pc lp parport video1394 ohci1394 raw1394 ieee1394 capability commoncap dm_mod reiserfs ide_cd cdrom ide_disk sata_nv libata amd74xx ide_core sd_mod scsi_mod
Mar  7 16:11:20 jana kernel: Pid: 10979, comm: cc1 Tainted: P      2.6.15.4_CH-smp #1
Mar  7 16:11:20 jana kernel: RIP: 0033:[<00002aaaaac33385>] [<00002aaaaac33385>]
Mar  7 16:11:20 jana kernel: RSP: 002b:00007fffffbe2bd0  EFLAGS: 00010246
Mar  7 16:11:20 jana kernel: RAX: 00000000009d2d10 RBX: 0000000000000008 RCX: 0000000000000000
Mar  7 16:11:20 jana kernel: RDX: 0000000000000008 RSI: 0000000000af6800 RDI: 0000000000ae4000
Mar  7 16:11:20 jana kernel: RBP: 00000000009d28b0 R08: 0000000000ae3f30 R09: 0000000000000003
Mar  7 16:11:20 jana kernel: R10: 0000000000000811 R11: 00002aaaaade4620 R12: 0000000000ae4008
Mar  7 16:11:20 jana kernel: R13: 0000000000ae2620 R14: 00000000009d2ce0 R15: 0000000000af6800
Mar  7 16:11:20 jana kernel: FS:  00002aaaaade8b00(0000) GS:ffffffff80508980(0000) knlGS:0000000000000000
Mar  7 16:11:20 jana kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar  7 16:11:20 jana kernel: CR2: ffff830000007028 CR3: 00000003e2a62000 CR4: 00000000000006e0
Mar  7 16:11:20 jana kernel: Process cc1 (pid: 10979, threadinfo ffff8103b644a000, task ffff81044a15c920)
Mar  7 16:11:20 jana kernel: 
Mar  7 16:11:20 jana kernel: RIP [<00002aaaaac33385>] RSP <00007fffffbe2bd0>
Mar  7 16:11:20 jana kernel:  mm/memory.c:99: bad pud ffff81042ba3e000(202302000000796d).
Mar  7 16:11:20 jana kernel: ----------- [cut here ] --------- [please bite here ] ---------
Mar  7 16:11:20 jana kernel: Kernel BUG at mm/mmap.c:1956
Mar  7 16:11:20 jana kernel: invalid operand: 0000 [2] SMP 
Mar  7 16:11:20 jana kernel: CPU 3 
Mar  7 16:11:20 jana kernel: Modules linked in: iptable_filter ip_tables forcedeth nvidia usbserial nfsd exportfs freq_table thermal ipv6 processor button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc af_packet edd evdev joydev st sr_mod sg ohci_hcd ehci_hcd usbcore nvnet i2c_nforce2 i2c_core parport_pc lp parport video1394 ohci1394 raw1394 ieee1394 capability commoncap dm_mod reiserfs ide_cd cdrom ide_disk sata_nv libata amd74xx ide_core sd_mod scsi_mod
Mar  7 16:11:20 jana kernel: Pid: 10979, comm: cc1 Tainted: P      2.6.15.4_CH-smp #1
Mar  7 16:11:20 jana kernel: RIP: 0010:[<ffffffff8017097b>] <ffffffff8017097b>{exit_mmap+235}
Mar  7 16:11:20 jana kernel: RSP: 0018:ffff8103b644bd68  EFLAGS: 00010202
Mar  7 16:11:20 jana kernel: RAX: 0000000000000000 RBX: ffff81001801a260 RCX: 000000000000004a
Mar  7 16:11:20 jana kernel: RDX: ffff81040845e420 RSI: ffff81000001b000 RDI: ffff81044fc2a8c0
Mar  7 16:11:20 jana kernel: RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
Mar  7 16:11:20 jana kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffff81044d256e00
Mar  7 16:11:20 jana kernel: R13: 0000000000000009 R14: 0000000000000001 R15: ffff8103b644bf58
Mar  7 16:11:20 jana kernel: FS:  00002aaaaade8b00(0000) GS:ffffffff80508980(0000) knlGS:0000000000000000
Mar  7 16:11:20 jana kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Mar  7 16:11:20 jana kernel: CR2: 00002aaaaacc6950 CR3: 000000044ad95000 CR4: 00000000000006e0
Mar  7 16:11:21 jana kernel: Process cc1 (pid: 10979, threadinfo ffff8103b644a000, task ffff81044a15c920)
Mar  7 16:11:21 jana kernel: Stack: ffff81001801a260 00000000000007be ffff81044d256e00 ffff81044d256e78 
Mar  7 16:11:21 jana kernel:        ffff81044a15cf64 ffffffff801331e1 0000000


[6.] A small shell script or example program which triggers the
     problem (if possible)

#!/bin/sh
export MAKE='make -j5'

export LOOPCOUNT=1

rm -f /tmp/loops

cd /usr/src/linux
clear

while [ 1 ]; do
	echo -n "Durchlauf Nr. $LOOPCOUNT"
	STARTZEIT=`date +%s`
	make clean >  errorlog 2>&1
	make oldconfig >>  errorlog 2>&1
	make >>  errorlog 2>&1
	make modules >>  errorlog 2>&1
	ENDZEIT=`date +%s`
	GESAMT=`expr $ENDZEIT - $STARTZEIT`
	echo "  Laufzeit $GESAMT Sekunden"
	echo -n "Durchlauf Nr. $LOOPCOUNT" >> /tmp/loops
	echo "  Laufzeit $GESAMT Sekunden" >> /tmp/loops
	LOOPCOUNT=`expr $LOOPCOUNT + 1`
done

[7.] suse 9.3 
[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux jana 2.6.15.4_CH-smp #1 SMP Tue Mar 7 09:56:48 CET 2006 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre1
e2fsprogs              1.36
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.6.25
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        11 01:09 /lib64/libc.so.6
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   053
Modules Loaded         iptable_filter ip_tables forcedeth nvidia usbserial nfsd exportfs freq_table thermal ipv6 processor button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc af_packet edd evdev joydev st sr_mod sg ohci_hcd ehci_hcd usbcore nvnet i2c_nforce2 i2c_core parport_pc lp parport video1394 ohci1394 raw1394 ieee1394 capability commoncap dm_mod reiserfs ide_cd cdrom ide_disk sata_nv libata amd74xx ide_core sd_mod scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 270
stepping	: 2
cpu MHz		: 2009.270
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4022.82
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 270
stepping	: 2
cpu MHz		: 2009.270
cache size	: 1024 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4018.81
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 2
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 270
stepping	: 2
cpu MHz		: 2009.270
cache size	: 1024 KB
physical id	: 1
siblings	: 2
core id		: 0
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4018.82
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor	: 3
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 33
model name	: Dual Core AMD Opteron(tm) Processor 270
stepping	: 2
cpu MHz		: 2009.270
cache size	: 1024 KB
physical id	: 1
siblings	: 2
core id		: 1
cpu cores	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips	: 4018.81
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts fid vid tt


[7.3.] Module information (from /proc/modules):
iptable_filter 4608 0 - Live 0xffffffff887b2000
ip_tables 24720 1 iptable_filter, Live 0xffffffff887aa000
forcedeth 28804 0 - Live 0xffffffff887a1000
nvidia 4864944 12 - Live 0xffffffff882fc000
usbserial 37168 0 - Live 0xffffffff882f1000
nfsd 118216 9 - Live 0xffffffff882d3000
exportfs 8064 1 nfsd, Live 0xffffffff882d0000
freq_table 6592 0 - Live 0xffffffff882cd000
thermal 17552 0 - Live 0xffffffff882c7000
ipv6 308288 26 - Live 0xffffffff8827a000
processor 28360 1 thermal, Live 0xffffffff88272000
button 9056 0 - Live 0xffffffff8826e000
battery 12232 1 - Live 0xffffffff8826a000
ac 6856 0 - Live 0xffffffff88267000
snd_pcm_oss 68512 0 - Live 0xffffffff88255000
snd_mixer_oss 21696 1 snd_pcm_oss, Live 0xffffffff8824e000
snd_intel8x0 39720 0 - Live 0xffffffff88243000
snd_ac97_codec 117528 1 snd_intel8x0, Live 0xffffffff88225000
snd_ac97_bus 3968 1 snd_ac97_codec, Live 0xffffffff8813d000
snd_pcm 119944 3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec, Live 0xffffffff88206000
snd_timer 31368 1 snd_pcm, Live 0xffffffff881fd000
snd 77896 6 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer, Live 0xffffffff881e8000
soundcore 13088 1 snd, Live 0xffffffff881e3000
snd_page_alloc 14864 2 snd_intel8x0,snd_pcm, Live 0xffffffff881de000
af_packet 28044 4 - Live 0xffffffff881d6000
edd 13088 0 - Live 0xffffffff881d1000
evdev 14592 0 - Live 0xffffffff881cc000
joydev 13376 0 - Live 0xffffffff881c7000
st 45996 0 - Live 0xffffffff881ba000
sr_mod 20644 0 - Live 0xffffffff881b3000
sg 45688 0 - Live 0xffffffff881a6000
ohci_hcd 24260 0 - Live 0xffffffff8819f000
ehci_hcd 38216 0 - Live 0xffffffff88194000
usbcore 152872 4 usbserial,ohci_hcd,ehci_hcd, Live 0xffffffff8816d000
nvnet 79208 0 - Live 0xffffffff88158000
i2c_nforce2 9088 0 - Live 0xffffffff88154000
i2c_core 27264 1 i2c_nforce2, Live 0xffffffff8814c000
parport_pc 45864 0 - Live 0xffffffff8813f000
lp 15368 0 - Live 0xffffffff88138000
parport 45836 2 parport_pc,lp, Live 0xffffffff8812b000
video1394 23416 0 - Live 0xffffffff88124000
ohci1394 37880 1 video1394, Live 0xffffffff88119000
raw1394 30872 0 - Live 0xffffffff88110000
ieee1394 119096 3 video1394,ohci1394,raw1394, Live 0xffffffff880f1000
capability 6984 0 - Live 0xffffffff880ee000
commoncap 9984 1 capability, Live 0xffffffff880ea000
dm_mod 67984 0 - Live 0xffffffff880d8000
reiserfs 263024 2 - Live 0xffffffff88096000
ide_cd 46880 0 - Live 0xffffffff88089000
cdrom 42280 2 sr_mod,ide_cd, Live 0xffffffff8807d000
ide_disk 20480 0 - Live 0xffffffff88077000
sata_nv 12484 4 - Live 0xffffffff88072000
libata 68632 1 sata_nv, Live 0xffffffff88060000
amd74xx 16816 0 [permanent], Live 0xffffffff8805a000
ide_core 163460 3 ide_cd,ide_disk,amd74xx, Live 0xffffffff88031000
sd_mod 21824 6 - Live 0xffffffff8802a000
scsi_mod 165840 5 st,sr_mod,sg,libata,sd_mod, Live 0xffffffff88000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

ioports:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-101f : 0000:00:01.1
1400-140f : 0000:00:06.0
  1400-1407 : ide0
  1408-140f : ide1
1410-141f : 0000:00:07.0
  1410-141f : sata_nv
1420-142f : 0000:00:08.0
  1420-142f : sata_nv
1430-1433 : 0000:00:07.0
  1430-1433 : sata_nv
1434-1437 : 0000:00:07.0
  1434-1437 : sata_nv
1438-143f : 0000:00:07.0
  1438-143f : sata_nv
1440-1447 : 0000:00:07.0
  1440-1447 : sata_nv
1448-144b : 0000:00:08.0
  1448-144b : sata_nv
144c-144f : 0000:00:08.0
  144c-144f : sata_nv
1450-1457 : 0000:00:08.0
  1450-1457 : sata_nv
1458-145f : 0000:00:08.0
  1458-145f : sata_nv
1460-1467 : 0000:00:0a.0
2000-2007 : 0000:80:0a.0
8000-807f : motherboard
  8000-8003 : PM1a_EVT_BLK
  8004-8005 : PM1a_CNT_BLK
  8008-800b : PM_TMR
  8010-8015 : ACPI CPU throttle
  801c-801c : PM2_CNT_BLK
  8020-8027 : GPE0_BLK
8080-80ff : motherboard
8400-847f : motherboard
8480-84ff : motherboard
8800-887f : motherboard
8880-88ff : motherboard
9000-907f : motherboard
9080-90ff : motherboard
9200-927f : motherboard
9280-92ff : motherboard
9400-947f : motherboard
9480-94ff : motherboard
a000-a03f : 0000:00:01.1
  a000-a03f : motherboard
    a000-a007 : nForce2_smbus
a040-a07f : 0000:00:01.1
  a040-a07f : motherboard
    a040-a047 : nForce2_smbus

iomem:
00000000-0009b7ff : System RAM
0009b800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cedff : Video ROM
000cf000-000d07ff : Adapter ROM
000d0800-000d83ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ff8ffff : System RAM
  00100000-0034db9e : Kernel code
  0034db9f-00484387 : Kernel data
7ff90000-7ff96fff : ACPI Tables
7ff97000-7fffffff : ACPI Non-volatile Storage
80000000-aff7ffff : System RAM
aff80000-afffffff : reserved
b0000000-b0000fff : 0000:00:02.0
  b0000000-b0000fff : ohci_hcd
b0001000-b00010ff : 0000:00:02.1
  b0001000-b00010ff : ehci_hcd
b0002000-b0002fff : 0000:00:07.0
  b0002000-b0002fff : sata_nv
b0003000-b0003fff : 0000:00:08.0
  b0003000-b0003fff : sata_nv
b0004000-b0004fff : 0000:00:0a.0
  b0004000-b0004fff : nvenet
b0100000-b01fffff : PCI Bus #01
  b0100000-b0103fff : 0000:01:05.0
  b0104000-b01047ff : 0000:01:05.0
    b0104000-b01047ff : ohci1394
b1000000-b2ffffff : PCI Bus #02
  b1000000-b1ffffff : 0000:02:00.0
  b2000000-b2ffffff : 0000:02:00.0
    b2000000-b2ffffff : nvidia
c0000000-cfffffff : PCI Bus #02
  c0000000-cfffffff : 0000:02:00.0
    c0000000-cfffffff : vesafb
d0000000-d0000fff : 0000:08:0a.1
d0001000-d0001fff : 0000:08:0b.1
d0400000-d0400fff : 0000:80:01.0
d0401000-d0401fff : 0000:80:0a.0
  d0401000-d0401fff : nvenet
e0000000-efffffff : reserved
fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved
100000000-44fffffff : System RAM


[7.5.] PCI information ('lspci -vvv' as root)
0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a801]

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 0051 (rev a3)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: I/O ports at <ignored>

0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1000 [size=32]
	Region 4: I/O ports at a000 [size=64]
	Region 5: I/O ports at a040 [size=64]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) (prog-if 10 [OHCI])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) (prog-if 20 [EHCI])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin B routed to IRQ 217
	Region 0: Memory at b0001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] #0a [2098]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a [Master SecP PriP])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Region 4: I/O ports at 1400 [size=16]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at 1440 [size=8]
	Region 1: I/O ports at 1434 [size=4]
	Region 2: I/O ports at 1438 [size=8]
	Region 3: I/O ports at 1430 [size=4]
	Region 4: I/O ports at 1410 [size=16]
	Region 5: Memory at b0002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) (prog-if 85 [Master SecO PriO])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (750ns min, 250ns max)
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at 1458 [size=8]
	Region 1: I/O ports at 144c [size=4]
	Region 2: I/O ports at 1450 [size=8]
	Region 3: I/O ports at 1448 [size=4]
	Region 4: I/O ports at 1420 [size=16]
	Region 5: Memory at b0003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: b0100000-b01fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 201
	Region 0: Memory at b0004000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1460 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: b1000000-b2ffffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000cff00000
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:01:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 193
	Region 0: Memory at b0104000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at b0100000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:02:00.0 VGA compatible controller: nVidia Corporation NV41.0 (rev a2) (prog-if 00 [VGA])
	Subsystem: CardExpert Technology: Unknown device 0401
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at b2000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at b1000000 (64-bit, non-prefetchable) [size=16M]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]

0000:08:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=08, secondary=09, subordinate=09, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [004a]

0000:08:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (64-bit, non-prefetchable) [size=4K]

0000:08:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]

0000:08:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0001000 (64-bit, non-prefetchable) [size=4K]

0000:80:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [44] #08 [01e0]
	Capabilities: [e0] #08 [a801]

0000:80:01.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 1: Memory at d0400000 (32-bit, non-prefetchable) [size=4K]

0000:80:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: Tyan Computer: Unknown device 2895
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (250ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at d0401000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 2000 [size=8]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:80:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 10
	Bus: primary=80, secondary=81, subordinate=81, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [58] #08 [a800]
	Capabilities: [80] #10 [0141]

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD080HJ  Rev: WT10
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD080HJ  Rev: WT10
  Type:   Direct-Access                    ANSI SCSI revision: 05


[7.7.] Other information that might be relevant to the problem

[X.] Other notes, patches, fixes, workarounds:
parallel cfd-jobs using mpich also fail (application: star-cd)

regards
Christian

