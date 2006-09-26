Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWIZUjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWIZUjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWIZUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:39:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:23887 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932282AbWIZUjh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:39:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=sBeBjfddlB4f0LhvTHASHGzwU95MpKDPKXJC/q0YpNSv5eWD1TAewDQrCDSlEklwPuuYoeuEbRmYHPJvIBprVUxM87R2Dt8owldoxxWDtrE478qNol7ofJD390PXByhCgfzt5SEFnJrxKcP1GsibvU3T8Q4sWU5FFZaCI4D12gk=
Date: Tue, 26 Sep 2006 22:38:57 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: pata_serverworks oopses in latest -git
Message-Id: <20060926223857.56b0047d.diegocg@gmail.com>
In-Reply-To: <1159300946.11049.300.camel@localhost.localdomain>
References: <20060926140016.54d532ba.diegocg@gmail.com>
	<1159275010.11049.215.camel@localhost.localdomain>
	<45194DAD.6060904@garzik.org>
	<20060926212939.69b52f0d.diegocg@gmail.com>
	<1159300946.11049.300.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 26 Sep 2006 21:02:26 +0100,
Alan Cox <alan@lxorguk.ukuu.org.uk> escribió:

> Can you send me an lspci -vxxx of your serverworks controller. That
> shouldn't be possible so I must have the table wrong.

0000:00:00.0 Host bridge: Broadcom CNB20-LE Host Bridge (rev 23)
	Flags: fast devsel
	Memory at d0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Memory at cffff000 (32-bit, non-prefetchable) [disabled] [size=4K]
00: 66 11 07 00 00 00 00 00 23 00 00 06 08 20 80 00
10: 08 00 00 d0 00 f0 ff cf 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 02 00 00 00 5d f1 60 00 00 00 00
50: 03 00 00 00 00 00 00 00 00 00 00 87 40 00 00 00
60: 00 00 00 10 00 01 04 00 32 02 00 00 00 00 00 00
70: 10 aa 2a af e3 0d ff 2f 01 20 82 00 04 00 00 00
80: 00 20 00 00 00 00 00 00 ff ff ff ff ff ff ff ff
90: 01 03 3e df 01 10 00 81 03 10 00 81 00 00 00 00
a0: 20 00 00 00 04 05 06 07 00 00 00 00 00 00 00 00
b0: 7f 00 00 00 00 00 00 00 ff 7f ff ff f7 fc ff ff
c0: e6 0f eb 0f e3 0d e5 0f ff ff ff ff 05 07 c0 fe
d0: 00 c0 fc df 00 e0 fc ef 00 00 00 00 03 00 00 00
e0: 04 00 ff 7f 00 00 00 00 07 ff 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 c0 00 00 00

0000:00:00.1 PCI bridge: Broadcom CNB20-LE Host Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe600000-fe6fffff
	Prefetchable memory behind bridge: de300000-fe3fffff
	Capabilities: [80] AGP version 2.0
00: 66 11 05 00 07 01 b0 22 01 00 04 06 08 40 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 c0 c0 a0 22
20: 60 fe 60 fe 30 de 30 fe 00 00 00 00 ff fb ff fe
30: 00 00 00 00 80 00 00 00 00 00 00 00 ff 00 0b 00
40: 00 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 02 00 20 00 01 02 00 1f 01 01 00 00 05 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: ff fb fb fc ff fb ff 05 ff fb ff fe 00 00 00 00
d0: fc fb fc fc 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: cd ff fe ff ff bf ff ff 00 00 00 00 c2 0f 00 00

0000:00:00.2 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
	Flags: medium devsel
00: 66 11 06 00 02 00 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 01 00 00 02 00 00 c4 00 00 00 20
50: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 aa 2a af e3 0d ff 0f 00 00 00 00 00 00 00 00
80: 40 00 00 00 d5 f7 fd ff fd ff df ff 00 00 00 00
90: 5c 5f 74 ff fc f7 74 fd 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: e6 0f ea 0f e3 0d e4 0f 55 ff 55 ff 0d 07 00 00
d0: 00 c0 fc df fc 75 dc ef 5c ff f4 7f 01 00 00 00
e0: ff f7 ff ff 00 00 00 00 00 00 00 00 c4 00 00 00
f0: 40 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:00.3 Host bridge: Broadcom CNB20HE Host Bridge (rev 01)
	Flags: medium devsel
