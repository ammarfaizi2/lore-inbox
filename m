Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270389AbTGMUK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270398AbTGMUK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:10:57 -0400
Received: from www.polycon.fi ([213.15.142.131]:23054 "EHLO www.polycon.fi")
	by vger.kernel.org with ESMTP id S270389AbTGMUKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:10:41 -0400
Date: Sun, 13 Jul 2003 23:25:27 +0300 (EEST)
From: Lasse Anderson <laa@polycon.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75 freeze when booting
Message-ID: <Pine.LNX.4.56.0307132310490.19479@www.polycon.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm a newbie, so please have some understanding, the repoty might not be
perfect. If you have more questions ask (please CC, I don't follow the
group that much)

1.
Kernel freeze when booting.

2.
I boot up the machine and see the three first rows after lilo,
"uncompressing linux" and then "booting the kernel". After that nothing
happens. The kernel configuration can be found at
http://www.polycon.fi/~laa/config-2.5.75

4.
Kernel version 2.5.75

7.1
(23:19) walthertown /usr/src/linux-2.5.75/scripts > ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux walthertown 2.4.21-xfs #1 Mon Jul 7 19:00:46 EEST 2003 i686
GNU/Linux

Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
xfsprogs               2.4.12
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         lufs mga binfmt_misc ipt_MASQUERADE ipt_ULOG
iptable_nat ip_conntrack iptable_filter ip_tables snd-seq-midi
snd-emu10k1-synth snd-emux-synth snd-seq-midi-emul snd-seq-virmidi
snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss
snd-emu10k1 snd-pcm snd-timer snd-hwdep snd-util-mem snd-page-alloc
snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore af_packet autofs4
agpgar

7.2
(23:22) walthertown ~ > cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1600+
stepping        : 2
cpu MHz         : 1401.761
cache size      : 256 KB
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
bogomips        : 2798.38

7.3
(23:22) walthertown ~ > cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller
d400-d40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d81f : VIA Technologies, Inc. USB
dc00-dc1f : VIA Technologies, Inc. USB (#2)
e000-e01f : Creative Labs SB Audigy
  e000-e01f : EMU10K1
e400-e407 : Creative Labs SB Audigy MIDI/Game port
e800-e87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  e800-e87f : 00:0f.0
ec00-ec7f : 3Com Corporation 3c905B 100BaseTX [Cyclone] (#2)
  ec00-ec7f : 00:11.0
(23:23) walthertown ~ > cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002779c8 : Kernel code
  002779c9-002bd31f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
f0000000-f3ffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller
f4000000-f5ffffff : PCI Bus #01
  f4000000-f5ffffff : Matrox Graphics, Inc. MGA G400 AGP
f6000000-f8ffffff : PCI Bus #01
  f6000000-f6003fff : Matrox Graphics, Inc. MGA G400 AGP
  f7000000-f77fffff : Matrox Graphics, Inc. MGA G400 AGP
fa000000-fa003fff : Creative Labs SB Audigy FireWire Port
fa004000-fa004fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System
Controller
fa005000-fa00507f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fa006000-fa0067ff : Creative Labs SB Audigy FireWire Port
fa007000-fa00707f : 3Com Corporation 3c905B 100BaseTX [Cyclone] (#2)
ffff0000-ffffffff : reserved

7.7
(23:24) walthertown ~ > sudo cat /etc/lilo.conf
# LILO configuration file
# Start LILO global Section
# If you want to prevent console users to boot with init=/bin/bash,
#  restrict usage of boot params by setting a passwd and using the option
#  restricted.
##password=bootpwd
##restricted
append="hdd=ide-scsi"
boot=/dev/hda
#compact       # faster, but won't work on all systems.
lba32
vga = normal    # force sane state
read-only
prompt
timeout=150

# Enable graphical boot menu:
install=/boot/boot-bmp.b
bitmap=/boot/debian-bootscreen-woody.bmp
bmp-colors=1,,0,2,,0
bmp-table=120p,173p,1,15,17
bmp-timer=254p,432p,1,0,0

map=/boot/map

# End LILO global Section
#
image = /boot/vmlinuz
  root = /dev/hdb1
  label = debian
image = /boot/vmlinuz.old
  root = /dev/hdb1
  label = debian.old
image = /boot/vmlinuz.bkup
  root = /dev/hdb1
  label = debian.bkup
image = /boot/vmlinuz-2.5.75
  root = /dev/hdb1
  label = debian.2575

other = /dev/hda1
  label = Bill2000
  table = /dev/hda

Lasse

--
Why does the [linux] kernel go through stable and then unstable forks?
Can't it always be a stable build, like with Windows?
--Metrollica
