Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVADNW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVADNW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVADNW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:22:28 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:16580 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261619AbVADNVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:21:55 -0500
Message-Id: <200501041317.j04DHamE007788@laptop11.inf.utfsm.cl>
To: Willy Tarreau <willy@w.ods.org>
cc: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       William Lee Irwin III <wli@debian.org>,
       Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7 
In-Reply-To: Message from Willy Tarreau <willy@w.ods.org> 
   of "Mon, 03 Jan 2005 22:38:45 BST." <20050103213845.GA18010@alpha.home.local> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 04 Jan 2005 10:17:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> said:
> On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
> > This is bizarre. iptables was made the de facto standard in 2.4.x and
> > the alternatives have issues with functionality. The 2.0/2.2 firewalling
> > interfaces are probably ready to go regardless. You do realize this is
> > what you're referring to?

> > 2 major releases is long enough.

When iptables went in, they computed reasonable dates for the final demise
of ipfwadm and ipchains compatibility. IIRC, both came out as March, 2004.

> if it's long enough, ipfwadm should not have entered 2.6 at all.

Backward compatibility is important. Sure, under the old development model
it would have been "deprecate <feature> in 2.<2n>, axe it at the start of
2.<2n+1>, by 2.<2n+2> it is gone".

>                                                                  It's not
> because you don't see any use to that particular feature that you can
> guarantee that it is not used at all. At least, a large public call to
> get in touch with the potentially unique user of this feature would be a
> start, but generally we should not remove a feature from a stable
> kernel.

A public call won't get to that single user, or she is simply too lazy to
answer. Axe it, and they scream. That is much more effective. Besides,
that way she looks for help (and surely finds a kind soul helping out with
migrating). Or stays put (2.4 is still alivve...).

>         What will go next ? minix, because someone will decide that there
> have been many better filesystems for a long time, so that's long enough
> ?

Minix is a nice example, doesn't interfere with other work and is no great
maintainance burden. I guess it'll stay.

>   Revert modules to modutils because someone will think it's simpler for
> everyone to use a single toolset ?

Nope. The change had its very good reasons.

>                                    I have no problem removing numerous
> feature between major releases,

What's the beef then?

>                                 even breaking APIs,

AFAIR, the only public APIs broken have been for exclusive use by utilities
tightly coupled to the kernel (module handling, firewall), and those during
development series. If you fool around with development kernels, you are
supposed to be prepared for such breakage. Normal users get insulated by
their respective distributions.

>                                                     but I really hate it
> when something which is called "stable" constantly changes.

List the offending changes for us all to contemplate, please.

> > On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:

[...]

> > Who do you think is actually banging out the code on this mailing list?

> Frankly, sometimes I'm really wondering. We see lots of very clever
> ideas, and sometimes people come up with concepts which can break
> existing apps, and simply justify by "this should not have been done in
> the first time." (eg: unexport syscall_table). But I'm certain that all
> these mistakes are caused by those too long development cycles. Some
> developpers get bored by things that irritate them, and prefer to fix the
> stable tree to stop what they believe is an error, instead of waiting for
> the next release to fix it there.

Distributions (or final users) are free to undo offending changes.

[...]

> The problem is that nowadays, the userspace-visible code is not only in
> userspace anymore, but also involves modules interfaces sometimes because
> some commercial apps rely on modules (firewalls, virtual machines,
> etc...), and their userspace is nuts without those modules, so in a
> certain way, breaking some kernel internals within a stable release does
> break some apps.

Tough luck. If it is closed source, whoever builds it is responsible for
making it work. If they don't keep it working for your preferred setup,
it's the price _you_ pay for closed source + bleeding edge. LKML has no way
of helping you there.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
