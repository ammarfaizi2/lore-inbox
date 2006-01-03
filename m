Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWACVDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWACVDk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWACVDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:03:39 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:34787 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S964796AbWACVDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:03:38 -0500
Date: Tue, 3 Jan 2006 22:03:36 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: [2.6.15] reproducable hang
Message-ID: <20060103210252.GA2043@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Wed Jan  4 21:53:02 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Since 2.6.14 (I also tried 2.6.14.4 and 2.6.15), my pc crashes (hangs)
when I set eth1 into promisques mode.
The crash (no oops or panic!) does NOT crash when I run tcpdump (or any oth=
er
traffic monitor) on eth0 or eth2.
The eth1 card is a 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24).
Receiving/sending data through that card works fine.


The system is a P4 with HT enable, 2GB ram.

0 root@muur:/home/folkert# mii-tool -v
SIOCGMIIPHY on 'eth0' failed: Operation not supported
eth1: link ok
  product info: vendor 00:00:00, model 0 rev 0
  basic mode:   autonegotiation enabled
  basic status: link ok
  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
SIOCGMIIPHY on 'eth2' failed: Operation not supported

0 root@muur:/home/folkert# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3198.549
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 6403.64

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3198.549
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 6397.12

0 root@muur:/home/folkert# cat /proc/interrupts
           CPU0       CPU1
  0:      18707      16029    IO-APIC-edge  timer
  1:          8          0    IO-APIC-edge  i8042
  4:        166         89    IO-APIC-edge  serial
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 12:        101          0    IO-APIC-edge  i8042
 14:      15652      23737    IO-APIC-edge  ide0
 15:         26          0    IO-APIC-edge  ide1
 16:      47619         11   IO-APIC-level  eth0, eth1
 17:          0          0   IO-APIC-level  uhci_hcd:usb5
 18:      80118     166001   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb8, w=
cfxo
 19:         16          0   IO-APIC-level  ehci_hcd:usb2, bttv0
 20:       6105       4768   IO-APIC-level  uhci_hcd:usb3, uhci_hcd:usb6
 21:        125          0   IO-APIC-level  uhci_hcd:usb4
 22:      32391      19203   IO-APIC-level  uhci_hcd:usb7
 23:      38355      20023   IO-APIC-level  Intel ICH5
NMI:          0          0
LOC:      34682      34681
ERR:          0
MIS:         11

0 root@muur:/home/folkert# cat /proc/meminfo
MemTotal:      2075684 kB
MemFree:       1350552 kB
Buffers:         35272 kB
Cached:         273516 kB
SwapCached:          0 kB
Active:         468968 kB
Inactive:       210548 kB
HighTotal:     1178816 kB
HighFree:       529444 kB
LowTotal:       896868 kB
LowFree:        821108 kB
SwapTotal:      454600 kB
SwapFree:       454600 kB
Dirty:             472 kB
Writeback:           0 kB
Mapped:         406656 kB
Slab:            25812 kB
CommitLimit:   1492440 kB
Committed_AS:   747376 kB
PageTables:       5872 kB
VmallocTotal:   114680 kB
VmallocUsed:      5500 kB
VmallocChunk:   108948 kB

0 root@muur:/home/folkert# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0290-0297 : pnp 00:09
  0295-0296 : w83627hf
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-041f : 0000:00:1f.3
0480-04bf : 0000:00:1f.0
0680-06ff : pnp 00:09
0778-077a : parport0
0800-087f : 0000:00:1f.0
  0800-0803 : PM1a_EVT_BLK
  0804-0805 : PM1a_CNT_BLK
  0808-080b : PM_TMR
  0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-dfff : PCI Bus #02
  d400-d4ff : 0000:02:0b.0
    d400-d4fe : wcfxo
  d880-d8ff : 0000:02:09.0
  dc00-dc7f : 0000:02:03.0
  df20-df3f : 0000:02:0d.0
    df20-df3f : ne2k-pci
  df40-df5f : 0000:02:0a.0
    df40-df5f : uhci_hcd
  df80-df9f : 0000:02:0a.1
    df80-df9f : uhci_hcd
e800-e8ff : 0000:00:1f.5
  e800-e8ff : Intel ICH5
ee80-eebf : 0000:00:1f.5
  ee80-eebf : Intel ICH5
eec0-eedf : 0000:00:1d.0
  eec0-eedf : uhci_hcd
ef00-ef1f : 0000:00:1d.1
  ef00-ef1f : uhci_hcd
ef20-ef3f : 0000:00:1d.2
  ef20-ef3f : uhci_hcd
ef80-ef9f : 0000:00:1d.3
  ef80-ef9f : uhci_hcd
fc00-fc0f : 0000:00:1f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1


0 root@muur:/home/folkert# cat /proc/iomem
00000000-0009fbff : System RAM
  00000000-00000000 : Crash kernel
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000f0000-000fffff : System ROM
00100000-7ff2ffff : System RAM
  00100000-002c9c24 : Kernel code
  002c9c25-003811df : Kernel data
7ff30000-7ff3ffff : ACPI Tables
7ff40000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
88000000-880003ff : 0000:00:1f.1
e0000000-efffffff : 0000:00:00.0
f6700000-fe6fffff : PCI Bus #01
  f8000000-fbffffff : 0000:01:00.0
