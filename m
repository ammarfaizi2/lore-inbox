Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUGKCtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUGKCtP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266489AbUGKCtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 22:49:15 -0400
Received: from fmr02.intel.com ([192.55.52.25]:19590 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S266488AbUGKCtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 22:49:14 -0400
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
From: Len Brown <len.brown@intel.com>
To: Christopher Swingley <cswingle@iarc.uaf.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FFACC@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FFACC@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089514128.32038.62.camel@dhcppc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Jul 2004 22:48:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 11:32, Christopher Swingley wrote:

> I can no longer recall when this first started happening, but there's
> a good chance this happened when I was running 2.6.5 too.  I track the
> vanilla releases pretty closely.

It would be interesting if the IRQ failure was always on IRQ7.

When you moved slots, did the device move to a different
IRQ and fail there too?

Running ACPI, you may be able to move that device off of
IRQ7 with "acpi_irq_balance" plus "acpi_isa_irq=7".

Hardware routes spurious interrupts to IRQ7, so your
device may be an innocent victim of those.  Also,
there may be some motherboard device pulling on IRQ7
that Linux doesn't know about -- so see if you can
disable any extra motherboard devices in BIOS setup.

Finally, you might run a kernel with the IOAPIC enabled,
such as the CONFIG_SMP kernel, to see if you have an
IOAPIC on the board and if that mode works differently.

cheers,
-Len


