Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTKCUXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTKCUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:23:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:9640 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263320AbTKCUXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:23:31 -0500
Date: Mon, 3 Nov 2003 12:23:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Charles Martin <martinc@ucar.edu>
cc: linux-kernel@vger.kernel.org, <martinc@atd.ucar.edu>
Subject: RE: interrupts across  PCI bridge(s) not handled
In-Reply-To: <004f01c3a243$ccbaf960$c3507580@atdsputnik>
Message-ID: <Pine.LNX.4.44.0311031218250.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Charles Martin wrote:
> 
> I enabled APIC_DEBUG, and here is the dmesg output.

Hmm..

The MP tables mention IRQ's up to 51, but no further.

But the PIRQ routing tables talk about irqs 92-95 for bus 6.

It really looks like the IRQ routing entries are just broken. One 
potential fix is to enable ACPI, and hope that the ACPI irq routing isn't 
as broken as the PIRQ stuff.

Other than that I don't see anything we can do. Anybody else?

		Linus

