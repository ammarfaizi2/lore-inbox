Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVCLNLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVCLNLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 08:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVCLNLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 08:11:23 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:740 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261452AbVCLNLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 08:11:18 -0500
Date: Sat, 12 Mar 2005 08:11:43 -0500
To: LKML <linux-kernel@vger.kernel.org>
Subject: spin_lock error in arch/i386/kernel/time.c on APM resume
Message-ID: <20050312131143.GA31038@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On APM resume this morning on my Thinkpad X31, I got a "spin_lock is
already locked" error; see below.  This doesn't happen on every resume,
though it's happened before.  The kernel is 2.6.11 plus a bunch of
(hopefully unrelated...) NFS patches.

Any ideas?

--Bruce Fields

Mar 12 07:07:29 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Mar 12 07:07:31 puzzle kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Mar 12 07:07:31 puzzle kernel: ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 10 Dec 2004
Mar 12 07:07:31 puzzle kernel: PCI: Found IRQ 11 for device 0000:00:1f.1
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:00.2
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Mar 12 07:07:31 puzzle kernel: PCI: Found IRQ 11 for device 0000:00:1f.5
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1f.3
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1f.6
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:00.1
Mar 12 07:07:31 puzzle kernel: PCI: Setting latency timer of device 0000:00:1f.5 to 64
Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:179: spin_lock(arch/i386/kernel/time.c:c0603c28) already locked by arch/i386/kernel/time.c/309
Mar 12 07:07:31 puzzle kernel: arch/i386/kernel/time.c:316: spin_unlock(arch/i386/kernel/time.c:c0603c28) not locked
Mar 12 07:07:31 puzzle kernel: PCI: Found IRQ 11 for device 0000:01:00.0
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1d.0
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:00.0
Mar 12 07:07:31 puzzle kernel: PCI: Found IRQ 11 for device 0000:02:00.2
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1d.2
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:00:1f.1
Mar 12 07:07:31 puzzle kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Mar 12 07:07:31 puzzle kernel: PCI: Found IRQ 11 for device 0000:02:08.0
Mar 12 07:07:31 puzzle kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Mar 12 07:07:31 puzzle kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Mar 12 07:07:31 puzzle kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
