Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUJaAIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUJaAIz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUJaAIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:08:55 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:27598 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S261439AbUJaAHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:07:46 -0400
Date: Sun, 31 Oct 2004 02:07:38 +0200
Message-Id: <1137352821@web.de>
MIME-Version: 1.0
From: "Michael Thonke" <TK-SHOCKWAVE@web.de>
To: linux-kernel@vger.kernel.org
Subject: NForce3 SATA badness with remove/add devices 
Organization: http://freemail.web.de/
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="---SKER1099181261--";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is MIME

-----SKER1099181261--
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hello Jeff or someone who read this,


its my 3 attemp (LKML Post 0410.2/0129l) to get a answer to following thing.
First of all I'm using a NForce 3 250GB (MSI K8N Neo2 Platinum)
With 3 SATA disks
Maxtor  6B200M/NCQ 
2xSamsung SP1213C

My Problem is when the kernel starts with libsata and sata_nv compiled in
when I boot the System with libsata and sata_nv it removes the first disk (Maxtor 6B200B)
then a abnormal timeout occur while adding the device: this message appears
error is "ATA: abnormal status 0x0D on port 0x9E7" and "ata is to slow to answer"
now the corious thing on that is if I wait 40 or 50 sec maybe it work or maybe not..
when I'm using the old "CONFIG_BLK_DEV_IDE_SATA:"
everything works great here. I dont know whats wrong but i tested it on 5 Motherboard 
there the Maxtor working without hicks (VIA KT880Pro,i875P,i925,SIS755,Promise 378 SATA TX2,
but when I plug it on a NForce 3 250GB (MSI K8N Neo2 or Gigabyte K8NSNXP or even new MSI K8N Neo2) 
the same timeout occur..the Maxtor 6B200M is SATA2 but full SATA compatible. 
I thought it is because of hotplug support but disabling all this stuff did not work.
I hope someone know why this happen and how to fix this.

Thanks for help

here are the lspci -v output

0000:00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev a1)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [44] #08 [01c0]
        Capabilities: [c0] AGP version 3.0

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 00e0 (rev a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66Mhz, fast devsel, latency 0

0000:00:01.1 SMBus: nVidia Corporation nForce 250Gb PCI System Management (rev a1)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: 66Mhz, fast devsel, IRQ 177
        I/O ports at ec00
        I/O ports at 4c00 [size=64]
        I/O ports at 4c40 [size=64]
        Capabilities: [44] Power Management version 2

0000:00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 177
        Memory at ec000000 (32-bit, non-prefetchable)
        I/O ports at a800 [size=8]
        Capabilities: [44] Power Management version 2

0000:00:08.0 IDE interface: nVidia Corporation CK8S Parallel ATA Controller (v2.5) (rev a2) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66Mhz, fast devsel, latency 0
        I/O ports at f000 [size=16]
        Capabilities: [44] Power Management version 2

0000:00:09.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 193
        I/O ports at 09e0
        I/O ports at 0be0 [size=4]
        I/O ports at 0960 [size=8]
        I/O ports at 0b60 [size=4]
        I/O ports at cc00 [size=16]
        I/O ports at d000 [size=128]
        Capabilities: [44] Power Management version 2

0000:00:0a.0 IDE interface: nVidia Corporation CK8S Serial ATA Controller (v2.5) (rev a2) (prog-if 85 [Master SecO PriO])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 0250
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 201
        I/O ports at 09f0
        I/O ports at 0bf0 [size=4]
        I/O ports at 0970 [size=8]
        I/O ports at 0b70 [size=4]
        I/O ports at e400 [size=16]
        I/O ports at e800 [size=128]
        Capabilities: [44] Power Management version 2

0000:00:0b.0 PCI bridge: nVidia Corporation nForce3 250Gb AGP Host to PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 16
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: e0000000-e7ffffff

0000:00:0e.0 PCI bridge: nVidia Corporation nForce3 250Gb PCI-to-PCI Bridge (rev a2) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: ea000000-ebffffff
        Expansion ROM at 00009000 [disabled] [size=4K]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel

0000:01:00.0 VGA compatible controller: nVidia Corporation NV35 [GeForce FX 5900XT] (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2975
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 209
        Memory at e8000000 (32-bit, non-prefetchable)
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

0000:02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 025c
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 209
        I/O ports at 9000
        Memory at eb000000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [dc] Power Management version 2


________________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193
-----SKER1099181261--
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIFnAYJKoZIhvcNAQcCoIIFjTCCBYkCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCA/gwggP0MIIC3KADAgECAgQCWmg9MA0GCSqGSIb3DQEBBAUAMIGgMQsw
CQYDVQQGEwJERTESMBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBD
ZW50ZXIxGjAYBgNVBAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIu
REUgVHJ1c3RDZW50ZXIgRU1haWwtWmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEW
DHRydXN0QHdlYi5kZTAeFw0wNDAzMjUyMDA4MTdaFw0wNTAzMjUyMDA4MTdaMHgx
CzAJBgNVBAYTAkRFMRQwEgYDVQQIEwtEZXV0c2NobGFuZDEWMBQGA1UEBxMNMzc1
NzQgRWluYmVjazEXMBUGA1UEAxMOTWljaGFlbCBUaG9ua2UxIjAgBgkqhkiG9w0B
CQEWE3RrLXNob2Nrd2F2ZUB3ZWIuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBAMg4IXsINDZoD1rOvKsOxlh5+HOv+TwvVRclmVermVUViuP4JBJIXhk3G+6n
/Zo9gCG0McI/oOxWNCDTQ++b6Nl0orJKhTj18CE1aa2wSdAupw8lwnpIPiP3yyhL
A8567M33Y+sMD1RiO25ayqRX+qekYgDZ75Zut1VDurkEyFYZAgMBAAGjgeAwgd0w
LAYJYIZIAYb4QgEEBB8WHWh0dHBzOi8vdHJ1c3Qud2ViLmRlL3J2Q0EvP3M9MCMG
CWCGSAGG+EIBAgQWFhRodHRwczovL3RydXN0LndlYi5kZTAWBglghkgBhvhCAQME
CRYHL3J2Lz9zPTAWBglghkgBhvhCAQcECRYHL3JuLz9zPTAaBglghkgBhvhCAQgE
DRYLL0hpbGZlL0FHQi8wKQYJYIZIAYb4QgENBBwWGkZyZWVtYWlsIEVtYWlsIGNl
cnRpZmljYXRlMBEGCWCGSAGG+EIBAQQEAwIAsDANBgkqhkiG9w0BAQQFAAOCAQEA
qKB0cBp4MDMrBWKqEZ+xHq406LxR5tJxkDIHpIJ1PFVreFeO0HjN+MWLgW+XS/BJ
se07Db39h6egmAALvcrDZnJVs93ynAkBZCNU3zxACgViPGTO1ajxXqaLte0FbOfV
EOJH3f9BX931HqbbngXMd7PXhhUo9yUR5/knus4QYbMkBRPjb/Mb1XL++doqM9qg
Mh8goWSZfXwH0OZhVGqS4zjtkZpGR9Okg8wontgnuaCJeW0j8Tu5hNeHxg0NYe1f
hvH6mmx/HNhfufsZjMM/y9XKias0/Gincc/JLUYs5r9U+B4xbMShQT3FIpukN/5b
PcDcX74ocMSqgzQBKCdZvzGCAWwwggFoAgEBMIGpMIGgMQswCQYDVQQGEwJERTES
MBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBDZW50ZXIxGjAYBgNV
BAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIuREUgVHJ1c3RDZW50
ZXIgRU1haWwtWmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEWDHRydXN0QHdlYi5k
ZQIEAlpoPTAJBgUrDgMCGgUAMA0GCSqGSIb3DQEBAQUABIGAipwKhZ4kdoTZkcwr
RcjnwzITNHCgG8S8KuHVEATmwrAj8R0OiAxA8LPL3wqcdFx5f36033/9gKQrTDwd
6XQib0TWDtSDYLSk7wFDq1F9+8mUlTVhprcMv5G5euN9A62WwWHKyUQgYmtWYh7o
aLN7EQPe1M00qZ4vZyC5PSyhLO2hGjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
-----SKER1099181261----

