Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSCCOEF>; Sun, 3 Mar 2002 09:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbSCCOD4>; Sun, 3 Mar 2002 09:03:56 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:53696 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S285850AbSCCODh>;
	Sun, 3 Mar 2002 09:03:37 -0500
Date: Sun, 3 Mar 2002 15:03:24 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Deadlock on insmod yenta_socket
Message-ID: <Pine.GSO.4.30.0203031453050.25123-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Today I encountered a deadlock problem. I have an ASUS L8400 notebook, and
if I try to load the yenta_socket module, the machine immediately
deadlocks (sysrq doesn't work, no ping replies).

I also tried the yenta-hack patch (which i found on andrew morton's page,
though it seems to have disappeared), but no luck.

Kernel is 2.4.18-ac2, but 2.4.18-preX (I don't remember exactly) was the
same. I never tried it before.

lspci -n output:
00:00.0 Class 0600: 8086:7190 (rev 03)
00:01.0 Class 0604: 8086:7191 (rev 03)
00:06.0 Class 0401: 125d:1988 (rev 12)
00:06.1 Class 0780: 125d:1989 (rev 12)
00:07.0 Class 0601: 8086:7110 (rev 02)
00:07.1 Class 0101: 8086:7111 (rev 01)
00:07.2 Class 0c03: 8086:7112 (rev 01)
00:07.3 Class 0680: 8086:7113 (rev 03)
00:08.0 Class 0200: 10ec:8139 (rev 10)
00:0a.0 Class 0607: 1180:0476 (rev 80)
00:0a.1 Class 0607: 1180:0476 (rev 80)
01:00.0 Class 0300: 5333:8c10 (rev 11)

lspci says:
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:06.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
00:06.1 Communication controller: ESS Technology ESS Modem (rev 12)
00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-MV (rev 11)


Could anyone please help?


Thanks,
-- 
Balazs Pozsar

