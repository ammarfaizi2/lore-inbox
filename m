Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWIJWnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWIJWnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWIJWnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:43:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3562 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932180AbWIJWnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:43:21 -0400
Date: Mon, 11 Sep 2006 00:42:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Madore <david.madore@ens.fr>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capability inheritance (was: Re: patch to make Linux capabilities into something useful (v 0.3.1))
Message-ID: <20060910224245.GB1691@elf.ucw.cz>
References: <20060907010127.9028.qmail@web36603.mail.mud.yahoo.com> <20060907173449.GA24013@clipper.ens.fr> <20060907225429.GA30916@elf.ucw.cz> <20060908041034.GB24135@clipper.ens.fr> <20060908105238.GB920@elf.ucw.cz> <20060908225118.GB877@clipper.ens.fr> <20060909114037.GA4277@ucw.cz> <20060910104105.GB5865@clipper.ens.fr> <20060910130623.GB4206@ucw.cz> <20060910142540.GA19804@clipper.ens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910142540.GA19804@clipper.ens.fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > tytso actually shown a clever way: add per-filesystem 'default
> > capability masks'. That should be fairly easy to merge, and
> > automatically back-compatible.
> > 
> > (And it would get tou semantics you wanted in inheritance area,
> > right?)
> 
> I'm not at all sure.  If it's just a matter of adding a mount option
> ("inhcaps", say) so that the default file inheritable set is full when
> the option is turned on *or* when one of current->{r,e,s}uid==0 (else
> defaults to regular caps), then that can easily be done: this will
> give a reasonable inheritance with the mount option turned on and the
> current behavior with the mount option turned off (but still the
> possibility of activating inheritance for specific files).

It needs to be inhcaps=[mask] to be consistent with the rest. (What
other bitmasks are there available in the xattrs?)

> *However*, Theodore Ts'o seemed to say that he wanted POSIX-draft-16
> conformance, and I am unable to arrange this: I don't know how to come
> up with a set of semantics that are compatible at once with the POSIX
> rules and the traditional Unix semantics for root.  So if someone
> knows how to do that, he should speak up at that point.

Well, current system is not posix-draft-16, and I guess someone
interested in posix-draft-16 needs to submit patch.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
