Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUE2Hku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUE2Hku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 03:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUE2Hku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 03:40:50 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:25008 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263798AbUE2Hkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 03:40:31 -0400
Subject: 2.6 kernel OOPs with Nomad MuVo MP3 player
From: Derek Witt <dwitt1@kc.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TQJBP85QAX/ujndkWzFz"
Message-Id: <1085816432.11120.18.camel@saiya-jin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 29 May 2004 02:40:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TQJBP85QAX/ujndkWzFz
Content-Type: multipart/mixed; boundary="=-1GUUoqYy9bJNh915KzCz"


--=-1GUUoqYy9bJNh915KzCz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Good morning.

I am attempting to mount my Creative Nomad MuVo MP3 Player. However,
every time I try to mount or copy to the drive, I constantly get a
Kernel oops. I am currently running 2.6.6-rc1 under Gentoo 1.4. SuSE 9.0
running vanilla 2.6.5  returns the same problem.

My dump indicates a problem with usb-storage trying to preempt parts of
itself.

The included dump is during a copy attempt.

I am quite puzzled by this.. I'm going to rebuild my kernel sans preempt
and see what happens.

Here's my information below.

cat /proc/bus/usb/devices (for my Nomad):

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D02 Dev#=3D  4 Spd=3D12  MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D041e ProdID=3D4106 Rev=3D 0.01
S:  Manufacturer=3DCreative Tech
S:  Product=3DNOMAD MuVo
S:  SerialNumber=3D000000000000
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D08(stor.) Sub=3D06 Prot=3D50
Driver=3Dusb-storage
E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms


cat /proc/ioports:

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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e8-03ef : serial
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-500f : 0000:00:07.4
6000-607f : 0000:00:07.4
d000-d00f : 0000:00:07.1
d400-d41f : 0000:00:07.2
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:07.3
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:0a.0
  dc00-dc1f : EMU10K1
e000-e007 : 0000:00:0a.1
e400-e4ff : 0000:00:0b.0
  e400-e4ff : 8139too

cat /proc/interrupts:

           CPU0
  0:   89597648          XT-PIC  timer
  1:      26427          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:     436611          XT-PIC  EMU10K1
  4:          0          XT-PIC  acpi
  8:          2          XT-PIC  rtc
 10:    6019061          XT-PIC  nvidia
 11:    1906902          XT-PIC  uhci_hcd, uhci_hcd, eth0
 12:     229068          XT-PIC  i8042
 14:     240778          XT-PIC  ide0
 15:         38          XT-PIC  ide1
NMI:          0
LOC:   89597802
ERR:        184
MIS:          0

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev c4)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=3D64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=3Dx1,x2
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP+ GART64- 64bit- =
FW-
Rate=3Dx2
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d000 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d400 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 16) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d800 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 4
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-




Derek J Witt,
dwitt1@kc.rr.com.


--=-1GUUoqYy9bJNh915KzCz
Content-Disposition: attachment; filename=mount-error.txt
Content-Transfer-Encoding: base64
Content-Type: text/plain; name=mount-error.txt; charset=ISO-8859-1

