Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbUKBUF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbUKBUF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbUKBUF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:05:56 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:14808 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261528AbUKBUF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:05:27 -0500
Subject: Re: [PATCH] Serial updates
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041031175114.B17342@flint.arm.linux.org.uk>
References: <20041031175114.B17342@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 02 Nov 2004 13:06:11 -0700
Message-Id: <1099425971.8236.13.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-31 at 17:51 +0000, Russell King wrote:
> Ok, here's a major serial update.  Items covered in this update:
...
> People who should test this patch as a minimum:
> 
>  - ia64 people (ACPI port discovery)

   I tried it on an hp rx2600 ia64 system.  All the ports showed up,
ACPI and PCI:

Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at MMIO 0xf8030000 (irq = 49) is a 16550A
GSI 34 (edge, high) -> CPU 1 (0x0100) vector 65
ttyS1 at MMIO 0xff5e0000 (irq = 65) is a 16550A
GSI 35 (edge, high) -> CPU 0 (0x0000) vector 66
ttyS2 at MMIO 0xff5e2000 (irq = 66) is a 16550A
ACPI: PCI interrupt 0000:e0:01.0[A] -> GSI 82 (level, low) -> IRQ 49
ttyS3 at MMIO 0xf8031000 (irq = 49) is a 16550A
ACPI: PCI interrupt 0000:e0:01.1[A] -> GSI 82 (level, low) -> IRQ 49
ttyS0 at MMIO 0xf8030000 (irq = 49) is a 16550A
ttyS4 at MMIO 0xf8030010 (irq = 49) is a 16550A
ttyS5 at MMIO 0xf8030038 (irq = 49) is a 16550A

The setserial problem I reported w/ MMIO UARTs appears to be fixed.
Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

