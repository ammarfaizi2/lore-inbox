Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUE3RbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUE3RbS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 13:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUE3RbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 13:31:18 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:8939 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S264255AbUE3Raq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 13:30:46 -0400
Subject: PROBLEM: CDRW48P device and also USB problems (Fedora Core 2
	kernel)
From: Philip Van Hoof <spamfrommailing@freax.org>
Reply-To: spamfrommailing@freax.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 30 May 2004 19:30:44 +0200
Message-Id: <1085938244.19006.41.camel@pluisje>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-1) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have to problems to report on my system:

[root@pluisje root]# uname -a
Linux pluisje 2.6.5-1.358smp #1 SMP Sat May 8 09:25:36 EDT 2004 i686
i686 i386 GNU/Linux
[root@pluisje root]#


First one, when I put an empty cd in my CD-R drive

[root@pluisje root]# cdrecord -scanbus
Cdrecord-Clone 2.01a27-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2004
Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to
<warly@mandrakesoft.com>.
Note: The author of cdrecord should not be bothered with problems in
this version.
scsidev: 'ATA'
devname: 'ATA'
scsibus: -2 target: -2 lun: -2
Warning: Using badly designed ATAPI via /dev/hd* interface.
Linux sg driver version: 3.5.27
Using libscg version 'schily-0.8'.
cdrecord: Warning: using inofficial libscg transport code version
(schily - Red Hat-scsi-linux-sg.c-1.80-RH '@(#)scsi-linux-sg.c 1.80
04/03/08 Copyright 1997 J. Schilling').
scsibus1:
        1,0,0   100) 'HL-DT-ST' 'DVD-ROM GDR8161B' '0100' Removable
CD-ROM
        1,1,0   101) 'PHILIPS ' 'CDRW48P         ' 'P1.4' Removable
CD-ROM
        1,2,0   102) *
        1,3,0   103) *
        1,4,0   104) *
        1,5,0   105) *
        1,6,0   106) *
        1,7,0   107) *
[root@pluisje root]#


ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  No reference position found (media may be upside down) -- (asc=0x06,
ascq=0x00 )
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
cdrom: This disc doesn't have any tracks I recognize!
ATAPI device hdd:
  Error: Not ready -- (Sense key=0x02)
  Incompatible medium installed -- (asc=0x30, ascq=0x00)
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "
ATAPI device hdd:
  Error: Not ready -- (Sense key=0x02)
  Incompatible medium installed -- (asc=0x30, ascq=0x00)
  The failed "Read Cd/Dvd Capacity" packet command was:
  "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "


And also this one:

irq 11: nobody cared! (screaming interrupt?)
Call Trace:
 [<021074ed>] __report_bad_irq+0x2b/0x67
 [<02107585>] note_interrupt+0x43/0x66
 [<021077d7>] do_IRQ+0x134/0x19a
 [<02104018>] default_idle+0x0/0x2c
 [<02104041>] default_idle+0x29/0x2c
 [<0210409d>] cpu_idle+0x26/0x3b
 [<0211eaf1>] __call_console_drivers+0x36/0x42
 [<0211ec0b>] call_console_drivers+0xbe/0xe3
 
handlers:
[<0222dd6e>] (usb_hcd_irq+0x0/0x4b)
[<0222dd6e>] (usb_hcd_irq+0x0/0x4b)
Disabling IRQ #11



[root@pluisje root]# sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
  
Linux pluisje 2.6.5-1.358smp #1 SMP Sat May 8 09:25:36 EDT 2004 i686
i686 i386 GNU/Linux
  
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
jfsutils               1.1.4
pcmcia-cs              3.2.7
quota-tools            3.10.
PPP                    2.4.2
isdn4k-utils           3.3
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_pcm_oss usb_storage ohci_hcd sd_mod
snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec
snd_page_alloc snd_util_mem snd_hwdep snd_mixer_oss snd soundcore
binfmt_misc vmnet vmmon parport_pc lp parport autofs4 sunrpc 8139too mii
floppy sg scsi_mod microcode reiserfs nls_utf8 nls_cp437 vfat fat dm_mod
uhci_hcd button battery asus_acpi ac ipv6 ext3 jbd
[root@pluisje root]#


[root@pluisje root]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
00:04.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
00:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) PCI0649 (rev 02)
00:0c.0 USB Controller: NEC Corporation USB (rev 41)
00:0c.1 USB Controller: NEC Corporation USB (rev 41)
00:0c.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 ND
[Radeon 9700 Pro]
01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon
9700 Pro] (Secondary)
[root@pluisje root]#



