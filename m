Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUK0D0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUK0D0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbUKZTeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:34:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262405AbUKZTWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:22:40 -0500
Message-ID: <41A6895A.1000304@treshna.com>
Date: Fri, 26 Nov 2004 14:39:38 +1300
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with USB drive causing kernel hang
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with kernel hangs, there are no kernel messages about 
the problem. I am using western digital 160GB USB external harddrives. 
These normally work fine, and are used for backup purposes. The problem 
is that they stop working after you've done a backup and the kernel 
hangs if you try and access them again. I've replaced the drives serval 
times and it doesnt make any difference. I havn't yet tried installing a 
different USB controller but will try that when i can next take down the 
server for a while.

Problems shown:
If usb drive plugged in while computer booting, hot plug causes kernel hang.
After doing backup to /dev/sda (usb device) no longer exists.
Restarting hot plug while a device is plugged in or after a reboot 
causes kernel hang.
Server needs rebooting after each backup to allow access to /dev/sda again.
Removing hotplug makes no difference, problems still exist.

I dont know where to go from here, and i dont think i have given enough 
information in order to fix the problem. But if anyone has any words of 
advice it will help in solving this problem.



debian:/etc# uname -a
Linux debian 2.6.8-1-686 #1 Thu Oct 7 03:15:25 EDT 2004 i686 GNU/Linux

debian:/proc/bus/usb# cat devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8-1-686 ehci_hcd
S:  Product=Intel Corp. 82801DB (ICH4) USB2 EHCI Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8-1-686 uhci_hcd
S:  Product=Intel Corp. 82801DB (ICH4) USB UHCI #3
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8-1-686 uhci_hcd
S:  Product=Intel Corp. 82801DB (ICH4) USB UHCI #2
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.8-1-686 uhci_hcd
S:  Product=Intel Corp. 82801DB (ICH4) USB UHCI #1
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

debian:/etc# lsmod
Module                  Size  Used by
nls_iso8859_1           4032  0
nls_cp437               5696  0
vfat                   14656  0
fat                    46784  1 vfat
ide_cd                 42656  0
isofs                  37240  0
usb_storage            68832  0
sd_mod                 21696  0
sg                     39168  0
sr_mod                 17316  0
scsi_mod              125196  4 usb_storage,sd_mod,sg,sr_mod
cdrom                  40732  2 ide_cd,sr_mod
lp                     11176  0
ppp_generic            30164  0
slhc                    7488  1 ppp_generic
deflate                 3776  0
zlib_deflate           22776  1 deflate
twofish                38688  0
serpent                13632  0
aes_i586               39188  0
blowfish                9984  0
des                    11712  0
sha256                  9664  0
sha1                    8576  0
crypto_null             2304  0
xfrm_user              16196  0
ipcomp                  6688  0
esp4                    8576  0
ah4                     6784  0
af_key                 34032  0
ipv6                  264612  21
8139cp                 20672  0
snd_intel8x0           36460  0
snd_ac97_codec         70020  1 snd_intel8x0
snd_pcm                98728  1 snd_intel8x0
snd_timer              25668  1 snd_pcm
snd_page_alloc         11752  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         7968  1 snd_intel8x0
snd_rawmidi            25156  1 snd_mpu401_uart
snd_seq_device          8200  1 snd_rawmidi
snd                    57156  7 
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
i810_audio             37588  0
ac97_codec             18956  1 i810_audio
soundcore              10336  2 snd,i810_audio
ehci_hcd               32004  0
uhci_hcd               33136  0
usbcore               119012  5 usb_storage,ehci_hcd,uhci_hcd
shpchp                101996  0
pciehp                 99084  0
pci_hotplug            34640  2 shpchp,pciehp
intel_agp              22816  1
agpgart                34696  1 intel_agp
analog                 11968  0
gameport                4704  2 snd_intel8x0,analog
parport_pc             35392  1
parport                41832  2 lp,parport_pc
floppy                 61200  0
pcspkr                  3592  0
evdev                   9600  0
ip_nat_ftp              5008  0
ip_conntrack_ftp       72272  1 ip_nat_ftp
ip_nat_irc              4336  0
ip_conntrack_irc       71440  1 ip_nat_irc
ipt_REJECT              7008  4
ipt_LOG                 6560  18
ipt_limit               2528  20
ipt_state               2080  85
iptable_nat            25228  3 ip_nat_ftp,ip_nat_irc
iptable_filter          2880  1
ip_conntrack           35368  6 
ip_nat_ftp,ip_conntrack_ftp,ip_nat_irc,ip_conntrack_irc,ipt_state,iptable_nat
ip_tables              18464  6 
ipt_REJECT,ipt_LOG,ipt_limit,ipt_state,iptable_nat,iptable_filter
raid0                   8288  1
raid1                  17856  4
md                     49864  7 raid0,raid1
capability              4520  0
commoncap               7232  1 capability
8139too                26112  0
mii                     5120  2 8139cp,8139too
crc32                   4320  2 8139cp,8139too
af_packet              22600  4
rtc                    12760  0
xfs                   609688  5
ext2                   71848  0
ext3                  127240  0
jbd                    62616  1 ext3
mbcache                 9348  2 ext2,ext3
reiserfs              247760  1
ide_generic             1408  0
piix                   13440  1
ide_disk               19296  18
cmd64x                 12764  2
ide_core              139940  6 
ide_cd,usb_storage,ide_generic,piix,ide_disk,cmd64x
unix                   28692  170
font                    8320  0
vesafb                  6656  0
cfbcopyarea             3840  1 vesafb
cfbimgblt               3040  1 vesafb
cfbfillrect             3776  1 vesafb

