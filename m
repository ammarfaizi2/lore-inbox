Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVJRUtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVJRUtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVJRUtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:49:24 -0400
Received: from p54B055E8.dip.t-dialin.net ([84.176.85.232]:10733 "EHLO
	ccc-offenbach.org") by vger.kernel.org with ESMTP id S932088AbVJRUtX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:49:23 -0400
Date: Tue, 18 Oct 2005 22:49:19 +0200
From: Rudolf Polzer <debian-ne@durchnull.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051018204919.GA21286%atfield-dt@durchnull.de>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain> <20051018171645.GA59028%atfield-dt@durchnull.de> <m3fyqyhdm8.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m3fyqyhdm8.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsis, quam aut quem »Krzysztof Halasa« appellare soleo:
> Rudolf Polzer <debian-ne@durchnull.de> writes:
> > That does not help against the loadkeys issue if the attacking user is still
> > logged in on another virtual console. Even when tty1 is active, a user owning
> > tty6 can use loadkeys.
> 
> Sure. The problem is that mappings are shared between VCs but anyway
> it's solved by disabling user changes.
> I don't think there is a solution here, easier than hardware reset.
> As for "server" machines (not simple terminals), physical locking is
> critical.

Of course it is.

However, pool computers like in this case are neither servers nor terminals.
If they were terminals, we would need about 30 servers to handle the load of
100 active students. So they are workstation installations that do most of the
work locally.

> > Well, sometimes you have problems that powercycling would "hide" so you can't
> > track them down if you powercycle the whole computer every time.
> 
> In security-sensitive instalation, you simply don't expose the computers
> to non-admins.

Well, in this case the issue is on pool computers for students. Students SHOULD
be able to access the computers, but not as root.

Currently our workaround is "only su(do) from a ssh session on a 'trusted'
computer".

> > For using foreign languages and keyboard mappings.
> 
> Hope they don't change the keys in the process.

They HAVE to do that, this is the very point of switching the keyboard layout
from German to US, to UK, to French or to whatever.

> Anyway, most people don't need that nor they need suid-wrapper.

Many people here need that, but it's ok for them if it works only in X11 (most
of these users don't even know that text consoles exist).

However, Xorg and XFree86 have about the same problem: you can remap
Ctrl-Alt-Backspace. So it would be good if the SAK also worked there which
would require it to set a "sane" video mode.