00: 66 11 06 00 02 00 00 22 01 00 00 06 08 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 02 02 00 00 12 00 00 0e 00 00 00 e0
50: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 aa 2a af e3 0d ff 0f 00 00 00 00 00 00 00 00
80: 40 00 00 00 d5 f7 fd ff fd ff df ff 00 00 00 00
90: fc fd dc fd fc ff f8 77 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: eb 0f eb 0f e5 0f e5 0f d7 7f ff ff 0d 07 00 00
d0: 00 e0 fc ef fc 7f f4 f7 d8 ff dc ff 01 00 00 00
e0: 77 ff 7d fd 00 00 00 00 00 00 00 00 c6 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:04.0 Mass storage controller: Silicon Image, Inc. SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3112 SATALink Controller
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 169
	I/O ports at dff0 [size=8]
	I/O ports at dfe4 [size=4]
	I/O ports at dfa8 [size=8]
	I/O ports at dfe0 [size=4]
	I/O ports at df90 [size=16]
	Memory at feafbc00 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at fea00000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
00: 95 10 12 31 07 01 b0 02 02 00 80 01 08 40 00 00
10: f1 df 00 00 e5 df 00 00 a9 df 00 00 e1 df 00 00
20: 91 df 00 00 00 bc af fe 00 00 00 00 95 10 12 31
30: 00 00 a0 fe 60 00 00 00 00 00 00 00 0a 01 00 00
40: 02 00 00 00 5a 00 08 02 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 22 06 00 40 00 64 00 00 00 00 00 00 00 00
70: 00 00 60 00 00 70 a0 1f 00 00 00 00 00 00 00 00
80: 03 00 00 00 22 00 00 00 00 00 00 00 cf 7d b5 ff
90: 00 fc 01 0d ff ff ff 38 00 00 00 19 00 00 00 00
a0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
b0: 01 21 15 65 dd 62 dd 62 92 43 92 43 09 40 09 40
c0: 84 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:06.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Flags: bus master, medium devsel, latency 64, IRQ 177
	Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at d800 [size=64]
	Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
00: 86 80 29 12 17 01 90 02 08 00 00 02 08 40 00 00
10: 00 d0 af fe 01 d8 00 00 00 00 90 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 0c 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 08 38
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 fe
e0: 00 40 00 3a 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.0 ISA bridge: Broadcom OSB4 South Bridge (rev 50)
	Subsystem: Broadcom OSB4 South Bridge
	Flags: bus master, medium devsel, latency 0
00: 66 11 00 02 07 00 00 02 50 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 00 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: f0 33 00 00 00 00 00 00 07 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 01 00 00 00 0f c1 20 00 00 00 00 00 00 00 00 00
70: 00 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 81 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.1 IDE interface: Broadcom OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at ffa0 [size=16]
00: 66 11 11 02 05 00 00 02 00 8a 01 01 00 40 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 5d 20 5d 5d 00 20 00 00 08 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:00:0f.2 USB Controller: Broadcom OSB4/CSB5 OHCI USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Broadcom OSB4/CSB5 OHCI USB Controller
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
00: 66 11 20 02 17 01 80 02 04 10 03 0c 08 40 80 00
10: 00 f0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 66 11 20 02
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 50
40: 00 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (rev 01) (prog-if 00 [VGA])
	Subsystem: PC Partner Limited: Unknown device 0260
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 193
	Memory at f0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at c800 [size=256]
	Memory at fe6f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at fe6c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2
00: 02 10 60 59 07 01 b0 02 01 00 00 03 08 40 80 00
10: 08 00 00 f0 01 c8 00 00 00 00 6f fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 60 02
30: 00 00 6c fe 58 00 00 00 00 00 00 00 0b 01 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 60 02
50: 01 00 02 06 00 00 00 00 02 50 20 00 13 02 00 4f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 PRO] (Secondary) (rev 01)
	Subsystem: PC Partner Limited: Unknown device 0261
	Flags: bus master, 66MHz, medium devsel, latency 64
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Memory at fe6e0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
00: 02 10 40 59 07 00 b0 02 01 00 80 03 08 40 00 00
10: 08 00 00 e8 00 00 6e fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4b 17 61 02
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 06 00 00 00 00 02 50 20 00 13 02 00 4f
60: 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0000:02:02.0 Multimedia audio controller: Creative Labs SB Audigy LS
	Subsystem: Creative Labs SB0410 SBLive! 24-bit
	Flags: bus master, medium devsel, latency 64, IRQ 185
	I/O ports at ef80 [size=32]
	Capabilities: [dc] Power Management version 2
00: 02 11 07 00 05 01 90 02 00 00 01 04 00 40 00 00
10: 81 ef 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 06 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 02 14
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 82 00 00
50: 00 80 00 00 ff ff 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 22 06
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

