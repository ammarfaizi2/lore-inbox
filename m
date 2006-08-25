Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWHYMtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWHYMtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 08:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWHYMtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 08:49:36 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:28140 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1750791AbWHYMtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 08:49:36 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Aug 2006 14:48:58 +0200
MIME-Version: 1.0
Subject: FYI: 2.6.16-smp: DMA memory inbalance for NUMA?
Message-ID: <44EF0DDC.5186.354E7C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.06.0+V=4.06+U=2.07.138+R=05 June 2006+T=125865@20060825.124914Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my apologies if this is an issue already solved:
I have no idea what these messages exactly say, but for reasons of symmetry I 
think there's something wrong:
For a Sun Fire X4100 with two Dual_Core Operon processors, the kernel (SLES10 
kernel (x86_64, 2.6.16.21-0.15-smp)) says during boot:

<6>SRAT: PXM 0 -> APIC 0 -> Node 0
<6>SRAT: PXM 0 -> APIC 1 -> Node 0
<6>SRAT: PXM 1 -> APIC 2 -> Node 1
<6>SRAT: PXM 1 -> APIC 3 -> Node 1
<6>SRAT: Node 0 PXM 0 100000-f4000000
<6>SRAT: Node 1 PXM 1 20c000000-40c000000
<6>SRAT: Node 0 PXM 0 100000-20c000000
<6>SRAT: Node 0 PXM 0 0-20c000000

[[ Note: "Node 0" is mentioned three times, but "Node 1" is only mentioned once. 
If this is intended to be some address assignments, they look quite odd to me. 
Does the following really mean that only one node can do DMA (the other has zero 
DMA pages)? ]]

<6>ACPI: SLIT table looks invalid. Not used.
<7>NUMA: Using 26 for the hash shift.
<6>Bootmem setup node 0 0000000000000000-000000020c000000
<6>Bootmem setup node 1 000000020c000000-000000040c000000
<7>On node 0 totalpages: 2066745
<7>  DMA zone: 2993 pages, LIFO batch:0
<7>  DMA32 zone: 981032 pages, LIFO batch:31
<7>  Normal zone: 1082720 pages, LIFO batch:31
<7>  HighMem zone: 0 pages, LIFO batch:0
<7>On node 1 totalpages: 2068480
<7>  DMA zone: 0 pages, LIFO batch:0
<7>  DMA32 zone: 0 pages, LIFO batch:0
<7>  Normal zone: 2068480 pages, LIFO batch:31
<7>  HighMem zone: 0 pages, LIFO batch:0

As usual, please CC: replies to my address as I'm not subscribed here.

Regards,
Ulrich

