Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSBIVDf>; Sat, 9 Feb 2002 16:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSBIVD0>; Sat, 9 Feb 2002 16:03:26 -0500
Received: from [208.147.64.186] ([208.147.64.186]:12189 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S287563AbSBIVDR>; Sat, 9 Feb 2002 16:03:17 -0500
Date: Sat, 9 Feb 2002 13:01:34 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Larry McVoy <lm@bitmover.com>
cc: Tom Rini <trini@kernel.crashing.org>, Patrick Mochel <mochel@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <20020209090527.B13735@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202091258110.25220-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do you have a script that can go back after the fact and see what can be
hardlinked?

I'm thinking specififcly of the type of thing that will be happening to
your server where you have a bunch of people putting in a clone of one
tree who will probably not be doing a clone -l to set it up, but who could
have and you want to clean up after the fact (and perhapse again on a
periodic basis, becouse after all of these trees apply a changeset from
linus they will all have changed (breaking the origional hardlinks) but
will still be duplicates of each other.

David Lang


On Sat, 9 Feb 2002, Larry McVoy wrote:

> Date: Sat, 9 Feb 2002 09:05:27 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: Tom Rini <trini@kernel.crashing.org>
> Cc: David Lang <dlang@diginsite.com>, Larry McVoy <lm@bitmover.com>,
>      Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
> Subject: Re: [bk patch] Make cardbus compile in -pre4
>
> > > bk clone -l
> >
> > $ bk version
> > BitKeeper/Free version is bk-2.1.4 20020205155016 for x86-glibc22-linux
> > Built by: lm@redhat71.bitmover.com in /build/bk-2.1.x-lm/src
> > Built on: Tue Feb  5 08:01:19 PST 2002
> > $ bk clone -l
> > usage:  bk clone [-ql] [-E<env>=<val>] [-r<rev>] [-z[<d>]] <from> [<to>]
>
> Tom, I can't believe you are running that ancient version of BK, why it is
> already 4 days old!  Try and stay current :-)
>
> There is a 2.1.4b release that has clone -l in it, along with some rollup
> fixes/enhancements for Linus.
>
> There is an undocumented version of clone -l in your release which works like
>
> 	bk lclone from to
>
> and does the hardlinks.
> --
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
>