[root@pluisje root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1005.075
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1990.65
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 1005.075
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 2007.04
 
[root@pluisje root]#



[root@pluisje root]# cat /proc/interrupts
           CPU0       CPU1
  0:   31303185   31307035    IO-APIC-edge  timer
  1:      50052      50511    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:      43440      56560   IO-APIC-level  uhci_hcd, uhci_hcd
 12:     482976     487943    IO-APIC-edge  i8042
 14:     157941     151792    IO-APIC-edge  ide0
 15:     655376     657209    IO-APIC-edge  ide1
169:       3057       4793   IO-APIC-level  ohci_hcd
177:      55752      53793   IO-APIC-level  ide2, ide3, ohci_hcd
193:    1035312          7   IO-APIC-level  eth0, EMU10K1
NMI:          0          0
LOC:   62614827   62614817
ERR:          0
MIS:          0
[root@pluisje root]#


[root@pluisje root]# cat /proc/modules
snd_pcm_oss 45220 1 - Live 0x2abf9000
usb_storage 59872 0 - Live 0x2abe9000
ohci_hcd 19356 0 - Live 0x2aaf5000
sd_mod 20352 0 - Live 0x2aafb000
snd_emu10k1 77572 5 - Live 0x2ab5c000
snd_rawmidi 21792 1 snd_emu10k1, Live 0x2ab19000
snd_pcm 76420 2 snd_pcm_oss,snd_emu10k1, Live 0x2ab31000
snd_timer 22404 1 snd_pcm, Live 0x2ab12000
snd_seq_device 10120 2 snd_emu10k1,snd_rawmidi, Live 0x2aaf1000
snd_ac97_codec 54916 1 snd_emu10k1, Live 0x2ab03000
snd_page_alloc 12036 2 snd_emu10k1,snd_pcm, Live 0x2aaed000
snd_util_mem 7168 1 snd_emu10k1, Live 0x2a9b7000
snd_hwdep 10372 1 snd_emu10k1, Live 0x2aad2000
snd_mixer_oss 17792 4 snd_pcm_oss, Live 0x2aad9000
snd 43876 12
snd_pcm_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep,snd_mixer_oss, Live 0x2aae1000
soundcore 10336 5 snd, Live 0x2aab1000
binfmt_misc 11400 1 - Live 0x2a8c0000
vmnet 30352 12 - Live 0x2a9ae000
vmmon 47552 0 - Live 0x2aa9f000
parport_pc 23616 1 - Live 0x2a986000
lp 12300 0 - Live 0x2a9a9000
parport 34632 2 parport_pc,lp, Live 0x2aa95000
autofs4 15488 0 - Live 0x2a9a4000
sunrpc 110280 1 - Live 0x2aab6000
8139too 22656 0 - Live 0x2a98e000
mii 7552 1 8139too, Live 0x2a983000
floppy 52336 0 - Live 0x2a996000
sg 32288 0 - Live 0x2a8f0000
scsi_mod 97224 3 usb_storage,sd_mod,sg, Live 0x2aa7c000
microcode 10400 0 - Live 0x2a8c4000
reiserfs 195540 1 - Live 0x2a9ba000
nls_utf8 5504 4 - Live 0x2a88d000
nls_cp437 9344 4 - Live 0x2a889000
vfat 14976 4 - Live 0x2a8bb000
fat 38176 1 vfat, Live 0x2a8d3000
dm_mod 37536 0 - Live 0x2a8c8000
uhci_hcd 28188 0 - Live 0x2a893000
button 8472 0 - Live 0x2a87e000
battery 10892 0 - Live 0x2a865000
asus_acpi 12440 0 - Live 0x2a884000
ac 7308 0 - Live 0x2a869000
ipv6 214624 14 - Live 0x2a8fa000
ext3 108136 1 - Live 0x2a89f000
jbd 50328 1 ext3, Live 0x2a870000
[root@pluisje root]#

[root@pluisje root]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
8400-84ff : 0000:00:0d.0
  8400-84ff : 8139too
8800-880f : 0000:00:0b.0
  8800-8807 : ide2
  8808-880f : ide3
9000-9003 : 0000:00:0b.0
  9002-9002 : ide3
9400-9407 : 0000:00:0b.0
  9400-9407 : ide3
9800-9803 : 0000:00:0b.0
  9802-9802 : ide2
a000-a007 : 0000:00:0b.0
  a000-a007 : ide2
a400-a407 : 0000:00:09.1
a800-a81f : 0000:00:09.0
  a800-a81f : EMU10K1
b000-b01f : 0000:00:04.3
  b000-b01f : uhci_hcd
b400-b41f : 0000:00:04.2
  b400-b41f : uhci_hcd
b800-b80f : 0000:00:04.1
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e800-e80f : 0000:00:04.4
[root@pluisje root]#


[root@pluisje root]# /proc/iomem
-bash: /proc/iomem: Permission denied
[root@pluisje root]#

[root@pluisje root]# cat /proc/scsi/scsi
Attached devices:
[root@pluisje root]#

-- 
Philip Van Hoof, Software Developer @ Cronos
home: me at freax dot org
work: Philip dot VanHoof at cronos dot be
http://www.freax.be, http://www.freax.eu.org

