Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTITNSE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTITNSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:18:04 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:64974 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261874AbTITNSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:18:01 -0400
Date: Sat, 20 Sep 2003 15:17:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roger Luethi <rl@hellgate.ch>
cc: acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
In-Reply-To: <20030915224136.GA11666@k3.hellgate.ch>
Message-ID: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003, Roger Luethi wrote:
> On Mon, 15 Sep 2003 08:43:56 +0200, Geert Uytterhoeven wrote:
> > With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> > w.r.t. power management:
> >   - It doesn't poweroff anymore (screen contents are still there after the
> >     powering down message)
> >   - It doesn't reboot anymore (screen goes black, though)
> >   - It accidentally suspended to RAM once while I was actively working on it (I
> >     never managed to get suspend working, except for this `accident'). I didn't
> >     see any messages about this in the kernel log.
> 
> On some machines APIC (sic) support can cause this. Try turning off UP APIC
> if you have it turned on.

If I turn off CONFIG_X86_UP_APIC I get:

| ACPI disabled because your bios is from 00 and too old
| You can enable it with acpi=force
| Sony Vaio laptop detected.

and ACPI is disabled. Halt doesn't work.

If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again and
powers off the machine, but `reboot' causes a black screen with IDE disk spun
down, but no restart.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

