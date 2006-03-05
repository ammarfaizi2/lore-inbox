Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWCEU7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCEU7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 15:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWCEU7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 15:59:39 -0500
Received: from male.eservglobal.co.nz ([203.118.128.140]:47745 "EHLO
	smtp.eservglobal.co.nz") by vger.kernel.org with ESMTP
	id S932132AbWCEU7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 15:59:38 -0500
Message-ID: <440B4FE3.4000809@eservglobal.com>
Date: Mon, 06 Mar 2006 09:53:55 +1300
From: Iain William Wiseman <iwiseman@eservglobal.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hope I am sending this to the right place. Let me know if you need any 
other infor

The machine crashed while trying to use NFS

*Kernel Version*
Linux version 2.6.15.4 (root@denise.wiseman.com) (gcc version 4.0.0 
20050519 (Red Hat 4.0.0-8)) #1 Sat Feb 25 21:23:05 NZDT 2006

*Output of Oops*

Mar  5 23:03:54 denise kernel: portmap: server localhost not responding, timed out
Mar  5 23:03:54 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:04:24 denise kernel: portmap: server localhost not responding, timed out
Mar  5 23:04:24 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:04:24 denise kernel: lockd_down: no lockd running.
Mar  5 23:04:24 denise kernel: svc_destroy: no threads for serv=cd002bc0!
Mar  5 23:04:24 denise kernel: Unable to handle kernel paging request at virtual address dead4eb9
Mar  5 23:04:24 denise kernel:  printing eip:
Mar  5 23:04:24 denise kernel: d0bbabb2
Mar  5 23:04:24 denise kernel: *pde = 00000000
Mar  5 23:04:24 denise kernel: Oops: 0000 [#1]
Mar  5 23:04:24 denise kernel: Modules linked in: nfsd exportfs lockd ipv6 autofs4 sunrpc video button battery ac uhci_hcd shpchp ns558 gameport snd_sbawe snd_opl3_lib snd_sb16_dsp snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_sb16_csp snd_sb_common snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 8139too mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod sata_via libata sd_mod scsi_mod
Mar  5 23:04:24 denise kernel: CPU:    0
Mar  5 23:04:24 denise kernel: EIP:    0060:[<d0bbabb2>]    Not tainted VLI
Mar  5 23:04:24 denise kernel: EFLAGS: 00010246   (2.6.15.4)
Mar  5 23:04:24 denise kernel: EIP is at svc_delete_socket+0x12/0xd0 [sunrpc]
Mar  5 23:04:24 denise kernel: eax: dead4ea5   ebx: dead4ea5   ecx: ffffffff   edx: 00000246
Mar  5 23:04:24 denise kernel: esi: cd002bc0   edi: cffca7a0   ebp: cabd5000   esp: c87e6fa0
Mar  5 23:04:24 denise kernel: ds: 007b   es: 007b   ss: 0068
Mar  5 23:04:24 denise kernel: Process nfsd (pid: 3615, threadinfo=c87e6000 task=c89f5ab0)
Mar  5 23:04:24 denise kernel: Stack: cd002bfc cd002bc0 cffca7a0 d0bb80f3 00000041 cd002bc0 d0a294d1 00100100
Mar  5 23:04:24 denise kernel:        00200200 c89f5ab0 fffffeff ffffffff fffffef8 ffffffff d0a29260 00000000
Mar  5 23:04:24 denise kernel:        00000000 00000000 c0101309 cabd5000 00000000 00000000 00000000 00000000
Mar  5 23:04:24 denise kernel: Call Trace:
Mar  5 23:04:24 denise kernel:  [<d0bb80f3>] svc_destroy+0x33/0xb0 [sunrpc]
Mar  5 23:04:24 denise kernel:  [<d0a294d1>] nfsd+0x271/0x300 [nfsd]
Mar  5 23:04:24 denise kernel:  [<d0a29260>] nfsd+0x0/0x300 [nfsd]
Mar  5 23:04:24 denise kernel:  [<c0101309>] kernel_thread_helper+0x5/0xc
Mar  5 23:04:24 denise kernel: Code: ff ff 8b 04 24 f7 d8 50 68 b4 39 bc d0 e8 a7 08 56 ef 58 5a e9 63 ff ff ff 57 f6 05 a9 50 bd d0 01 56 53 89 c3 0f 85 ac 00 00 00 <8b> 53 14 8b 43 58 8b 7b 18 89 82 74 01 00 00 8b 43 5c 8d 77 18
Mar  5 23:04:29 denise kernel:  <5>portmap: server localhost not responding, timed out
Mar  5 23:04:29 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:04:59 denise kernel: portmap: server localhost not responding, timed out
Mar  5 23:04:59 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:05:04 denise kernel: portmap: server localhost not responding, timed out
Mar  5 23:05:04 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:05:34 denise kernel: portmap: server localhost not responding, timed out



*Processor Information*
[root@denise log]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.952
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr
bogomips        : 802.72

*Modules*
[root@denise log]# cat /proc/modules
ipv6 255456 26 - Live 0xd0a3a000
parport_pc 28356 1 - Live 0xd0a05000
lp 13384 0 - Live 0xd0a00000
parport 35912 2 parport_pc,lp, Live 0xd09f6000
autofs4 19716 2 - Live 0xd09f0000
sunrpc 147644 1 - Live 0xd0a11000
video 16388 0 - Live 0xd0988000
button 6928 0 - Live 0xd0985000
battery 9860 0 - Live 0xd0971000
ac 5124 0 - Live 0xd096e000
uhci_hcd 33296 0 - Live 0xd097b000
shpchp 44832 0 - Live 0xd0962000
ns558 5764 0 - Live 0xd0905000
gameport 16136 2 ns558, Live 0xd095d000
snd_sbawe 29632 0 - Live 0xd0954000
snd_opl3_lib 11008 1 snd_sbawe, Live 0xd0950000
snd_sb16_dsp 11648 1 snd_sbawe, Live 0xd0977000
snd_seq_dummy 4100 0 - Live 0xd088d000
snd_seq_oss 32128 0 - Live 0xd0947000
snd_seq_midi_event 7552 1 snd_seq_oss, Live 0xd0859000
snd_seq 50704 5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event, Live 
0xd0939000
snd_pcm_oss 52384 0 - Live 0xd090c000
snd_mixer_oss 18176 1 snd_pcm_oss, Live 0xd08ff000
snd_pcm 87428 2 snd_sb16_dsp,snd_pcm_oss, Live 0xd0922000
snd_timer 25348 3 snd_opl3_lib,snd_seq,snd_pcm, Live 0xd08f7000
snd_page_alloc 10888 1 snd_pcm, Live 0xd08f3000
snd_sb16_csp 20352 1 snd_sbawe, Live 0xd08ed000
snd_sb_common 15616 3 snd_sbawe,snd_sb16_dsp,snd_sb16_csp, Live 0xd08e8000
snd_hwdep 9504 2 snd_opl3_lib,snd_sb16_csp, Live 0xd0908000
snd_mpu401_uart 8192 1 snd_sbawe, Live 0xd0846000
snd_rawmidi 25504 1 snd_mpu401_uart, Live 0xd091a000
snd_seq_device 9228 6 
snd_sbawe,snd_opl3_lib,snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi, 
Live 0xd08c3000
snd 55012 15 
snd_sbawe,snd_opl3_lib,snd_sb16_dsp,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_sb16_csp,snd_sb_common,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xd0996000
soundcore 9952 1 snd, Live 0xd08bf000
8139too 27776 0 - Live 0xd08b7000
mii 6016 1 8139too, Live 0xd083f000
floppy 62148 0 - Live 0xd08a6000
dm_snapshot 17580 0 - Live 0xd08a0000
dm_zero 2048 0 - Live 0xd083d000
dm_mirror 22480 0 - Live 0xd0819000
ext3 130824 2 - Live 0xd08c7000
jbd 57108 1 ext3, Live 0xd087e000
dm_mod 57624 7 dm_snapshot,dm_zero,dm_mirror, Live 0xd0890000
sata_via 8580 3 - Live 0xd0837000
libata 57484 1 sata_via, Live 0xd0849000
sd_mod 18944 5 - Live 0xd0831000
scsi_mod 134696 2 libata,sd_mod, Live 0xd085c000

*Loaded Driver and Hardware Information*

[root@denise log]# cat /proc/ioports
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
0200-0207 : ns558-pnp
0213-0213 : ISAPnP
0220-022f : SoundBlaster
02f8-02ff : serial
0330-0331 : MPU401 UART
0378-037a : parport0
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0620-0623 : Emu8000-1
0a20-0a23 : Emu8000-2
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : Emu8000-3
4000-403f : 0000:00:07.3
  4000-4003 : PM1a_EVT_BLK
  4008-400b : PM_TMR
  400c-400f : GPE0_BLK
  4010-4015 : ACPI CPU throttle
4040-4041 : PM1a_CNT_BLK
5000-500f : 0000:00:07.3
c000-cfff : PCI Bus #01
d000-d01f : 0000:00:07.2
  d000-d01f : uhci_hcd
d400-d40f : 0000:00:08.0
  d400-d40f : sata_via
d800-d80f : 0000:00:08.0
  d800-d80f : sata_via
dc00-dc0f : 0000:00:08.0
  dc00-dc0f : sata_via
e000-e00f : 0000:00:08.0
  e000-e00f : sata_via
e400-e41f : 0000:00:08.0
  e400-e41f : sata_via
e800-e8ff : 0000:00:08.0
  e800-e8ff : sata_via
ec00-ecff : 0000:00:0a.0
  ec00-ecff : 8139too
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1


[root@denise log]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0031225f : Kernel code
  00312260-003c1783 : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
d8000000-dbffffff : 0000:00:00.0
dc000000-ddffffff : PCI Bus #01
  dc000000-dcffffff : 0000:01:00.0
  dd000000-dd00ffff : 0000:01:00.0
de000000-dfffffff : PCI Bus #01
  de000000-dfffffff : 0000:01:00.0
e0000000-e000ffff : 0000:00:08.0
e1000000-e10000ff : 0000:00:0a.0
  e1000000-e10000ff : 8139too
ffff0000-ffffffff : reserved

*PCI Information
*[root@denise log]# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: de000000-dfffffff
        Secondary status: 66Mhz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 
01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d000 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID 
Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=16]
        Region 1: I/O ports at d800 [size=16]
        Region 2: I/O ports at dc00 [size=16]
        Region 3: I/O ports at e000 [size=16]
        Region 4: I/O ports at e400 [size=32]
        Region 5: I/O ports at e800 [size=256]
        Expansion ROM at e0000000 [disabled] [size=64K]
        Capabilities: [e0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 
Model 64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at de000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at dd000000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

*SCSI Information*
[root@denise log]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1600JD-00H Rev: 08.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD1600JD-00H Rev: 08.0
  Type:   Direct-Access                    ANSI SCSI revision: 05

*Other Information*
Mar  5 23:01:15 denise kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Mar  5 23:01:15 denise kernel: NFSD: Using /var/lib/nfs/v4recovery as 
the NFSv4 state recovery directory
Mar  5 23:01:15 denise kernel: NFSD: recovery directory 
/var/lib/nfs/v4recovery doesn't exist
Mar  5 23:01:15 denise kernel: NFSD: starting 90-second grace period
Mar  5 23:01:50 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:01:50 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:01:59 denise sshd(pam_unix)[3536]: session opened for user 
root by root(uid=0)
Mar  5 23:02:25 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:02:25 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:02:39 denise rpc.mountd: unable to register (mountd, 1, udp).
Mar  5 23:02:39 denise rpc.idmapd: nfsdreopen: Opening '' failed: errno 
2 (No such file or directory)
Mar  5 23:03:00 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:03:00 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:03:02 denise crond(pam_unix)[3639]: session opened for user 
iwiseman by (uid=0)
Mar  5 23:03:14 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:03:14 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:03:19 denise kernel: NFSD: Using /var/lib/nfs/v4recovery as 
the NFSv4 state recovery directory
Mar  5 23:03:19 denise kernel: NFSD: recovery directory 
/var/lib/nfs/v4recovery doesn't exist
Mar  5 23:03:19 denise kernel: NFSD: starting 90-second grace period
Mar  5 23:03:19 denise crond(pam_unix)[3639]: session closed for user 
iwiseman
Mar  5 23:03:49 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:03:49 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:03:49 denise kernel: lockd_up: makesock failed, error=-5
Mar  5 23:03:54 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:03:54 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:04:24 denise kernel: portmap: server localhost not responding, 
timed out
Mar  5 23:04:24 denise kernel: RPC: failed to contact portmap (errno -5).
Mar  5 23:04:24 denise kernel: lockd_down: no lockd running.
Mar  5 23:04:24 denise kernel: svc_destroy: no threads for serv=cd002bc0!
Mar  5 23:04:24 denise kernel: Unable to handle kernel paging request at 
virtual address dead4eb9
Mar  5 23:04:24 denise kernel:  printing eip:
Mar  5 23:04:24 denise kernel: d0bbabb2

Thanks,
Iain
New Zealand
