Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUICOXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUICOXl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268860AbUICOXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:23:41 -0400
Received: from aun.it.uu.se ([130.238.12.36]:28064 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268929AbUICOXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:23:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16696.32356.734435.383921@alkaid.it.uu.se>
Date: Fri, 3 Sep 2004 16:23:32 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Hendrik Fehr <s4248297@rcs.urz.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Full CPU-usage on sis5513-chipset disc input/output-operations
In-Reply-To: <1094216504.41386b383000b@rmc60-231.urz.tu-dresden.de>
References: <1094216504.41386b383000b@rmc60-231.urz.tu-dresden.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hendrik Fehr writes:
 > Mikael Pettersson writes:
 > > [...]
 > > These are "received illegal vector" errors. They indicate
 > > a serious problem, either with the local APIC bus itself,
 > > or with how the ACPI/MP tables cause us to program the local
 > > and I/O APICs.
 > > 
 > > Do the errors persist if you disable ACPI?
 > > 
 > I just tried the following two things:
 > Boot option "acpi=off" (made the cusour switching faster on and off). And when
 > it came to ide setup i get lots of "hda lost interrupt". The system is
 > unbootable with that option.
 > 
 > With boot option "noapic" there are no more APIC error messages. Should i add
 > that boot option to my defaults in /etc/lilo.conf?

Try pci=noacpi (or however that option which prevents ACPI PCI
IRQ routing is spelled) first.

noapic is a workaround for breakage in other subsystems.
You'll lose interrupt vectors, but that may be preferable
to instability.
