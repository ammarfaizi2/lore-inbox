Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSK1IVc>; Thu, 28 Nov 2002 03:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbSK1IVc>; Thu, 28 Nov 2002 03:21:32 -0500
Received: from proxy.firewall-by-call.de ([62.116.172.146]:61572 "EHLO
	ibis.city-map.de") by vger.kernel.org with ESMTP id <S265246AbSK1IV1>;
	Thu, 28 Nov 2002 03:21:27 -0500
Message-ID: <072801c296b8$2cb01000$6600a8c0@topconcepts.net>
From: =?iso-8859-1?Q?S=F6nke_Ruempler?= <ruempler@topconcepts.com>
To: <linux-kernel@vger.kernel.org>
Subject: reiserfs bug
Date: Thu, 28 Nov 2002 09:28:47 +0100
MIME-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0724_01C296C0.8E4E2B50"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0724_01C296C0.8E4E2B50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

kernel oops while writing through sbp2 to ieee1394 ide reiserfs-formated
device

i am NOT on the list, pls CC me!

trace:

kernel BUG at prints.c:334!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0174d69>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000024   ebx: c0259c00   ecx: cf51a000   edx: cf51bf64
esi: cc7f6c00   edi: ce2cb6c0   ebp: 00000003   esp: c12f1ea0
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 7, stackpage=c12f1000)
Stack: c024e755 c02e0120 c0259c00 c12f1ec4 d0923830 00000000 c017f13d
cc7f6c00
       c0259c00 00000000 00000014 ce2cb6c0 d093aaf4 c0131268 c023fa4d
cb66a000
       d0923000 00000013 00000010 00000004 c0182b4b cc7f6c00 d0923830
00000001
Call Trace:    [<c017f13d>] [<c0131268>] [<c023fa4d>] [<c0182b4b>]
[<c0181d40>]
  [<c0181d4e>] [<c01725d5>] [<c0133eee>] [<c01334bc>] [<c013374c>]
[<c0105000>]
  [<c0105000>] [<c0106ff6>] [<c0133670>]
Code: 0f 0b 4e 01 e2 0f 25 c0 85 f6 68 20 01 2e c0 74 0d 0f b7 46

>>EIP; c0174d69 <reiserfs_panic+29/60>   <=====
Trace; c017f13d <flush_commit_list+2bd/3b0>
Trace; c0131268 <getblk+18/40>
Trace; c023fa4d <_mmx_memcpy+4d/150>
Trace; c0182b4b <do_journal_end+7eb/af0>
Trace; c0181d40 <flush_old_commits+130/160>
Trace; c0181d4e <flush_old_commits+13e/160>
Trace; c01725d5 <reiserfs_write_super+15/20>
Trace; c0133eee <sync_supers+be/e0>
Trace; c01334bc <sync_old_buffers+c/40>
Trace; c013374c <kupdate+dc/100>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0106ff6 <kernel_thread+26/30>
Trace; c0133670 <kupdate+0/100>
Code;  c0174d69 <reiserfs_panic+29/60>
00000000 <_EIP>:
Code;  c0174d69 <reiserfs_panic+29/60>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0174d6b <reiserfs_panic+2b/60>
   2:   4e                        dec    %esi
Code;  c0174d6c <reiserfs_panic+2c/60>
   3:   01 e2                     add    %esp,%edx
Code;  c0174d6e <reiserfs_panic+2e/60>
   5:   0f 25                     (bad)
Code;  c0174d70 <reiserfs_panic+30/60>
   7:   c0 85 f6 68 20 01 2e      rolb   $0x2e,0x12068f6(%ebp)
Code;  c0174d77 <reiserfs_panic+37/60>
   e:   c0                        (bad)
Code;  c0174d78 <reiserfs_panic+38/60>
   f:   74 0d                     je     1e <_EIP+0x1e> c0174d87
<reiserfs_panic+47/60>
Code;  c0174d7a <reiserfs_panic+3a/60>
  11:   0f b7 46 00               movzwl 0x0(%esi),%eax


If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux blah 2.4.19 #1 Die Aug 13 10:01:16 CEST 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sbp2 smbfs nls_iso8859-1 isofs lp


Linux version 2.4.19 (root@blah) (gcc version 2.96 20000731 (Red Hat Linux
7.1 2.96-98)) #1 Die Aug 13 10:01:16 CEST 2002


cpuinfo:
processor : 0
vendor_id : AuthenticAMD
cpu family : 6
model : 3
model name : AMD Duron(tm) Processor
stepping : 1
cpu MHz : 706.989
cache size : 64 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36
mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips : 1409.02


modules:
sbp2                   15904   1
smbfs                  32144   1 (autoclean)
nls_iso8859-1           2832   0 (autoclean)
isofs                  17296   0 (autoclean)
lp                      5968   0 (autoclean)


