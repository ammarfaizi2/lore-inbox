Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWATQdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWATQdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWATQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:33:52 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:5018 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751063AbWATQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:33:51 -0500
Date: Fri, 20 Jan 2006 17:34:33 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Michael Loftis <mloftis@wgops.com>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120163433.GB5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc1-marc-g18a41440-dirty
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Loftis <mloftis@wgops.com> [2006-01-20 09:07:16 -0700]:

> 
> 
> --On January 20, 2006 4:59:19 PM +0100 Marc Koschewski 
> <marc@osknowledge.org> wrote:
> 
> >For my daily work I use the -git kernels on my production machines. And I
> >didn't have probs for a long time due to stuff being tested in -mm. -mm
> >is mostly broken for me (psmouse, now reiserfs, ...) but I tend to say
> >that 2.6 is rock-stable.
> >
> >When it comes to API stability people are encouraged to stay up-to-date
> >when when developing stuff out of the kernel tree, ain't they? A more
> >convenient way would be to create a new in-kernel-tree wrapper module
> >that wraps some functions no longer available anymore and which are
> >possible to be wrapped in the meaning of all needed data is provided to
> >the 'old' method and can be easyily wrapped into the new function.
> >
> >It could a Kconfig option so that the 'wrapper module' is only activated
> >on demand. Thus, having the option to port driver directly to the new API
> >or just silenty use the 'wrapper module' to translate the call while
> >being noisy at compile time.
> >
> >You're free to write the module... ;)
> 
> I know this, but the in-kernel stuff is far less painful than when all this 
> stuff bleeds to userland.  Besides, can you imagine such a beast of a 
> module? :D  I mean yeouch, the maintenance.  And it'd encourage the sort of 
> thing we as kernel developers in general want to discourage, which is the 
> use of deprecated APIs.

I know. But you we're the one who started this off. The 'beast' should be
maintained by people that need it. And it was just a brainstorm, moreover.

> 
> Lots of things still out there depend on devfs.  So now if I want to 
> develop my kmod on recent kernels I have to be in the business of 
> maintaining a lot more userland stuff, like mkinitrd, installers, etc. that 
> have come to rely on devfs.

What exactly relies on _devfs_?

> 
> The point is this is happening in what is being called a stable kernel. 
> Stable it isn't.  The whole devfs thing is likely to cause me a lot of 
> work, I'd stay with 2.4 in the worst affected things, but I can't.  devfs 
> is newish for and already been deprecated and killed before a major release 
> even, that just seems not right.

As far as I remember the devfs maintainer didn't do just a one-liner of changes
plus he was not to be reached by mail. No reply, no list acitivity, ... nothing.
Just out of the town.

> 
> Anyway hopefully this thread wills tart some constructive thought on this 
> rather than being pointless, but I had to get it out there.  I know I have 
> a habit of showing up every other year or so. :)

This thread will start something, yes. But I don't think we will have a decision
in the end. The kernel grows. In size, in features, in just about anything. And
from a developers point of view it's always wise to re-write a subsystem with a
new API and the freedom to do _whatever_ one thinks she could do than re-write a
subsystem due to maintaining the interface for compatibility.

The two cases exactly are:

	* _new_ code with all new features planned

	or

	* _partly new_ code with some new features due to API incompatibility a la
	  'what we have to do is to get the best we can from what we have'

And the latter is definitely the wrong way to go. Just my 2 cents...

Marc
