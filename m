Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTBCWqw>; Mon, 3 Feb 2003 17:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTBCWqw>; Mon, 3 Feb 2003 17:46:52 -0500
Received: from smtp1.libero.it ([193.70.192.51]:62892 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S267097AbTBCWqs> convert rfc822-to-8bit;
	Mon, 3 Feb 2003 17:46:48 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Darkness <darkness@hacari.org>
To: linux-kernel@vger.kernel.org
Subject: suspect bug in patch-2.4.21-pre*
Date: Mon, 3 Feb 2003 23:54:14 +0100
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302032354.14167.darkness@hacari.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
After patching the official kernel 2.4.20 with patch-2.4.21-pre2 or 
patch-2.4.21-pre3 or patch-2.4.21-pre4 I had problems with
my dvd rom (SAMSUNG DVD-ROM SD-616), I can't mount data-cd and I can't see
the dvds. Therefore I have removed the patch and all it works well.

The error was always this:
# mount /dev/scd0 /mnt/cdrom
Can't determinate the filesystem type.


I use the ide-scsi emulation and I have the Slackware 8.1 distribution.
Sorry for my English but I'm Italian :-)


System's information:

root@Slack:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1600+
stepping        : 2
cpu MHz         : 1394.086
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2785.28


root@Slack:~# cat /proc/modules
nvidia               1466912  10 (autoclean)


root@Slack:~# cat /proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d000-d01f : PCI device 1102:0002
  d000-d01f : EMU10K1
d400-d43f : PCI device 1039:7012
d800-d8ff : PCI device 1039:7012
dc00-dc07 : PCI device 1102:7002
ff00-ff0f : PCI device 1039:5513
  ff00-ff07 : ide0
  ff08-ff0f : ide1


root@Slack:~# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-002ad870 : Kernel code
  002ad871-00320707 : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
bdb00000-cdcfffff : PCI Bus #01
  c0000000-c7ffffff : PCI device 10de:0253
    c0000000-c3ffffff : vesafb
  cdc80000-cdcfffff : PCI device 10de:0253
cde00000-cfefffff : PCI Bus #01
  ce000000-ceffffff : PCI device 10de:0253
cfffe000-cfffefff : PCI device 1039:7001
  cfffe000-cfffefff : usb-ohci
cffff000-cfffffff : PCI device 1039:7001
  cffff000-cfffffff : usb-ohci
d0000000-d3ffffff : PCI device 1039:0735
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffee0000-ffefffff : reserved
fffc0000-ffffffff : reserved


root@Slack:~# lspci     
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 
PCI Audio Accelerator (rev a0)
00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
07)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] 
(rev a3)


root@Slack:~# cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: DVD-ROM SD-616   Rev: BS02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: LITE-ON  Model: LTR-24102B       Rev: 5S07
  Type:   CD-ROM                           ANSI SCSI revision: 02



Bye.