ipports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0140-015f : aha152x
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
d800-d803 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
da00-da1f : AVM Audiovisuelles MKTG & Computer System GmbH B1 ISDN
  da00-da1e : b1pci-da00
dc00-dc3f : AVM Audiovisuelles MKTG & Computer System GmbH B1 ISDN
de00-deff : Macronix, Inc. [MXIC] MX987x5
  de00-deff : tulip
f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1


iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0024371c : Kernel code
  0024371d-002978bf : Kernel data
0fff0000-0fff7fff : ACPI Tables
0fff8000-0fffffff : ACPI Non-volatile Storage
e6c00000-e6cfffff : PCI Bus #01
e8000000-ebffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
eedff000-eedfffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller
eee00000-eeefffff : PCI Bus #01
ef7e8000-ef7ebfff : Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
ef7ee000-ef7eefff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
ef7ef000-ef7ef7ff : Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)
  ef7ef000-ef7ef7ff : ohci1394
ef7efec0-ef7efeff : AVM Audiovisuelles MKTG & Computer System GmbH B1 ISDN
ef7eff00-ef7effff : Macronix, Inc. [MXIC] MX987x5
  ef7eff00-ef7effff : tulip
ef800000-efffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
ffff0000-ffffffff : reserved


lspci -vvv:
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System
Controller (rev 25)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
Latency: 120
Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
Region 1: Memory at eedff000 (32-bit, prefetchable) [size=4K]
Region 2: I/O ports at d800 [disabled] [size=4]
Capabilities: [a0] AGP version 1.0
Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
Bridge (rev 01) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 120
Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
I/O behind bridge: 0000b000-0000bfff
Memory behind bridge: eee00000-eeefffff
Prefetchable memory behind bridge: e6c00000-e6cfffff
BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev
01)
Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev
07) (prog-if 8a [Master SecP PriP])
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 32
Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
(rev 06) (prog-if 10 [OHCI])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 16 (20000ns max), cache line size 08
Interrupt: pin D routed to IRQ 12
Region 0: Memory at ef7ee000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
B1 ISDN (rev 01)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (500ns min, 500ns max)
Interrupt: pin A routed to IRQ 5
Region 0: Memory at ef7efec0 (32-bit, non-prefetchable) [size=64]
Region 1: I/O ports at dc00 [size=64]
Region 2: I/O ports at da00 [size=32]

00:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
(prog-if 10 [OHCI])
Subsystem: Texas Instruments: Unknown device 8010
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (750ns min, 1000ns max), cache line size 08
Interrupt: pin A routed to IRQ 9
Region 0: Memory at ef7ef000 (32-bit, non-prefetchable) [size=2K]
Region 1: Memory at ef7e8000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [44] Power Management version 1
Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 20)
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR+ FastB2B-
Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Latency: 64 (2000ns min, 14000ns max), cache line size 08
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at de00 [size=256]
Region 1: Memory at ef7eff00 (32-bit, non-prefetchable) [size=256]
Expansion ROM at ef7d0000 [disabled] [size=64K]
Capabilities: [44] Power Management version 1
Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1+,D2-,D3hot-,D3cold+)
Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]
(prog-if 00 [VGA])
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
Interrupt: pin A routed to IRQ 12
Region 0: Memory at ef800000 (32-bit, non-prefetchable) [size=8M]
Expansion ROM at ef7f0000 [disabled] [size=64K]


have fun!

