Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFJSOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTFJSOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:14:43 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:2031 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261292AbTFJSOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:14:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New system device API
Date: Tue, 10 Jun 2003 13:27:54 -0500
X-Mailer: KMail [version 1.2]
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20030609210706.GA508@elf.ucw.cz> <Pine.LNX.4.44.0306091412440.11379-100000@cherise> <20030609213247.GC508@elf.ucw.cz>
In-Reply-To: <20030609213247.GC508@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <03061013275402.06462@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 June 2003 16:32, Pavel Machek wrote:
> Hi!
>
> > > > So? A keyboard controller is not classified as a system device.
> > >
> > > Its not on pci, I guess it would end up as a system device...
> >
> > Huh? Since when is everything that's not PCI a system device? Please read
> > the documentation, esp. WRT system and platform devices.
>
> Oh and btw keyboard controller is used for rebooting machine. Do you
> still say it is not system device?
> 								Pavel

And here I thought it was the reset line on the bus... :-)

There are lots of ways to do that without involving the keyboard. The old way
was just to wire the serial break signal from the UART to the reset line...

Would that suddenly make the serial interfaces system devices?

What about that "wake on lan" business... does that make the network card a
"system  device"?

The only things I think of as "system device" is the CPU, the memory bus, and
sometimes a thing called a system controller/bus arbiter. The memory bus 
should provide access to any ROM needed for initial program storage.

Outside of that, everything is a peripheral, and should be treated as such,
even though the memory management unit is considered part of the CPU.
