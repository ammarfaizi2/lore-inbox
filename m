Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUHUIQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUHUIQX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268895AbUHUIQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:16:23 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:29143 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S268894AbUHUIQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:16:14 -0400
Message-ID: <412704CA.1020805@ipb.pt>
Date: Sat, 21 Aug 2004 09:16:10 +0100
From: Rui Lopes <rlopes@ipb.pt>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IrDA on the Toshiba Portege m200
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all!

Has anybody managed to get irda working on this laptop? I'm trying for 2
days without success... can someone provide me some advices or
sugestions for me to try?

The lspci output is:
- --------------------------------------------------------------------------
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
Controller (rev 21)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller
(rev 21)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller
(rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34M
[GeForce FX Go 5200] (rev a1)
0000:02:05.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B
Mini PCI Adapter (rev 04)
0000:02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB)
Ethernet Controller (rev 83)
0000:02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to
Cardbus Bridge with ZV Support (rev 33)
0000:02:0d.0 System peripheral: Toshiba America Info Systems SD TypA
Controller (rev 05)
- --------------------------------------------------------------------------

The smscinit -v command output is:
- --------------------------------------------------------------------------
smcinit 0.4

Default-Values for Portege m200:
SIR ioport: 0x3f8
FIR ioport: 0x130
FIR interupt: 3
FIR DMA: 3

Detected IO hub vendor id: 0x8086
Detected IO hub device id: 0x24cc
Detected Chip id: 0x7a

SIR ioport register      write: 0xfe     read: 0xfe
FIR interrupt register   write: 0x3      read: 0x3
FIR ioport register      write: 0x26     read: 0x26
FIR dma register         write: 0x3      read: 0x3

Initialisation of the SMC 47Nxxx succeded
- --------------------------------------------------------------------------

The lsmod is:
- --------------------------------------------------------------------------
Module                  Size  Used by
arc4                    1824  1
ieee80211_crypt_wep     5312  1
crc32                   4320  1 ieee80211_crypt_wep
ipw2100               153252  0
firmware_class         10144  1 ipw2100
ieee80211              14980  1 ipw2100
ieee80211_crypt         5444  2 ieee80211_crypt_wep,ieee80211
af_packet              22376  4
ipv6                  255488  8
ds                     18532  2
parport_pc             35008  0
lp                     11204  0
parport                41832  2 parport_pc,lp
thermal                12656  0
fan                     3980  0
button                  6296  0
ac                      4812  0
battery                 9388  0
yenta_socket           21440  0
pcmcia_core            68132  2 ds,yenta_socket
eepro100               30700  0
e100                   32608  0
mii                     5120  2 eepro100,e100
snd_intel8x0m          20264  2
snd_intel8x0           36460  2
snd_ac97_codec         70020  2 snd_intel8x0m,snd_intel8x0
snd_pcm_oss            55048  0
snd_mixer_oss          20096  3 snd_pcm_oss
snd_pcm                98756  3 snd_intel8x0m,snd_intel8x0,snd_pcm_oss
snd_timer              25668  1 snd_pcm
snd_page_alloc         11752  3 snd_intel8x0m,snd_intel8x0,snd_pcm
gameport                4704  1 snd_intel8x0
snd_mpu401_uart         7968  1 snd_intel8x0
snd_rawmidi            25184  1 snd_mpu401_uart
snd_seq_device          8200  1 snd_rawmidi
snd                    56644  14
snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,

snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore              10336  3 snd
ehci_hcd               31908  0
uhci_hcd               32880  0
usbcore               114784  4 ehci_hcd,uhci_hcd
pci_hotplug            34640  0
intel_agp              19836  1
agpgart                34152  2 intel_agp
irtty_sir               9184  0
sir_dev                19244  1 irtty_sir
irda                  197472  2 irtty_sir,sir_dev
rtc                    12760  0
pcspkr                  3592  0
capability              4520  0
commoncap               7200  1 capability
tsdev                   7328  0
mousedev               10444  1
evdev                   9568  0
cpufreq_userspace       5304  2
speedstep_centrino      7860  0
freq_table              4292  1 speedstep_centrino
processor              17264  2 thermal,speedstep_centrino
toshiba                 4568  0
toshiba_acpi            6012  0
nvidia               4821012  12
psmouse                20360  0
ide_cd                 43332  0
cdrom                  40352  1 ide_cd
ext3                  127144  2
jbd                    62264  1 ext3
mbcache                 9348  1 ext3
ide_disk               19264  4
ide_generic             1408  0
piix                   13440  1
ide_core              142808  4 ide_cd,ide_disk,ide_generic,piix
sd_mod                 21728  0
ata_piix                8004  0
libata                 41700  1 ata_piix
scsi_mod              125004  2 sd_mod,libata
unix                   28624  558
font                    8320  0
vesafb                  6656  0
cfbcopyarea             3840  1 vesafb
cfbimgblt               3040  1 vesafb
cfbfillrect             3776  1 vesafb
- --------------------------------------------------------------------------

And when trying to load the smsc-ircc2 module:
- --------------------------------------------------------------------------
FATAL: Error inserting smsc_ircc2
(/lib/modules/2.6.7-1-686/kernel/drivers/net/irda/smsc-ircc2.ko): No
such device
FATAL: Error running install command for smsc_ircc2

Even with:
- --------------------------------------------------------------------------
# modprobe smsc-ircc2 ircc_dma=3 ircc_irq=3 ircc_fir=304 ircc_sir=1016
FATAL: Error inserting smsc_ircc2
(/lib/modules/2.6.7-1-686/kernel/drivers/net/irda/smsc-ircc2.ko): No
such device
FATAL: Error running install command for smsc_ircc2
- --------------------------------------------------------------------------

Any clue?

Best regards,

/rp


- -------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
irda-users mailing list
irda-users@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/irda-users

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJwTKAhGrHSs5PNIRAsrGAKCrJTTc2Z0j0O4CCQr31I4VPuD6zQCg5SDC
fQ43gyvyW3ZjLw6NFszHJ50=
=J/Wb
-----END PGP SIGNATURE-----
