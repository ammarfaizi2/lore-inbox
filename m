Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWATP6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWATP6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 10:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWATP6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 10:58:34 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:14743 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1750834AbWATP6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 10:58:34 -0500
Date: Fri, 20 Jan 2006 16:59:19 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Michael Loftis <mloftis@wgops.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120155919.GA5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc1-marc-g18a41440-dirty
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Loftis <mloftis@wgops.com> [2006-01-20 08:17:40 -0700]:

> OK, I don't know abotu others, but I'm starting to get sick of this 
> unstable stable kernel.  Either change the statements allover that were 
> made that even-numbered kernels were going to be stable or open 2.7. 
> Removing devfs has profound effects on userland.  It's one thing to screw 
> with all of the embedded developers, nearly all kernel module developers, 
> etc, by changing internal APIs but this is completely out of hand.
> 
> Normally I wouldn't care, and I'd just stay away from 'stable' until 
> someone finally figured out that a dev tree really is needed, but I can't 
> stay quiet anymore.  2.6.x is anything but stable right now.  It might be 
> stable in the sense that most any development kernel is stable in that it 
> runs without crashing, but it's not at all stable in the sense that 
> everything is changing as if it were an odd numbered dev tree.
> 
> Yes, I'm venting some frustrations here, but I can't be the only one.  I 
> know now I'm going to be called a troll or a naysayer but whatever.  The 
> fact is it needs saying.  I shouldn't have to do major changes to 
> accomodate sysfs in a *STABLE* kernel when going between point revs.  This 
> is just not how it's been done in the past.
> 
> I can sympathize with the need to push code out to users faster, and to 
> simplify maintenance as LK is a huge project, but at the expense of how 
> many developers?

For my daily work I use the -git kernels on my production machines. And I didn't
have probs for a long time due to stuff being tested in -mm. -mm is mostly
broken for me (psmouse, now reiserfs, ...) but I tend to say that 2.6 is
rock-stable.

When it comes to API stability people are encouraged to stay up-to-date when
when developing stuff out of the kernel tree, ain't they? A more convenient way
would be to create a new in-kernel-tree wrapper module that wraps some functions
no longer available anymore and which are possible to be wrapped in the meaning
of all needed data is provided to the 'old' method and can be easyily wrapped
into the new function.

It could a Kconfig option so that the 'wrapper module' is only activated on
demand. Thus, having the option to port driver directly to the new API or just
silenty use the 'wrapper module' to translate the call while being noisy at
compile time.

You're free to write the module... ;)

Marc