fe700000-fe7fffff : PCI Bus #02
  fe700000-fe71ffff : 0000:02:09.0
  fe7fe000-fe7fefff : 0000:02:0c.0
    fe7fe000-fe7fefff : bttv0
  fe7ff000-fe7fffff : 0000:02:0c.1
fe900000-fe9fffff : PCI Bus #01
  fe9c0000-fe9dffff : 0000:01:00.0
  fe9fc000-fe9fffff : 0000:01:00.0
fea00000-feafffff : PCI Bus #02
  feafe000-feafefff : 0000:02:0b.0
  feaff000-feaff0ff : 0000:02:0a.2
    feaff000-feaff0ff : ehci_hcd
  feaff400-feaff47f : 0000:02:09.0
  feaff800-feafffff : 0000:02:03.0
febfb400-febfb4ff : 0000:00:1f.5
  febfb400-febfb4ff : Intel ICH5
febfb800-febfb9ff : 0000:00:1f.5
  febfb800-febfb9ff : Intel ICH5
febfbc00-febfbfff : 0000:00:1d.7
  febfbc00-febfbfff : ehci_hcd
ffb80000-ffffffff : reserved


0 root@muur:/home/folkert# lsmod
Module                  Size  Used by
tuner                  42276  0
tvaudio                21788  0
bttv                  154640  0
video_buf              17284  1 bttv
firmware_class          7936  1 bttv
i2c_algo_bit            8712  1 bttv
btcx_risc               4360  1 bttv
tveeprom               13840  1 bttv
wcfxo                  11296  0
zaptel                221444  7 wcfxo
pl2303                 18564  1
usbserial              26088  3 pl2303
nfs                   197832  3
usbnet                 13064  0
w83627hf               22032  0
hwmon_vid               2432  1 w83627hf
eeprom                  5648  0
snd_pcm_oss            44320  1
i2c_isa                 3840  1 w83627hf
snd_mixer_oss          15488  1 snd_pcm_oss
i2c_core               16640  8 tuner,tvaudio,bttv,i2c_algo_bit,tveeprom,w8=
3627hf,eeprom,i2c_isa
snd_intel8x0           27036  1
snd_ac97_codec         83872  1 snd_intel8x0
snd_pcm                74628  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              19716  1 snd_pcm
snd                    42980  6 snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_=
ac97_codec,snd_pcm,snd_timer
soundcore               7520  2 snd
snd_page_alloc          8456  2 snd_intel8x0,snd_pcm
snd_ac97_bus            2176  1 snd_ac97_codec
police                  8160  0
sch_ingress             2944  1
cls_u32                 7300  8
sch_sfq                 5248  3
sch_cbq                14336  1
ipt_limit               2432  4
ipt_state               1920  2
ipt_REJECT              4608  140
ipt_MASQUERADE          3072  1
ipt_TOS                 2432  4
iptable_mangle          2560  1
iptable_filter          2688  1
ip6table_filter         2560  1
ip6_tables             20608  1 ip6table_filter
bsd_comp                5504  0
ide_cd                 36740  0
cdrom                  35872  1 ide_cd
parport_pc             30916  0
parport                30664  1 parport_pc
microcode               6352  0
netconsole              2976  0
nfsd                  208132  8
exportfs                4864  1 nfsd
lockd                  58504  3 nfs,nfsd
sunrpc                130620  4 nfs,nfsd,lockd
ipv6                  231776  22
rtl8150                10624  0
3c59x                  39848  0
mii                     4736  1 3c59x
iptable_nat             6788  1
ip_nat                 16428  2 ipt_MASQUERADE,iptable_nat
ip_tables              19072  8 ipt_limit,ipt_state,ipt_REJECT,ipt_MASQUERA=
DE,ipt_TOS,iptable_mangle,iptable_filter,iptable_nat
ip_conntrack           45912  4 ipt_state,ipt_MASQUERADE,iptable_nat,ip_nat
nfnetlink               5272  2 ip_nat,ip_conntrack
ppp_deflate             4992  0
zlib_deflate           20504  1 ppp_deflate
zlib_inflate           16640  1 ppp_deflate
ppp_async               9216  1
crc_ccitt               2176  2 zaptel,ppp_async
ppp_generic            23828  7 bsd_comp,ppp_deflate,ppp_async
slip                   11104  3
slhc                    6144  2 ppp_generic,slip
genrtc                  5260  0
rd                      5440  1


t@muur:/home/folkert# lspci
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (re=
v 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (re=
v 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (re=
v 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (re=
v 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Contr=
oller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI Br=
idge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 St=
orage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC=
'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra =
TF
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Control=
ler (rev 80)
02:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (r=
ev 24)
02:0a.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 50)
02:0a.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] =
(rev 50)
02:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
02:0b.0 Communication controller: Individual Computers - Jens Schoenfeld In=
tel 537
02:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capt=
ure (rev 11)
02:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (r=
ev 11)
02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)


=2Econfig can be found here:
http://keetweej.vanheusden.com/~folkert/config


Folkert van Heusden

--=20
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkO65nw8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuUIUAn04fIHRj
pcaNkKGFyxjcq83/SsWNAJsF6JvFHWBr5fT24aH9kE6JsfDahQ==
=JqtP
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
