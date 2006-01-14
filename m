Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWANTXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWANTXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWANTXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:23:55 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:2788 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S1750832AbWANTXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:23:55 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: lm-sensors@lm-sensors.org
Subject: 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Sat, 14 Jan 2006 22:23:32 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601142223.35838.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Vanilla 2.6.15 on Toshiba Portege 4000. I get constant messages in dmesg:

i2c_adapter i2c-0: Error: command never completed
lm90 0-004c: Register 0x1 read failed (-1)
i2c_adapter i2c-0: Error: command never completed
lm90 0-004c: Register 0x14 read failed (-1)
i2c_adapter i2c-0: Error: command never completed
lm90 0-004c: Register 0x8 read failed (-1)
i2c_adapter i2c-0: Error: command never completed
lm90 0-004c: Register 0x0 read failed (-1)

for quite a number of registers. Apparently I can read sensors just fine still 
I am uneasy seeing those.

{pts/1}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82)
{pts/1}% sensors
eeprom-i2c-0-50
Adapter: SMBus ALI1535 adapter at ef00
Memory type:            SDR SDRAM DIMM
Memory size (MB):       256

adm1032-i2c-0-4c
Adapter: SMBus ALI1535 adapter at ef00
M/B Temp:    +43°C  (low  =   -65°C, high =  +127°C)
CPU Temp:  +47.6°C  (low  = +43.0°C, high = +51.0°C)   ALARM
M/B Crit:   +127°C  (hyst =  +122°C)
CPU Crit:   +100°C  (hyst =   +95°C)


- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyU+3R6LMutpd94wRAhIpAJ9jAaVmEx6v3FF5f7pDvmD/Xu7GnQCeO/5O
RSvVH1lgezCRTdrAQdLD0js=
=i2dt
-----END PGP SIGNATURE-----
