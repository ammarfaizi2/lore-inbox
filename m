Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTJIWrA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTJIWrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:47:00 -0400
Received: from [66.212.224.118] ([66.212.224.118]:16657 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262139AbTJIWq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:46:59 -0400
Date: Thu, 9 Oct 2003 18:46:43 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
In-Reply-To: <20031009090332.A9542@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0310091843220.3679@montezuma.fsmlabs.com>
References: <20031009024334.GA7665@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
 <20031009090332.A9542@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Russell King wrote:

> Correct for x86.  For other architectures, it many not be so.  On ARM for
> example, it is quite normal for IRQ0 to be used.  Hopefully it'll be
> something which generic code won't see, but that isn't always true.
> Someone else might actually follow the PCI specs and use "255" to mean
> "no irq" on their PCI bus.

Unfortunately we wouldn't be able to use that for a test on i386;

IRQ251 -> 10:11
IRQ253 -> 10:13
IRQ255 -> 10:15
IRQ256 -> 10:16
IRQ257 -> 10:17
IRQ258 -> 10:18
IRQ259 -> 10:19
