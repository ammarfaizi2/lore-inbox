Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272757AbTHKPiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272765AbTHKPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:38:50 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:52115 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272757AbTHKPit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:38:49 -0400
Date: Mon, 11 Aug 2003 17:38:21 +0200
From: Pavel Machek <pavel@suse.cz>
To: Flameeyes <daps_mls@libero.it>
Cc: Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811153821.GC2627@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin> <20030807214311.GC211@elf.ucw.cz> <1060334463.5037.13.camel@defiant.flameeyes> <20030808231733.GF389@elf.ucw.cz> <8rZ2nqa1z9B@hit-columbus.hit.handshake.de> <20030811124744.GB1733@elf.ucw.cz> <1060607466.5035.8.camel@defiant.flameeyes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060607466.5035.8.camel@defiant.flameeyes>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I converted lirc_gpio into input/ layer (and killed support for
> > hardware I do not have; sorry but it was essential to keep code
> > small). Ported driver looks like this; I believe it looks better than
> > old code. Patch is here.
> You can here see the problem... not all tv cards use the same remote,
> the switch doesn't work with my remote for example, so we have 2
> possibilities:
> 
> a) hardcode all the possible remotes adding these as new one come up,
> this is a big work in the kernel source, and also we lost compatibility
> with remotes that use the same frequency of the ones with the tv card,
> and that now can be used.

I guess a) is okay. There are not *so* many remote controls out there.

I loose a tiny bit of flexibility: if I take DAV remote that happens
to almost work with bttv, I was able to use most of its keys with
lircd, but kernel module will not permit me to do that.

I guess thats okay; if I want decoder-that-decodes-anything, I need
one that connects to serial port and has non-trivial configuration.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
