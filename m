Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289285AbSANXRO>; Mon, 14 Jan 2002 18:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289283AbSANXPX>; Mon, 14 Jan 2002 18:15:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289289AbSANXPA>; Mon, 14 Jan 2002 18:15:00 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
To: esr@thyrsus.com
Date: Mon, 14 Jan 2002 23:26:40 +0000 (GMT)
Cc: landley@trommello.org (Rob Landley),
        charlesc@discworld.dyndns.org (Charles Cazabon),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        alan@lxorguk.ukuu.org.uk (Alan Cox), eli.carter@inet.com (Eli Carter),
        Michael.Lazarou@etl.ericsson.se ("Michael Lazarou (ETL)")
In-Reply-To: <20020114173423.A23081@thyrsus.com> from "Eric S. Raymond" at Jan 14, 2002 05:34:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QGUy-0003Kh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it's not.  Because the second we stop thinking about Aunt Tillie,
> we start making excuses for badly-designed interfaces and excessive
> complexity.  We tend to fall back into insular, elitist assumptions
> that limit both the useability of our software and its potential user
> population.  We get lazy and stop checking our assumptions.  When we
> do this, Bill Gates laughs at us, and is right to do so.

That I doubt. Its good to see you've spent a day or two reading about
customer expectations and software relationship management, but you are
missing some key bits of UI design here

1.	You don't need to ask the poor user any questions
2.	You can be proactive
		[Shall I update your computer ?]
3.	You can be automated
		[x] update at 4am every day

This is why we have things like DHCP, plug and play, EDID, and so on.
When you ask a user a question they are not sure of you make them feel
inadequate. People don't like that so they dislike the result. Phrasing the 
question in child speak tends to make them feel more not less embarassed.
"Fronicate the Bazoom Hex value" people can justifiably feel isnt their
fault and just hit return. When faced with a two paragraph explanation of the
option, 3 choices and unsure of the answer - that upsets people.

Good design you simply don't notice. Nobody who ever used the gnome-lokkit
firewall configuration ever wondered why their DNS happened to still work for
example, while asking them about DNS would have confused many.

If you want Aunt Tillie to be happy your dialog should probably look like this

		Update my computer
		[yes]         [no]       [advanced] (and this one wants to go)

No hardware dialogs, no extra questions needed. Not even an "optimise my
computer to get the best performance", because that has only one answer in
reality "Duh of course, why are you asking me"

The Red Hat kernel is a modular kernel tuned to the CPU in question, and
with an initrd built for the root fs as needed. All the logic is built into
the existing GPL tools. It figures out what should be in the initrd, which
kernel cpu type to use (and that while now for install could easily be
for build).

I simply don't understand what you are trying to build and why it is hard.

Your new driver model isnt ideal too. Think bigger - unknown driver
PCMCIA [ident strings]. Fine - trigger an apt-get of dev-pcmcia-blah-blah-blah
and see if there is one yet.

Alan
