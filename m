Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288021AbSA0OVb>; Sun, 27 Jan 2002 09:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288028AbSA0OVW>; Sun, 27 Jan 2002 09:21:22 -0500
Received: from p5088798F.dip.t-dialin.net ([80.136.121.143]:61058 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S288021AbSA0OVE>; Sun, 27 Jan 2002 09:21:04 -0500
Date: Sun, 27 Jan 2002 15:20:39 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI: kbd-pw-on/WOL doesn't work anymore with 2.4.14
Message-ID: <20020127142039.GH1200@darkside.ddts.net>
In-Reply-To: <20011115184322.A625@darkside.ddts.net> <Pine.LNX.4.33.0111150957220.21985-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111150957220.21985-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holla again :)

On Thu, Nov 15, 2001 at 10:05:48AM -0800, Patrick Mochel wrote:
[I wrote before...]
> > since 2.4.14 kernel, after issuing 'halt', the Keyboard Power-ON or
> > Wake-On-LAN doesn't work anymore. I have to switch the machine on

Is there any hope, that this gets (re-)changed again in the 2.4
tree sooner or later?
I'm still using 2.4.13 because of this :)
I tried everything up to 2.4.17 but it was ever the same since 2.4.14 :)

Maybe one could make it a configure-able 'feature'?
I would happily pre-check a suggested patch, if this would help :)

> > I'm using Asus P3B-F board with 440BX chipset.
> Wake events for devices that are controlled via the southbridge are
> considered General Purpose Events (GPEs). On the southbridge there are two
> banks of registers for GPEs - an enable bank and a status bank.
[...]
> Behavior is different because in 2.4.14, all GPE enable bits are cleared
> just before we enter a sleep state.

Well, I've checked the /proc/acpi/gpe for serval different BIOS
settings - it contains ever the same:
GPE0: 0f 00
regardless if I enable or disable Kbd-Pwr-ON or WOL in BIOS.

[...]
> Wake-on-Lan is a separate issue. If it's a PCI card with PM capabilities,
> telling it to generate a wake event means setting a bit in the PCI config
> space. You can do this with setpci. Why it would stop working, I don't
> know...

Well, add me, but I know, it does stop working between .13 and .14 :)


regards,
   Mario
-- 
<delta> talk softly and carry a keen sword