debian:/etc# lspci -v
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 11)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [a104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e40fffff
        Prefetchable memory behind bridge: d0000000-dfffffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at d000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at d400 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 
[EHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, medium devsel, latency 0, IRQ 193
        Memory at e4200000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 81) 
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00008000-0000bfff
        Memory behind bridge: e4100000-e41fffff

00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller 
(rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: medium devsel, IRQ 201
        I/O ports at 0500 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Flags: bus master, medium devsel, latency 0, IRQ 201
        I/O ports at e000 [size=256]
        I/O ports at e400 [size=64]
        Memory at e4201000 (32-bit, non-prefetchable) [size=512]
        Memory at e4202000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS315PRO PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] SiS315PRO PCI/AGP 
VGA Display Adapter
        Flags: bus master, 66Mhz, medium devsel, latency 39, IRQ 169
        BIST result: 00
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Memory at e4000000 (32-bit, non-prefetchable) [size=256K]
        I/O ports at c000 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] AGP version 2.0

02:00.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc PCI0649
        Flags: bus master, medium devsel, latency 64, IRQ 169
        I/O ports at 8000 [size=8]
        I/O ports at 8400 [size=4]
        I/O ports at 8800 [size=8]
        I/O ports at 8c00 [size=4]
        I/O ports at 9000 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

02:01.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc PCI0649
        Flags: bus master, medium devsel, latency 64, IRQ 201
        I/O ports at 9400 [size=8]
        I/O ports at 9800 [size=4]
        I/O ports at 9c00 [size=8]
        I/O ports at a000 [size=4]
        I/O ports at a400 [size=16]
        Expansion ROM at <unassigned> [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

02:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Edimax Computer Co.: Unknown device 9503
        Flags: bus master, medium devsel, latency 32, IRQ 185
        I/O ports at a800 [size=256]
        Memory at 20000400 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

02:03.0 Communication controller: Lucent Microelectronics 56k WinModem 
(rev 01)
        Subsystem: Lucent Microelectronics LT WinModem 56k 
Data+Fax+Voice+Dsvd
        Flags: bus master, medium devsel, latency 0, IRQ 209
        Memory at 20000500 (32-bit, non-prefetchable) [size=256]
        I/O ports at ac00 [size=8]
        I/O ports at b000 [size=256]
        Capabilities: [f8] Power Management version 2

02:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 217
        I/O ports at b400 [size=256]
        Memory at 20000600 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

debian:/etc#