RkFUOiBEaXJlY3RvcnkgYnJlYWQoYmxvY2sgNDk0KSBmYWlsZWQNClVuYWJsZSB0byBoYW5kbGUg
a2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAx
NjQNCiBwcmludGluZyBlaXA6DQpjMDI3ZThiYw0KKnBkZSA9IDAwMDAwMDAwDQpPb3BzOiAwMDAw
IFsjMV0NClBSRUVNUFQNCkNQVTogICAgMA0KRUlQOiAgICAwMDYwOls8YzAyN2U4YmM+XSAgICBU
YWludGVkOiBQDQpFRkxBR1M6IDAwMjEwODAzICAgKDIuNi42LXJjMSkNCkVJUCBpcyBhdCBhc19m
aW5kX2FycV9oYXNoKzB4MmMvMHhiMA0KZWF4OiAwMDAwMDE2NCAgIGVieDogMDAwMDAwMDAgICBl
Y3g6IGNiY2Y1MmEwICAgZWR4OiAwMDAwMDAwNA0KZXNpOiBjYmNmNTJhMCAgIGVkaTogMDAwMDAx
ZWYgICBlYnA6IDAwMDAwMDAwICAgZXNwOiBkMWY5N2I1MA0KZHM6IDAwN2IgICBlczogMDA3YiAg
IHNzOiAwMDY4DQpQcm9jZXNzIGNwIChwaWQ6IDEyNzc3LCB0aHJlYWRpbmZvPWQxZjk2MDAwIHRh
c2s9Y2RiZjA1ZjApDQpTdGFjazogYzAxMTg4OGEgZDFmOTdjNjQgMDAwMDAxNjQgMDAwMDAwMDAg
Y2JjZjUyYTAgMDAwMDAxZjAgMDAwMDAwMDAgYzAyODA3MWQNCiAgICAgICBjYmNmNTJhMCAwMDAw
MDFlZiAwMDAwMDAwMCBjNDY4YWNhMCBjNDY4YWNhMCBjYmNmNTJhMCAwMDAwMDAwMCBjNTY2NDAw
MA0KICAgICAgIDAwMDAwMDAwIDAwMDAwMDAwIGMwMjc3OGE5IGM1NjY0MDAwIGQxZjk3YmQwIGM0
NjhhM2EwIGMwMjdhYzc4IGM1NjY0MDAwDQpDYWxsIFRyYWNlOg0KIFs8YzAxMTg4OGE+XSBfX3dh
a2VfdXBfY29tbW9uKzB4M2EvMHg2MA0KIFs8YzAyODA3MWQ+XSBhc19tZXJnZSsweDExZC8weDIw
MA0KIFs8YzAyNzc4YTk+XSBlbHZfbWVyZ2UrMHgyOS8weDMwDQogWzxjMDI3YWM3OD5dIF9fbWFr
ZV9yZXF1ZXN0KzB4MzY4LzB4NWMwDQogWzxjMDI3YjAzZT5dIGdlbmVyaWNfbWFrZV9yZXF1ZXN0
KzB4MTZlLzB4MWYwDQogWzxjMDExOWIzMD5dIGF1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbisweDAv
MHg1MA0KIFs8YzAyN2IxMWQ+XSBzdWJtaXRfYmlvKzB4NWQvMHgxMDANCiBbPGMwMTU2MWQwPl0g
c3VibWl0X2JoKzB4YTAvMHgyMDANCiBbPGMwMTUzZGU5Pl0gX19icmVhZF9zbG93KzB4NTkvMHhi
MA0KIFs8YzAxNTQxNmU+XSBfX2JyZWFkKzB4M2UvMHg1MA0KIFs8YzAxZTAzNTY+XSBmYXRfX2dl
dF9lbnRyeSsweGI2LzB4MTk0DQogWzxjMDFkZDNiYz5dIGZhdF9nZXRfc2hvcnRfZW50cnkrMHhh
Yy8weGIwDQogWzxjMDFkZDU4Yz5dIGZhdF9zY2FuKzB4NWMvMHg5NA0KIFs8YzAxZTFkMmI+XSB2
ZmF0X2ZpbmRfZm9ybSsweDNiLzB4NjANCiBbPGMwMWUyMTQzPl0gdmZhdF9jcmVhdGVfc2hvcnRu
YW1lKzB4M2YzLzB4NzkwDQogWzxjMDEzOGUzND5dIF9fYWxsb2NfcGFnZXMrMHhhNC8weDMyMA0K
IFs8YzAxZTI4NjA+XSB2ZmF0X2J1aWxkX3Nsb3RzKzB4MTUwLzB4MmYwDQogWzxjMDFlMmE4MD5d
IHZmYXRfYWRkX2VudHJ5KzB4ODAvMHgyODANCiBbPGMwMTY5OTNhPl0gZF9zcGxpY2VfYWxpYXMr
MHg0YS8weDExMA0KIFs8YzAxZTMwMjM+XSB2ZmF0X2NyZWF0ZSsweDYzLzB4MTgwDQogWzxjMDE2
OTY0OT5dIGRfYWxsb2MrMHgxOTkvMHgxZDANCiBbPGMwMTVmMDJmPl0gcGVybWlzc2lvbisweDJm
LzB4NTANCiBbPGMwMTYwNWI5Pl0gdmZzX2NyZWF0ZSsweDc5LzB4ZDANCiBbPGMwMTYwYmFmPl0g
b3Blbl9uYW1laSsweDNiZi8weDQxMA0KIFs8YzAxNTAzOTM+XSBmaWxwX29wZW4rMHg0My8weDcw
DQogWzxjMDE1MDg2Yj5dIHN5c19vcGVuKzB4NWIvMHg5MA0KIFs8YzAxMDYxYWI+XSBzeXNjYWxs
X2NhbGwrMHg3LzB4Yg0KDQpDb2RlOiA4YiAzMCAzOSBjNiA3NCA0MCA4ZCBiNCAyNiAwMCAwMCAw
MCAwMCA4ZCBiYyAyNyAwMCAwMCAwMCAwMA0KIDw2Pm5vdGU6IGNwWzEyNzc3XSBleGl0ZWQgd2l0
aCBwcmVlbXB0X2NvdW50IDINCmJhZDogc2NoZWR1bGluZyB3aGlsZSBhdG9taWMhDQpDYWxsIFRy
YWNlOg0KIFs8YzAzODM2ODc+XSBzY2hlZHVsZSsweDVhNy8weDViMA0KIFs8YzAxNDFhZWI+XSB6
YXBfcG1kX3JhbmdlKzB4NGIvMHg3MA0KIFs8YzAxNDFiNWI+XSB1bm1hcF9wYWdlX3JhbmdlKzB4
NGIvMHg4MA0KIFs8YzAxNDFkNmQ+XSB1bm1hcF92bWFzKzB4MWRkLzB4MjQwDQogWzxjMDE0NWQ3
MD5dIGV4aXRfbW1hcCsweDgwLzB4MWEwDQogWzxjMDExOWUzNT5dIG1tcHV0KzB4NjUvMHg5MA0K
IFs8YzAxMWUyNzc+XSBkb19leGl0KzB4MTY3LzB4M2YwDQogWzxjMDEwNzJhYz5dIGRpZSsweGZj
LzB4MTAwDQogWzxjMDExNmU4OT5dIGRvX3BhZ2VfZmF1bHQrMHgxZjkvMHg1MTkNCiBbPGMwMTE3
ZGYzPl0gdHJ5X3RvX3dha2VfdXArMHhhMy8weDE2MA0KIFs8YzAxMTdkZjM+XSB0cnlfdG9fd2Fr
ZV91cCsweGEzLzB4MTYwDQogWzxjMDEyM2ViMD5dIHJ1bl90aW1lcl9zb2Z0aXJxKzB4MTEwLzB4
MWIwDQogWzxjMDExODg4YT5dIF9fd2FrZV91cF9jb21tb24rMHgzYS8weDYwDQogWzxjMDExODkz
Mj5dIF9fd2FrZV91cF9sb2NrZWQrMHgyMi8weDMwDQogWzxjMDEwNTEwMT5dIF9fZG93bl90cnls
b2NrKzB4NTEvMHg3MA0KIFs8YzAxMzdhMzE+XSBtZW1wb29sX2FsbG9jKzB4OTEvMHgxOTANCiBb
PGMwMTE2YzkwPl0gZG9fcGFnZV9mYXVsdCsweDAvMHg1MTkNCiBbPGMwMTA2YmQ1Pl0gZXJyb3Jf
Y29kZSsweDJkLzB4MzgNCiBbPGMwMTEwMDdiPl0gbXRycl9jbG9zZSsweDFiLzB4OTANCiBbPGMw
MjdlOGJjPl0gYXNfZmluZF9hcnFfaGFzaCsweDJjLzB4YjANCiBbPGMwMTE4ODhhPl0gX193YWtl
X3VwX2NvbW1vbisweDNhLzB4NjANCiBbPGMwMjgwNzFkPl0gYXNfbWVyZ2UrMHgxMWQvMHgyMDAN
CiBbPGMwMjc3OGE5Pl0gZWx2X21lcmdlKzB4MjkvMHgzMA0KIFs8YzAyN2FjNzg+XSBfX21ha2Vf
cmVxdWVzdCsweDM2OC8weDVjMA0KIFs8YzAyN2IwM2U+XSBnZW5lcmljX21ha2VfcmVxdWVzdCsw
eDE2ZS8weDFmMA0KIFs8YzAxMTliMzA+XSBhdXRvcmVtb3ZlX3dha2VfZnVuY3Rpb24rMHgwLzB4
NTANCiBbPGMwMjdiMTFkPl0gc3VibWl0X2JpbysweDVkLzB4MTAwDQogWzxjMDE1NjFkMD5dIHN1
Ym1pdF9iaCsweGEwLzB4MjAwDQogWzxjMDE1M2RlOT5dIF9fYnJlYWRfc2xvdysweDU5LzB4YjAN
CiBbPGMwMTU0MTZlPl0gX19icmVhZCsweDNlLzB4NTANCiBbPGMwMWUwMzU2Pl0gZmF0X19nZXRf
ZW50cnkrMHhiNi8weDE5NA0KIFs8YzAxZGQzYmM+XSBmYXRfZ2V0X3Nob3J0X2VudHJ5KzB4YWMv
MHhiMA0KIFs8YzAxZGQ1OGM+XSBmYXRfc2NhbisweDVjLzB4OTQNCiBbPGMwMWUxZDJiPl0gdmZh
dF9maW5kX2Zvcm0rMHgzYi8weDYwDQogWzxjMDFlMjE0Mz5dIHZmYXRfY3JlYXRlX3Nob3J0bmFt
ZSsweDNmMy8weDc5MA0KIFs8YzAxMzhlMzQ+XSBfX2FsbG9jX3BhZ2VzKzB4YTQvMHgzMjANCiBb
PGMwMWUyODYwPl0gdmZhdF9idWlsZF9zbG90cysweDE1MC8weDJmMA0KIFs8YzAxZTJhODA+XSB2
ZmF0X2FkZF9lbnRyeSsweDgwLzB4MjgwDQogWzxjMDE2OTkzYT5dIGRfc3BsaWNlX2FsaWFzKzB4
NGEvMHgxMTANCiBbPGMwMWUzMDIzPl0gdmZhdF9jcmVhdGUrMHg2My8weDE4MA0KIFs8YzAxNjk2
NDk+XSBkX2FsbG9jKzB4MTk5LzB4MWQwDQogWzxjMDE1ZjAyZj5dIHBlcm1pc3Npb24rMHgyZi8w
eDUwDQogWzxjMDE2MDViOT5dIHZmc19jcmVhdGUrMHg3OS8weGQwDQogWzxjMDE2MGJhZj5dIG9w
ZW5fbmFtZWkrMHgzYmYvMHg0MTANCiBbPGMwMTUwMzkzPl0gZmlscF9vcGVuKzB4NDMvMHg3MA0K
IFs8YzAxNTA4NmI+XSBzeXNfb3BlbisweDViLzB4OTANCiBbPGMwMTA2MWFiPl0gc3lzY2FsbF9j
YWxsKzB4Ny8weGINCg0K

--=-1GUUoqYy9bJNh915KzCz--

--=-TQJBP85QAX/ujndkWzFz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAuD5v2lgVX+zXThwRAobwAKCPZ8+vWlRwhJ6thBSEhd/sZ2Nw5gCeK99o
j7WLitNvIouw5IkbQqOOpa8=
=bDD5
-----END PGP SIGNATURE-----

--=-TQJBP85QAX/ujndkWzFz--

