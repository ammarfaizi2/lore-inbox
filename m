Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTLONXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 08:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTLONXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 08:23:22 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:485 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263607AbTLONXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 08:23:21 -0500
Date: Mon, 15 Dec 2003 14:23:17 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <Pine.LNX.3.96.1031213001311.13795A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.55.0312151417350.26565@jurand.ds.pg.gda.pl>
References: <Pine.LNX.3.96.1031213001311.13795A-100000@gatekeeper.tmr.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003, Bill Davidsen wrote:

> >  Well, the NMI watchdog is a side-effect feature that works by chance
> > rather than by design.  So you can't really complain it doesn't work
> > somewhere, although I wouldn't mind if new hardware was designed such that
> > it works.  You shouldn't have to use "acpi=force" for the watchdog to work
> > though and for a PII system if "nmi_watchdog=1" doesn't work, then I
> > suspect a BIOS bug (set APIC_DEBUG to 1 in asm-i386/apic.h and send me the
> > bootstrap log and a dump from `mptable' for a diagnosis, if interested).
> 
> Has the check to see if the BIOS is old than very recent been removed? I
> used to get a message that the BIOS was too old, I believe that's what
> prompted the acpi to enable the local apic. Sorrt, I've been running that
> feature since 2.5.3x or so and I just carried it forward.

 I don't know what check you refer to, sorry.  I don't think we do any
version checks in the APIC code.  Perhaps ACPI does some, but having no
use for it anywhere I'm not familiar with that area.

 If the "nmi_watchdog=1" option doesn't work for a PII system, then its
most likely a bug in BIOS IRQ routing tables -- either missing or broken
entries for the 8254 timer and/or the 8259A ExtINTA source.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
