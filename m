Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWGNQNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWGNQNJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWGNQNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:13:09 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:48560 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161156AbWGNQNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:13:08 -0400
Date: Fri, 14 Jul 2006 09:13:05 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       greg@kroah.com, harmon@ksu.edu, linux-kernel@vger.kernel.org,
       Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-ID: <20060714161305.GA23918@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <1152891980.3205.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152891980.3205.15.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 04:46:20PM +0100, Sergio Monteiro Basto wrote:

> I think DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> quirk_via_irq) is wright if interrupts are in XT-PIC mode, If we
> disable APIC or/and Local APIC, yes we have to quirk the VIA PCI
> interrupts, ok ?

i have a patch (that takes a command line argument to override this)
that more-or-less does that, by default it will frob all VIA devices
if no IO-APIC or is present or you can pass an argument to always do
everything or do nothing

i was hoping we could figure out something smarter than just looking
to see if an IO-APIC was found though, maybe someting like checking if
ACPI actually did something sane, but i know zilch about the ACPI side
of things

i can refresh that against, -git and -mm if people want it

