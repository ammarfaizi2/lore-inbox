Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSBIKQY>; Sat, 9 Feb 2002 05:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289005AbSBIKQN>; Sat, 9 Feb 2002 05:16:13 -0500
Received: from [208.29.163.248] ([208.29.163.248]:50059 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S288834AbSBIKQB>; Sat, 9 Feb 2002 05:16:01 -0500
Date: Sat, 9 Feb 2002 02:14:52 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Larry McVoy <lm@bitmover.com>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk patch] Make cardbus compile in -pre4
In-Reply-To: <20020208211257.F25595@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202090212420.25220-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

and if you keep doing this you will also need to cleanup and implement the
'hardlink for identical files' idea that was batted around a year or so
ago, otherwise with all the copies of the linus tree with a few K of
patches from different developers you'll start to notice the storage space
used, even at today's drive prices :-)

David Lang

 On Fri, 8 Feb 2002, Larry McVoy wrote:

> Date: Fri, 8 Feb 2002 21:12:57 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
> Subject: Re: [bk patch] Make cardbus compile in -pre4
>
> On Fri, Feb 08, 2002 at 08:39:31PM -0700, Andreas Dilger wrote:
> > On Feb 08, 2002  18:25 -0800, Patrick Mochel wrote:
> > > (I don't have a public repository yet, so there's no place to pull form)
>
> Read the second half below to see how to get one.
>
> > I don't see why everyone who is using BK is expecting Linus to do a pull.
>
> For one, he seems to like that model, if the data is in a well known
> place, he can pull it when he is ready.  Makes it easy for him to not
> worry about whether he has all the stuff Jeff wants to give him, pull
> either says there is nothing to do or it doesn't.
>
> The other issue is that if you do the "bk send -r+" thing, that assumes
> that the receiver has the parent of the most recent change.  The patch
> will not apply otherwise.  This is one difference between BK & diff/patch.
> diff/patch will work in more cases, BK is insistent that the receiver has
> everything that the sender had except the data sent.  So if you let Linus
> pull from a known place then you know he can apply your patch using BK,
> if you don't, then he might be able to apply your patch.
>
> On to the "known place" issue.  One problem people have is having a
> place to stash this stuff.  Since BK is a replicating system, you can
> have the same data in lots of different places, like your laptop, your
> home machine, work machine, whatever, but you need a place that other
> people can pull from that is always there.  Anyone can install BK, read
> the bkd man page and set up such a place.  For those people who either
> don't want to do that, or don't have a place where they can run a BKD,
> or they don't trust the BKD software to be secure, or whatever, we've set
> up bkbits.net, it's somewhat like sourceforge but right now, at least,
> mostly intended for the benefit of the kernel team.  We originally set it
> up for the PPC team but anyone can stash a copy of their repository there.
>
> To get the model, think of this as a staging area.  You don't work there,
> you don't use that system to do your patches or really do very much at
> all.  You work where you work right now.  Make your stuff work, test it
> out, and when you are ready, push a copy of it up to bkbits.net and send
> out mail.  People can go look at the changelogs, see the diffs, pull the
> changes using BK, etc.  And Jeff asked for URL format that he can post
> so you can do a
>
> 	wget <URL>
>
> and you have the patch described in his posting.  That should keep the
> non-BK users happy, in essense the BK users are adding the data and
> BK may be viewed as a patchbot.  For those who don't like the license
> or for whatever reason just like plain patches better, they can slurp
> down the patches any time they want.
>
> If you want to get a project space up there, send mail to
> support@bitmover.com and we'll send you instructions, it's pretty easy
> to set up, you log in and pick a name and add your identity.pub and
> you're all set.  There is a little admin shell you can use to populate
> your repository.  Then you may push your patches there and point Linus
> at them and hope he pulls them.  I can see that in short order Linus
> is going to be asking for the "show me everything I don't have on one
> web page" tool, but that's cool, we've been meaning to build that one
> for a while.
> --
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
