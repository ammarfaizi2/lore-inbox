Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272770AbTHKPmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272776AbTHKPmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:42:10 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:42629 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272770AbTHKPmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:42:03 -0400
Date: Mon, 11 Aug 2003 17:41:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Flameeyes <daps_mls@libero.it>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811154143.GD2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <1060607466.5035.8.camel@defiant.flameeyes> <20030811144242.GE4562@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811144242.GE4562@www.13thfloor.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I converted lirc_gpio into input/ layer (and killed support for
> > > hardware I do not have; sorry but it was essential to keep code
> > > small). Ported driver looks like this; I believe it looks better than
> > > old code. Patch is here.
> > You can here see the problem... not all tv cards use the same remote,
> > the switch doesn't work with my remote for example, so we have 2
> > possibilities:
> > 
> > a) hardcode all the possible remotes adding these as new one come up,
> > this is a big work in the kernel source, and also we lost compatibility
> > with remotes that use the same frequency of the ones with the tv card,
> > and that now can be used.
> > 
> > b) create an userspace utility that read the input layer for codes an
> > then translates them in user-definable commands. This is what lircd do
> > now...
> 
> what about 
>   
>   c) hardcode the basic decoding and use a mapping table
>      which can be configure from userspace ...
>      (like dvbs haupauge or xmodmap)

Acceptable, too; but I'd like remotes to work out-of-the-box, without
any config.

Of course, if you have homemade serial receiver, you should still be
able to use it, but in such case lircd solution is acceptable.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
