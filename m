Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162330AbWLBLMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162330AbWLBLMY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162349AbWLBLMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:12:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15528 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162330AbWLBLMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:12:22 -0500
Date: Sat, 2 Dec 2006 11:19:28 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ricardo Lugo <ricardolugo@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang booting onboard HPT 366 with libata (PATA)
Message-ID: <20061202111928.428e83d2@localhost.localdomain>
In-Reply-To: <61D44F12-D09C-4A6F-9FC7-4AC49FEC757B@gmail.com>
References: <61D44F12-D09C-4A6F-9FC7-4AC49FEC757B@gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: PCI Interrup 0000:00:13.1[B] -> GSI 18 (level, low) -> IRQ 16
> ata5: PATA max UDMA/66 cmd 0xE400 ctl 0xE802 bmdma 0xEC00 irq 16
> ata6: PATA max UDMA/66 cmd 0x0 ctl 0x2 bmdma 0xEC08 irq 16

Ok so the underlying problem seems to be that the second channel of the
card had no I/O resource assigned to it, presumably because it wasn't in
use. We check various other "not in use" things but not that one.

I'll fix that up. I think it just needs another check in libata-sff.


Alan