------=_NextPart_000_0724_01C296C0.8E4E2B50
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIHUzCCAxYw
ggJ/oAMCAQICDwCVwwAAAAL1w/DBKYXJ9jANBgkqhkiG9w0BAQQFADCBvDELMAkGA1UEBhMCREUx
EDAOBgNVBAgTB0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2Vu
dGVyIGZvciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0
Q2VudGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0Y2VudGVy
LmRlMB4XDTAyMTEyMTEzMTA1MloXDTAzMTEyMTEzMTA1MlowUDELMAkGA1UEBhMCREUxGDAWBgNV
BAMUD1PIb25rZSBSdWVtcGxlcjEnMCUGCSqGSIb3DQEJARYYcnVlbXBsZXJAdG9wY29uY2VwdHMu
Y29tMFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAJn8UG4EH7F3J1HPrf6xBrVtF1vUfbRH0PCaUOxq
OFhBG+1H18FDcUDGm0vpycbU9ObelPaahux6CfGuUrAGLQsCAwEAAaOByDCBxTAMBgNVHRMBAf8E
AjAAMA4GA1UdDwEB/wQEAwIF4DAzBglghkgBhvhCAQgEJhYkaHR0cDovL3d3dy50cnVzdGNlbnRl
ci5kZS9ndWlkZWxpbmVzMBEGCWCGSAGG+EIBAQQEAwIFoDBdBglghkgBhvhCAQMEUBZOaHR0cHM6
Ly93d3cudHJ1c3RjZW50ZXIuZGUvY2dpLWJpbi9jaGVjay1yZXYuY2dpLzk1QzMwMDAwMDAwMkY1
QzNGMEMxMjk4NUM5RjY/MA0GCSqGSIb3DQEBBAUAA4GBAHsoP1WVjxjVnUkaWGmQS8eUG4TS4xK+
Fmy/KUg0/cQq9pppXWYbqyRPsj/lSWI1ns5WjA+UTAN1WCv4+2rnJu6amgRiilxIV/YtiaArF8px
nbco2iRud68+oshR2X7CkzJIWh3Nc/vrXWED4dpXcvNsfk94Onq/jtRL2QosR5jjMIIENTCCA56g
AwIBAgIBAjANBgkqhkiG9w0BAQQFADCBvDELMAkGA1UEBhMCREUxEDAOBgNVBAgTB0hhbWJ1cmcx
EDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2VudGVyIGZvciBTZWN1cml0eSBp
biBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0Q2VudGVyIENsYXNzIDEgQ0Ex
KTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0Y2VudGVyLmRlMB4XDTk4MDMwOTEzNTYz
M1oXDTA1MTIzMTEzNTYzM1owgbwxCzAJBgNVBAYTAkRFMRAwDgYDVQQIEwdIYW1idXJnMRAwDgYD
VQQHEwdIYW1idXJnMTowOAYDVQQKEzFUQyBUcnVzdENlbnRlciBmb3IgU2VjdXJpdHkgaW4gRGF0
YSBOZXR3b3JrcyBHbWJIMSIwIAYDVQQLExlUQyBUcnVzdENlbnRlciBDbGFzcyAxIENBMSkwJwYJ
KoZIhvcNAQkBFhpjZXJ0aWZpY2F0ZUB0cnVzdGNlbnRlci5kZTCBnzANBgkqhkiG9w0BAQEFAAOB
jQAwgYkCgYEAsCnrtHazrte2W7Re573jsZxJBFdboavZfxMb/bphq9jncd8tAJRdUUh9I+91YoSQ
PAofWRF0L46Apf0wAj0pUs1yGkkhnLzLUo5IoWOWyBCFMGlXdEXAWobG1T3gaFd9MWokjUWXPjF+
aGYybiRt7DI2yUHK8DFEyKNhyhugNh8CAwEAAaOCAUMwggE/MEAGCWCGSAGG+EIBAwQzFjFodHRw
czovL3d3dy50cnVzdGNlbnRlci5kZS9jZ2ktYmluL2NoZWNrLXJldi5jZ2k/MEAGCWCGSAGG+EIB
BAQzFjFodHRwczovL3d3dy50cnVzdGNlbnRlci5kZS9jZ2ktYmluL2NoZWNrLXJldi5jZ2k/MDwG
CWCGSAGG+EIBBwQvFi1odHRwczovL3d3dy50cnVzdGNlbnRlci5kZS9jZ2ktYmluL1JlbmV3LmNn
aT8wPgYJYIZIAYb4QgEIBDEWL2h0dHA6Ly93d3cudHJ1c3RjZW50ZXIuZGUvZ3VpZGVsaW5lcy9p
bmRleC5odG1sMCgGCWCGSAGG+EIBDQQbFhlUQyBUcnVzdENlbnRlciBDbGFzcyAxIENBMBEGCWCG
SAGG+EIBAQQEAwIABzANBgkqhkiG9w0BAQQFAAOBgQAFQlImpAwnAUSsXCUowkRCVAi5HcU+bFlm
xLNOUKf4+JZ1oZZ16BY4oM1dbvp5pxt7HR7DALlmvlrWYg/n8nu470zgwD9Zrjm3hAmeq/GpLmtp
4q3M8up4CQUgOEJxGH7Hspfm1QIFBlajX/GqwsRP/vfvFg+d7KqFzz0pJPEEzTGCAfMwggHvAgEB
MIHQMIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFtYnVyZzEQMA4GA1UEBxMHSGFtYnVyZzE6
MDgGA1UEChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNlY3VyaXR5IGluIERhdGEgTmV0d29ya3MgR21i
SDEiMCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMSBDQTEpMCcGCSqGSIb3DQEJARYaY2Vy
dGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUCDwCVwwAAAAL1w/DBKYXJ9jAJBgUrDgMCGgUAoIG6MBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTAyMTEyODA4Mjg0N1owIwYJ
KoZIhvcNAQkEMRYEFOIssRn2rnIj8+nXFl2o7jK1L+T0MFsGCSqGSIb3DQEJDzFOMEwwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMAcGBSsOAwIdMA0GCSqGSIb3DQEBAQUABEBbp8+SK9Y1cLlCdL63DWwi7HXObuVF14vpE+fH
anGbd0YdT3PAkhMVDo9T/eGRkKzaz5N9lOFd5qK+xY5CxuR6AAAAAAAA

------=_NextPart_000_0724_01C296C0.8E4E2B50--

