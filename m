Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSCELAk>; Tue, 5 Mar 2002 06:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293275AbSCELAb>; Tue, 5 Mar 2002 06:00:31 -0500
Received: from p3EE3AB80.dip.t-dialin.net ([62.227.171.128]:2320 "EHLO
	salem.getuid.de") by vger.kernel.org with ESMTP id <S292857AbSCELAR>;
	Tue, 5 Mar 2002 06:00:17 -0500
Date: Tue, 5 Mar 2002 10:09:43 +0100
From: Christian Kurz <shorty@getuid.de>
To: linux-kernel@vger.kernel.org
Subject: Unknown bridge resource in dmesg
Message-ID: <20020305090943.GD12124@salem.getuid.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Organization: True happiness will be found only in true love.
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after just having updates to 2.4.19-pre2, I inspected the dmesg output
and noticed that it contains this one:

|PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
|PCI: Using configuration type 1
|PCI: Probing PCI hardware
|Unknown bridge resource 0: assuming transparent

Here's the output of lspci -v:

|00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
|	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
|	Flags: bus master, slow devsel, latency 64
|	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
|	Capabilities: <available only to root>

|00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 [Normal decode])
|	Flags: bus master, slow devsel, latency 64
|	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
|	Memory behind bridge: df000000-dfffffff
|	Prefetchable memory behind bridge: e5f00000-e7ffffff

|00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
|	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
|	Flags: medium devsel

|00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
|	Flags: bus master, medium devsel, latency 0

|00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
|	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
|	Flags: bus master, medium devsel, latency 32, IRQ 9
|	I/O ports at d800 [size=256]
|	Memory at de000000 (32-bit, non-prefetchable) [size=256]
|	Capabilities: <available only to root>

|00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c875 (rev 04)
|	Flags: bus master, medium devsel, latency 144, IRQ 14
|	I/O ports at d400 [size=256]
|	Memory at dd800000 (32-bit, non-prefetchable) [size=256]
|	Memory at dd000000 (32-bit, non-prefetchable) [size=4K]
|	Expansion ROM at <unassigned> [disabled] [size=64K]

|00:0b.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
|	Subsystem: Elsa AG QuickStep 1000
|	Flags: medium devsel, IRQ 15
|	Memory at dc800000 (32-bit, non-prefetchable) [size=128]
|	I/O ports at d000 [size=128]
|	I/O ports at b800 [size=4]

|00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
|	Flags: medium devsel
|	I/O ports at 01f0 [disabled] [size=16]
|	I/O ports at 03f4 [disabled]
|	I/O ports at 0170 [disabled] [size=16]
|	I/O ports at 0374 [disabled]
|	I/O ports at b400 [disabled] [size=16]

|01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 05) (prog-if 00 [VGA])
|	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
|	Flags: bus master, medium devsel, latency 64, IRQ 11
|	Memory at e6000000 (32-bit, prefetchable) [size=32M]
|	Memory at df800000 (32-bit, non-prefetchable) [size=16K]
|	Memory at df000000 (32-bit, non-prefetchable) [size=8M]
|	Expansion ROM at e5ff0000 [disabled] [size=64K]
|	Capabilities: <available only to root>

If someone needs more info, please tell me which information you need
and i'll try to provide it. Thanks.

Christian
-- 
What is irritating about love is that it is a crime that requires an accomplice.
                -- Charles Baudelaire
