Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUDTGDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUDTGDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 02:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUDTGDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 02:03:22 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:33152 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262193AbUDTGDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 02:03:20 -0400
Date: Tue, 20 Apr 2004 15:03:51 +0900
From: Fumihiro Tersawa <terasawa@pst.fujitsu.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
Subject: [patch 0/2] memory hotplug prototype for ia64
Message-Id: <20040420145352.0FBA.TERASAWA@pst.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This set of 2 patches make Iwamoto-san's memory hotplug
prototype correspond to an IPF NUMA machines.
The patch is against linux 2.6.5 and works with 
Iwamoto-san's memory hotplug patch.

I don't have an IPF NUMA machine. So, I tested on 
Tiger4 (intel's IPF machine) with NUMA node
in emulation.


Changes from Iwamoto-san's patches are:

- Using SRAT for NUMA node.
- Structures of all nodes are initialized at boot.
  In Iwamoto-san's patch, node0 is initialized
  at boot, and after boot, all nodes except node0 are
  initialized by hot-add operation.

Patch Details:

- Patch(1/2) memory hotplug prototype for ia64
  The main patch.
- Patch(2/2) NUMA node emulation
  To emulate NUMA node on non-NUMA machines.


Remainder items:

The following items are being made.
- Support of HotAdd function.
- Correspond to ACPI's SLIT.
  So, it does not use find_next_best_node() function
  (mm/page_alloc.c) which added to linux 2.6.5.
- Support of hugetlbpage.


How to apply:

 1) First of all, apply Iwamoto-san's patches.
 2) Apply this set of patches.


Thank you,
Fumihiro Terasawa.

