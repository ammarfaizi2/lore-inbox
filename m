Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTJHIOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbTJHIOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 04:14:17 -0400
Received: from [80.88.36.193] ([80.88.36.193]:36242 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261188AbTJHIOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 04:14:11 -0400
Date: Wed, 8 Oct 2003 10:13:56 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Len Brown <len.brown@intel.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dimitri Torfs <dimitri@sonycom.com>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: vaio doesn't poweroff with 2.4.22 (fwd)
In-Reply-To: <1065560111.3366.33.camel@dhcppc4>
Message-ID: <Pine.GSO.4.21.0310081005080.3432-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Oct 2003, Len Brown wrote:
> On Tue, 2003-10-07 at 05:18, Geert Uytterhoeven wrote:
> > On 2 Oct 2003, Len Brown wrote:
> > > Is this still a problem w/ the latest build?
> > 
> > Yes (see below).
> > 
> > > Is there a bugzilla entry for it?
> > 
> > No.
> > 
> > Attached you can find my .config, and dmesg output, without and with
> > acpi=force.
> > 
> > Without acpi=force:
> > 
> >   - `halt' doesn't halt (still running)
> > 
> >   - `reboot' doesn't work, and pseudo-halts the machine (black screen, but
> >     power LED still lit)
> 
> The dmesg you attached says this:
> 
> < ACPI disabled because your bios is from 00 and too old
> < You can enable it with acpi=force
> ...
> < ACPI: Interpreter disabled.
> 
> So I'd expect the CONFIG_ACPI !CONFIG_APM kernel to fail to poweroff the
> system.
> 
> > With acpi=force,
> > 
> >   - `halt' works fine
> > 
> >   - `reboot' doesn't work, and pseudo-halts the machine (black screen, but
> >     power LED still lit)
> > In 2.4.21, both `halt' and `reboot' work fine.
> 
> Did you configure with ACPI in 2.4.21?

Yes. It worked fine for halt/reboot up to and including 2.4.21.

> If you configured with APM in 2.4.21, you might consider sticking with
> it rather than switching to ACPI in 2.4.22.

I tried APM in 2.4.23-pre6, and it can halt the machine, but not reboot it.
Now I remember, because APM had problems with reboot or halt, I switched to
ACPI in the first place, when I got the machine 2.5 years ago.

`apm -s' does work now, though (which came as a surprise, since it didn't work
the first time I tried it a long time ago).

> Also, if there is a BIOS update available for this system you should
> consider it.

I went to the website Stan mentioned, and it doesn't seem to list the European
models. Since the Z600 series is called Z505 in US/JP, it may work with one of
the Z505 updates, though. However, I saw updates for W2000/XP only, not for the
BIOS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

