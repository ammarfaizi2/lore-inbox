Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUL3A1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUL3A1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUL3A1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:27:54 -0500
Received: from pop.gmx.net ([213.165.64.20]:61849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261463AbUL3AZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:25:57 -0500
X-Authenticated: #20477425
From: Micha <micha-1@fantasymail.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide problem...
Date: Thu, 30 Dec 2004 01:25:55 +0100
User-Agent: KMail/1.7
References: <200412292213.34517.micha-1@fantasymail.de> <Pine.LNX.4.61.0412300004090.3495@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0412300004090.3495@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412300125.55778.micha-1@fantasymail.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. Dezember 2004 00:10 schrieben Sie:
> Basically you are not telling us anything.

hmm, yes indeed, I somehow thought that there are known differences with 
ide-scsi and normal ide which I overlooked...

the problem:
I got an error from libdvdread (DVDREAD_VERSION 904):
"cannot seek to block x", x > 2000000, while reading a dvd. 
I never got this error before with other dvds. The dvd worked under windows so 
I tried to find something to solve that. The first (and sufficient :-) idea 
was switching to ide-scsi for my dvd-rom. The dvd is readable with ide-scsi. 
This might of course be a bug in libdvdread...

my system:
# ./ver_linux
Linux termite.de 2.6.9-nitro4 #3 Mon Dec 20 23:57:32 CET 2004 i686 AMD 
Athlon(tm) XP 2800+ unknown GNU/Linux

Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.17
reiser4progs           1.0.0
xfsprogs               2.6.13
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         lp parport_pc parport snd_pcm_oss snd_mixer_oss 
snd_cmipci snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep gameport 
snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore af_packet usbhid 
floppy sr_mod 8139too mii ide_scsi scsi_mod ide_cd cdrom loop nls_iso8859_15 
nls_cp850 vfat fat xfs raid1 nvidia_agp agpgart tuner tvaudio bttv video_buf 
firmware_class i2c_algo_bit v4l2_common btcx_risc i2c_core videodev nvidia 
usblp ehci_hcd ohci_hcd usbcore thermal processor fan button battery ac

cpu: processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2800+
stepping        : 0
cpu MHz         : 2079.593
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4120.57

the ide part of lspci (Asus A7N8X Mainboard):
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

the dvd-rom is a pioneer dvd-116:
#cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-116  Rev: 1.22
  Type:   CD-ROM                           ANSI SCSI revision: 02

or  
#cat /proc/ide/hdb/model:
Pioneer DVD-ROM ATAPIModel DVD-116 0122


thanks for answering,
 Michael
