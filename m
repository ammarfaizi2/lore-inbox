Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266044AbTLIUFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266080AbTLIUFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:05:16 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:33733 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S266044AbTLIUFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:05:06 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: ACPI Bug: 2.6.0-test11, Incomplete pci bus scan
Date: Tue, 9 Dec 2003 20:03:24 +0000
User-Agent: KMail/1.5.4
Cc: len.brown@intel.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312092003.24247.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asus PR-DLS Dual Xeon (P4) motherboard

2.6.0-test11 kernel with acpi configured.

If I boot normally, the e1000 device is not recognised.
If I boot with pci=noacpi, the e1000 is recognised ( but e100/e1000 are 
assigned opposite ethx compared to 2.4)

lspci in both cases gives these devices

00:00.0 Host bridge: ServerWorks CMIC-LE (rev 13)
00:00.1 Host bridge: ServerWorks CMIC-LE
00:00.2 Host bridge: ServerWorks: Unknown device 0000
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)

But these extra devices only appear when booting with pci=noacpi. Net access 
to a machine can also be arranged if it would help

02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller 
(LOM) (rev 02)

If I can give any further info, let me know.

As a seperate issue, with pci=noacpi, both the net interfaces are recognised, 
but in reverse order to 2.4 kernel (eth0 <=> eth1)

Andrew Walrond

