Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVBCLNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVBCLNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVBCLMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:12:55 -0500
Received: from smtp.loomes.de ([212.40.161.2]:64485 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S262768AbVBCLC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:02:59 -0500
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: mathieu.okuyama@free.fr, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87is5a0wxm.fsf@bytesex.org>
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org>
	 <1107407987.2097.18.camel@lb.loomes.de>  <87is5a0wxm.fsf@bytesex.org>
Content-Type: multipart/mixed; boundary="=-gbU7/3XZzAy7qQkGoygE"
Date: Thu, 03 Feb 2005 12:02:51 +0100
Message-Id: <1107428571.2068.4.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gbU7/3XZzAy7qQkGoygE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-02-03 at 11:17 +0100, Gerd Knorr wrote:

> > tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
> > tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
> > tuner: microtune: companycode=4d54 part=04 rev=04
> > tuner: microtune MT2032 found, OK
> > tda9885/6/7: chip found @ 0x86
> > ...
> > mt2032_set_if_freq failed with -121
> 
> Can you please load tuner.o with debug=1, tda9887.o with debug=2 and
> mail me the logs for driver load + attempt to tune some station for
> both working and non-working kernel please?

OK here you go.
Regards.
__  
Markus

--=-gbU7/3XZzAy7qQkGoygE
Content-Disposition: attachment; filename=log_not_working
Content-Type: text/plain; name=log_not_working; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

PrefPort:A  RlmtMode:Check Link State
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 17, latency: 64, mmio: 0xefe00000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=1 info="PAL / mono" radio=no
bttv0: using tuner=33
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
Losing some ticks... checking if CPU frequency changed.
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
tuner: MT2032 hexdump:
 1a 44 ff 0f 1f d7 e4 8c  c3 4e ec 8f 07 32 28 22 
  ff 4d 54 04 04
 tuner: microtune: companycode=4d54 part=04 rev=04
mt2032: xogc = 0x07
mt2032: xok = 0x00
mt2032: xogc = 0x06
mt2032: xogc = 0x06
mt2032: xok = 0x00
mt2032: xogc = 0x05
mt2032: xogc = 0x05
mt2032: xok = 0x00
mt2032: xogc = 0x04
mt2032: xogc = 0x04
mt2032: xok = 0x00
mt2032: xogc = 0x03
tuner: microtune MT2032 found, OK
tda9885/6/7: chip found @ 0x86
tda9885/6/7: Oops: no tvnorm entry found
tda9885/6/7: writing: b=0xc0 c=0x10 e=0x00
tda9885/6/7: write: byte B 0xc0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x00
  E0-1 sound carrier   : 4.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 58.75 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: Oops: no tvnorm entry found
tda9885/6/7: writing: b=0xc0 c=0x10 e=0x00
tda9885/6/7: write: byte B 0xc0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x00
  E0-1 sound carrier   : 4.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 58.75 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON DVD SOHD-167T, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: DVD SOHD-167T     Rev: 9S16
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem 0xfbd00000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xc400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xc800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xd000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 0xd400
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
w83627hf 1-0290: Reading VID from GPIO5
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
ALSA device list:
  #0: VIA 8237 with ALC850 at 0xd800, irq 22
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8 (1350 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
cpu_init done, current fid 0xc, vid 0x4
powernow-k8: ph2 null fid transition 0xc
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Adding 524280k swap on /usr/swapfile.  Priority:-1 extents:1
eth0: network connection down
eth0: network connection up using port A
    speed:           10
    autonegotiation: yes
    duplex mode:     half
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0x10 c=0x70 e=0x09
tda9885/6/7: write: byte B 0x10
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : low
  B7   output port 2   : low
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0x10 c=0x70 e=0x09
tda9885/6/7: write: byte B 0x10
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : low
  B7   output port 2   : low
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0x10 c=0x70 e=0x09
tda9885/6/7: write: byte B 0x10
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : low
  B7   output port 2   : low
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0x10 c=0x70 e=0x09
tda9885/6/7: write: byte B 0x10
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : low
  B7   output port 2   : low
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0x10 c=0x70 e=0x09
tda9885/6/7: write: byte B 0x10
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : low
  B7   output port 2   : low
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0x10 c=0x70 e=0x09
tda9885/6/7: write: byte B 0x10
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : low
  B7   output port 2   : low
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tuner: tv freq set to 251.93
mt2032_set_if_freq rfin=251937500 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=251937500 lo1=256 lo1n=32 lo1a=0 sel=4, lo1freq=1344000000
mt2032: rfin=251937500 lo2=200 lo2n=25 lo2a=0 num=2276 lo2freq=1053161000
spurcheck f1=1344000 f2=1053162  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-762324
 spurtest n1=1 n2=-3 ftest=-1815486
 spurtest n1=1 n2=-4 ftest=-2868648
 spurtest n1=1 n2=-5 ftest=-3921810
 spurtest n1=2 n2=-3 ftest=-471486
 spurtest n1=2 n2=-4 ftest=-1524648
 spurtest n1=2 n2=-5 ftest=-2577810
 spurtest n1=3 n2=-4 ftest=-180648
 spurtest n1=3 n2=-5 ftest=-1233810
 spurtest n1=4 n2=-5 ftest=110190
mt2032_set_if_freq failed with -121
mt2032 Reg.E=0x0e
mt2032 Reg.F=0x0f
mt2032_set_if_freq2 failed with -121
tuner: tv freq set to 160.93
mt2032_set_if_freq rfin=160937500 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=160937500 lo1=238 lo1n=29 lo1a=6 sel=4, lo1freq=1249500000
mt2032: rfin=160937500 lo2=199 lo2n=24 lo2a=7 num=3536 lo2freq=1049661000
spurcheck f1=1249500 f2=1049662  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-849824
 spurtest n1=1 n2=-3 ftest=-1899486
 spurtest n1=1 n2=-4 ftest=-2949148
 spurtest n1=1 n2=-5 ftest=-3998810
 spurtest n1=2 n2=-3 ftest=-649986
 spurtest n1=2 n2=-4 ftest=-1699648
 spurtest n1=2 n2=-5 ftest=-2749310
 spurtest n1=3 n2=-4 ftest=-450148
 spurtest n1=3 n2=-5 ftest=-1499810
 spurtest n1=4 n2=-5 ftest=-250310
mt2032_set_if_freq failed with -121
mt2032 Reg.E=0x0e
mt2032 Reg.F=0x0f
mt2032_set_if_freq2 failed with -121
tuner: tv freq set to 209.87
mt2032_set_if_freq rfin=209875000 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=209875000 lo1=248 lo1n=31 lo1a=0 sel=4, lo1freq=1302000000
mt2032: rfin=209875000 lo2=200 lo2n=25 lo2a=0 num=2322 lo2freq=1053225000
spurcheck f1=1302000 f2=1053225  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-804450
 spurtest n1=1 n2=-3 ftest=-1857675
 spurtest n1=1 n2=-4 ftest=-2910900
 spurtest n1=1 n2=-5 ftest=-3964125
 spurtest n1=2 n2=-3 ftest=-555675
 spurtest n1=2 n2=-4 ftest=-1608900
 spurtest n1=2 n2=-5 ftest=-2662125
 spurtest n1=3 n2=-4 ftest=-306900
 spurtest n1=3 n2=-5 ftest=-1360125
 spurtest n1=4 n2=-5 ftest=-58125
mt2032_set_if_freq failed with -121
mt2032 Reg.E=0x0e
mt2032 Reg.F=0x0f
mt2032_set_if_freq2 failed with -121
tuner: tv freq set to 160.93
mt2032_set_if_freq rfin=160937500 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=160937500 lo1=238 lo1n=29 lo1a=6 sel=4, lo1freq=1249500000
mt2032: rfin=160937500 lo2=199 lo2n=24 lo2a=7 num=3536 lo2freq=1049661000
spurcheck f1=1249500 f2=1049662  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-849824
 spurtest n1=1 n2=-3 ftest=-1899486
 spurtest n1=1 n2=-4 ftest=-2949148
 spurtest n1=1 n2=-5 ftest=-3998810
 spurtest n1=2 n2=-3 ftest=-649986
 spurtest n1=2 n2=-4 ftest=-1699648
 spurtest n1=2 n2=-5 ftest=-2749310
 spurtest n1=3 n2=-4 ftest=-450148
 spurtest n1=3 n2=-5 ftest=-1499810
 spurtest n1=4 n2=-5 ftest=-250310
mt2032_set_if_freq failed with -121
mt2032 Reg.E=0x0e
mt2032 Reg.F=0x0f
mt2032_set_if_freq2 failed with -121

--=-gbU7/3XZzAy7qQkGoygE
Content-Disposition: attachment; filename=log_working_
Content-Type: text/plain; name=log_working_; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

6>devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with large block/inode numbers, no debug enabled
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=290.00 Mhz, System=230.00 MHz
radeonfb: PLL min 20000 max 35000
radeonfb: Monitor 1 type CRT found
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 128x48
radeonfb: ATI Radeon QW  DDR SGRAM 64 MB
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 941M
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
serio: i8042 KBD port at 0x60,0x64 irq 1
parport0: PC-style at 0x3bc [PCSPP(,...)]
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 17
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
Linux video capture interface: v1.00
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 17, latency: 64, mmio: 0xefe00000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=1 info="PAL / mono" radio=no
bttv0: using tuner=33
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
Losing some ticks... checking if CPU frequency changed.
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
tuner: MT2032 hexdump:
 1a 44 20 0f 1f d7 14 05  c3 4e ec 8f 07 43 00 77 
  ff 4d 54 04 04
 tuner: microtune: companycode=4d54 part=04 rev=04
mt2032: xogc = 0x07
mt2032: xok = 0x00
mt2032: xogc = 0x06
mt2032: xogc = 0x06
mt2032: xok = 0x00
mt2032: xogc = 0x05
mt2032: xogc = 0x05
mt2032: xok = 0x00
mt2032: xogc = 0x04
mt2032: xogc = 0x04
mt2032: xok = 0x00
mt2032: xogc = 0x03
tuner: microtune MT2032 found, OK
tda9885/6/7: chip found @ 0x86
tda9885/6/7: Oops: no tvnorm entry found
tda9885/6/7: writing: b=0xc0 c=0x10 e=0x00
tda9885/6/7: write: byte B 0xc0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x00
  E0-1 sound carrier   : 4.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 58.75 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 6Y160P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LITE-ON DVD SOHD-167T, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 320173056 sectors (163928 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: LITE-ON   Model: DVD SOHD-167T     Rev: 9S16
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 21, pci mem 0xfbd00000
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0xc400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 21, io base 0xc800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.2: irq 21, io base 0xd000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#4)
uhci_hcd 0000:00:10.3: irq 21, io base 0xd400
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 3-2: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
w83627hf 1-0290: Reading VID from GPIO5
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32 2005 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.5 to 64
ALSA device list:
  #0: VIA 8237 with ALC850 at 0xd800, irq 22
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8 (1350 mV)
powernow-k8:    2 : fid 0xc (2000 MHz), vid 0x6 (1400 mV)
cpu_init done, current fid 0xc, vid 0x4
powernow-k8: ph2 null fid transition 0xc
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 148k freed
Adding 524280k swap on /usr/swapfile.  Priority:-1 extents:1
eth0: network connection down
eth0: network connection up using port A
    speed:           10
    autonegotiation: yes
    duplex mode:     half
    flowctrl:        none
    irq moderation:  disabled
    scatter-gather:  enabled
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd0 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd0 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd0 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd0 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd0 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd0 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tuner: tv freq set to 160.93
mt2032_set_if_freq rfin=160937500 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=160937500 lo1=238 lo1n=29 lo1a=6 sel=4, lo1freq=1249500000
mt2032: rfin=160937500 lo2=199 lo2n=24 lo2a=7 num=3536 lo2freq=1049661000
spurcheck f1=1249500 f2=1049662  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-849824
 spurtest n1=1 n2=-3 ftest=-1899486
 spurtest n1=1 n2=-4 ftest=-2949148
 spurtest n1=1 n2=-5 ftest=-3998810
 spurtest n1=2 n2=-3 ftest=-649986
 spurtest n1=2 n2=-4 ftest=-1699648
 spurtest n1=2 n2=-5 ftest=-2749310
 spurtest n1=3 n2=-4 ftest=-450148
 spurtest n1=3 n2=-5 ftest=-1499810
 spurtest n1=4 n2=-5 ftest=-250310
mt2032 Reg.E=0x2e
mt2032 Reg.F=0x00
tuner: tv freq set to 209.87
mt2032_set_if_freq rfin=209875000 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=209875000 lo1=248 lo1n=31 lo1a=0 sel=4, lo1freq=1302000000
mt2032: rfin=209875000 lo2=200 lo2n=25 lo2a=0 num=2322 lo2freq=1053225000
spurcheck f1=1302000 f2=1053225  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-804450
 spurtest n1=1 n2=-3 ftest=-1857675
 spurtest n1=1 n2=-4 ftest=-2910900
 spurtest n1=1 n2=-5 ftest=-3964125
 spurtest n1=2 n2=-3 ftest=-555675
 spurtest n1=2 n2=-4 ftest=-1608900
 spurtest n1=2 n2=-5 ftest=-2662125
 spurtest n1=3 n2=-4 ftest=-306900
 spurtest n1=3 n2=-5 ftest=-1360125
 spurtest n1=4 n2=-5 ftest=-58125
mt2032 Reg.E=0x3e
mt2032 Reg.F=0x00
tuner: tv freq set to 327.00
mt2032_set_if_freq rfin=327000000 if1=1090000000 if2=38900000 from=32900000 to=39900000
mt2032: rfin=327000000 lo1=270 lo1n=33 lo1a=6 sel=3, lo1freq=1417500000
mt2032: rfin=327000000 lo2=200 lo2n=25 lo2a=0 num=1152 lo2freq=1051600000
spurcheck f1=1417500 f2=1051600  from=32900 to=39900
 spurtest n1=1 n2=-2 ftest=-685700
 spurtest n1=1 n2=-3 ftest=-1737300
 spurtest n1=1 n2=-4 ftest=-2788900
 spurtest n1=1 n2=-5 ftest=-3840500
 spurtest n1=2 n2=-3 ftest=-319800
 spurtest n1=2 n2=-4 ftest=-1371400
 spurtest n1=2 n2=-5 ftest=-2423000
 spurtest n1=3 n2=-4 ftest=46100
 spurtest n1=3 n2=-5 ftest=-1005500
 spurtest n1=4 n2=-5 ftest=412000
mt2032 Reg.E=0x2e
mt2032 Reg.F=0x00

--=-gbU7/3XZzAy7qQkGoygE--

