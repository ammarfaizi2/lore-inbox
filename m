Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbTCPDee>; Sat, 15 Mar 2003 22:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTCPDee>; Sat, 15 Mar 2003 22:34:34 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:3148 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S262248AbTCPDec>;
	Sat, 15 Mar 2003 22:34:32 -0500
Date: Sun, 16 Mar 2003 04:44:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ben Collins <bcollins@debian.org>
Cc: Arador <diegocg@teleline.es>, lm@work.bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030316034454.GR1252@dualathlon.random>
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312193806.2506042c.diegocg@teleline.es> <20030312184710.GI563@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312184710.GI563@phunnypharm.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 01:47:10PM -0500, Ben Collins wrote:
> On Wed, Mar 12, 2003 at 07:38:06PM +0100, Arador wrote:
> > On Tue, 11 Mar 2003 23:16:21 -0500
> > Ben Collins <bcollins@debian.org> wrote:
> > 
> > > You've made quite a marketing move. It's obvious to me, maybe not to
> > > others. By providing this CVS gateway, you make it almost pointless to
> > > work on an alternative client. Also by providing it, you make it easier
> > 
> > I don't think so. This also bits Larry. If he does well enought, there'll be
> > some people here that won't use bitkeeper just because they can use the cvs
> > gateway and they don't need/miss the features they could get with bk.
> > 
> > And i don't think it avoids creating a free bk clone. I guess that there's
> > a lot of people out there interested in such tool, and not only for kernel
> > development; this won't stop them.
> > 
> > As far as i can see; Larry is just wasting time (money) to help the kernel
> > development and people who doesn't use BK just because it isn't free. And
> > he's not charging me, so i find this a good movement for everybody. I only
> > can say thanks.
> 
> You're missing the point. I am not against the CVS->BK gateway. I'm all
> for it. But it's kind of sour given that he now wants to change the disk
> format of the repo to make it harder to get the data from it.

Ben,

You shouldn't care less of the disk format. You *can't* run bk in the
first place to reach those files, it's by pure luck that somebody is
been fine to give away his right to write free software (oh and
proprietary software too but we don't care :) in the SCM arena and to
provide this info to you via rsync or whatever proxy or open protocol
that tytso mentioned is doable.

Before you can remotely care about the disk format you've to reverse
engeneer the network protocol first, having more proprietary stuff there
won't make differences for us. And of course it makes perfect sense for
Larry to hide the stuff better, but even if he encrypts it, the secret
key has to be in the bk binary, I mean, it's all in open source assembly
anyways, if you figured out the network protcol, you shouldn't have an
order of magnitude more of troubles to figure out the new file format
too. NOTE: I don't want to discuss the legal details of reading the
open source assembly, this was only an example ;).

really, what we care is the data, and what I discussed in the last weeks
with Larry about the kernel CVS at first sigh seems enough for kernel
developers, what matters is the _mainline_ evolution.  All other trees
matters much less (and NOTE: all important non mainline trees don't use
bitkeeper anyways). If getting the changesets with dates will be too
hard I assume Larry could help on it. Some script should do it pretty
well thanks to the logical tag in the log. I know it's not the most
useful format for export but this is reliable, documented and open and
it makes it trivial to checkout and search the file logs. which makes it
very usable immediatly w/o the need of new software which is good for us
kernel developers in the short term. This is a good short/mid term solution.

IMHO cloning bitkeeper would be an option if Larry would be supporting
it, but that is obviously not the case.

There is no point to complain about the change of format of files in the
Larry has all the rights to change the file format even after you
reverse engeneered it the first second third fourth time, so all your
effort will break in seconds.  You can spend the rest of your life to
keep up with Larry and he'll always be ahead of you. We have to do this
with the SMB protocol because there's no open ""exporter"", but here
Larry provided the data, and the data belongs to the community in the
first place so there's no need to slowdown innovation here trying to
catch up with closed proprietary protocols.  And note: if you don't like
that linux is developed with bk you should speak with Linus not with
Larry.  That is Linus's choice, Larry couldn't make that change.

If you complain about the file format change, it means you realized
right now you did a mistake in depending on bk in the first place.

I think we reached a point of balance here that will solve all the
collisions. The CVS is a "stability" point. The lack of
data-availability with CVS or similar open protocol would force us to
reverse engeneer bk to access the data, and the availability of CVS
immediatly make us wasting time reverse engeneering bk.  Cloning
bitkeeper is a waste of time if the CVS just exports the data correctly.

Please focus on this: the only thing we miss is the visibility of the
jfs tree and similar other bits that aren't even guaranteed to be merged
in mainline. But that doesn't worry me at all, in one year from now if
the jfs tree didn't merge correctly it won't matter what was in such
dead tree.

If you want to contribute, stop these threads, and start importing CVS
into a more powerful SCM and let us know an URL where we can access the
data from there. I will only answer to a working URL, either that or
live with CVS. The SCM can be evolved over tiem. If this new underground
domain will be better than bitkeeper than jfs and Linus as well could
join us in the future.  In the meantime CVS will do fine and it
guarantees the openess of the linux info. As you probably know I don't
have much time in helping with SCM developement by I can t try give my
$.02 (or at the very least I want to be still allowed to give my $.02!  ;).

I won't answer further emails about this issue to avoid hurting the l-k
traffic too much (the last bk threads even made me overlook the BK->CVS
announcement after a one day and half of email backlog go figure ;).

And of course many thanks to Larry for the BK->CVS effort! While I think
it was due, it certainly takes some relevant effort to do it.

Andrea
