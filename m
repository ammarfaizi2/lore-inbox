Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271319AbTHCVxW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271333AbTHCVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:53:21 -0400
Received: from mail1.scram.de ([195.226.127.111]:23303 "EHLO mail1.scram.de")
	by vger.kernel.org with ESMTP id S271319AbTHCVxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:53:16 -0400
Date: Sun, 3 Aug 2003 23:52:29 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       <dahinds@users.sourceforge.net>
Subject: Re: PCI1410 Interrupt Problems
In-Reply-To: <20030803222314.C15221@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308032347580.25885-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: ---- Start SpamAssassin results
  -0.10 points, 5 required;
  * -0.5 -- Has a In-Reply-To header
  *  0.0 -- Message-Id indicates a non-spam MUA (Pine)
  * -0.5 -- BODY: Contains what looks like a quoted email text
  *  0.9 -- RBL: Received via a relay in dnsbl.njabl.org
  [RBL check: found 174.124.226.217.dnsbl.njabl.org., type: 127.0.0.3]
  ---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> Can you provide the kernel messages without the hack applied please?

The kernel messages don't differ if the hack is applied or not. The hack
simply configures the PCI1410 to use a particular pin for INTA output.
Without the hack, the counter for IRQ9 in /proc/interrupt simply stays at 0.

Aug  3 14:51:02 rt1-sp kernel: Linux Kernel Card Services 3.1.22
Aug  3 14:51:02 rt1-sp kernel:   options:  [pci] [cardbus] [pm]
Aug  3 14:51:02 rt1-sp kernel: PCI: Enabling device 02:0a.0 (0000 -> 0002)
Aug  3 14:51:02 rt1-sp kernel: PCI: Found IRQ 9 for device 02:0a.0
Aug  3 14:51:02 rt1-sp kernel: Yenta IRQ list 0000, PCI irq9
Aug  3 14:51:02 rt1-sp kernel: Socket status: 30000010
Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0800-0x08ff: clean.
Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x170-0x177 0x370-0x377 0x3b8-0x3df 0x4d0-0x4d7
Aug  3 14:51:03 rt1-sp kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Aug  3 14:51:03 rt1-sp kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.

--jochen

