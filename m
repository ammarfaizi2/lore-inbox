Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272956AbTHKTdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273052AbTHKSy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:54:27 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:28883 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272997AbTHKSyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:54:07 -0400
Date: Mon, 11 Aug 2003 20:52:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811185259.GH2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <1060607466.5035.8.camel@defiant.flameeyes> <20030811153821.GC2627@elf.ucw.cz> <1060616931.8472.22.camel@defiant.flameeyes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060616931.8472.22.camel@defiant.flameeyes>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I guess a) is okay. There are not *so* many remote controls out there.
> I think more than one per card model. Other Kworld Card have different
> remote than mine, as you can see on my homepage, my lircd.conf isn't one
> of the ones in lirc remotes list.
> 
> > I guess thats okay; if I want decoder-that-decodes-anything, I need
> > one that connects to serial port and has non-trivial configuration.
> But I can't take a new tv card, plug it into my machine, start up,
> configure the remote, and use xine.

I actually want to "Take a new tv card, plug it into machine, start
up, use xine", without configuring remote ;-).

> Also, from user apps dev view, I think is more difficult to check for
> input events knowing that every remote has different buttons, instead of
> configure the .lircrc and use lirc_client for receive directly
> software-commands.

I think the right way is for application to just use buttons it knows
about. We already have some multimedia buttons on keyboard and some
more on remote...

> We can drop /dev/lirc*, and use input events with received codes, but I
> think that lircd is still needed to translate them into userland
> commands...

I believe we should be able to make it work without lircd, but input
events with received codes is still better than current situation.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
