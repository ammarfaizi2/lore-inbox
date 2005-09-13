Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVIMFWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVIMFWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVIMFWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 01:22:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42177 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932232AbVIMFWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 01:22:22 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: 2.6.14-rc1 breaks tg3 on ia64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Sep 2005 15:22:17 +1000
Message-ID: <22029.1126588937@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-rc1 + kdb on ia64 (SGI Altix).

tg3.c:v3.39 (September 5, 2005)
ACPI: PCI Interrupt 0001:01:04.0[A]: no GSI
BRIDGE ERR_STATUS 0x800
BRIDGE ERR_STATUS 0x800
PCI BRIDGE ERROR: int_status is 0x800 for 011c32:slab0:widget15:bus0
    Dumping relevant 011c32:slab0:widget15:bus0 registers for each bit set...
        11: PCI bus device select timeout
            PCI Error Address Register: 0x3000000316808
            PCI Error Address: 0x316808
    PIC Multiple Interrupt Register is 0x800
        11: PCI bus device select timeout

Followed by a machine check and reboot :(  2.6.13 worked fine.  Any
ideas which patch to backout this time?

