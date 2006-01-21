Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWAUL2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWAUL2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 06:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWAUL2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 06:28:10 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:65080 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932136AbWAUL2J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 06:28:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NkBqWtf78rmFejUl2e42Q8hGMp28AEZWLeQOfH+Wnr3b2FYmQBCPVrSwlGwJtQJp5heNH93lrp4LvjnQzvUdjAaZvewyDbSBjgAdYl976wGcFZtC0VF37q7ZJS53wgCs4de/VYF9DGUk4BYTHOHHxBgLAMtvoy2wFwRWa1YZ/tg=
Message-ID: <9a8748490601210328x4d318894rd47df0482a498b07@mail.gmail.com>
Date: Sat, 21 Jan 2006 12:28:08 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: Development tree, PLEASE?
Cc: Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
In-Reply-To: <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com>
	 <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/06, Michael Loftis <mloftis@wgops.com> wrote:
>
> --On January 20, 2006 7:19:58 PM -0800 Matthew Frost
> <artusemrys@sbcglobal.net> wrote:
>
> > --- Matthew Frost <artusemrys@sbcglobal.net> wrote:
> >
> >> No.  Wrong.  If there're a whole grab bag, as you say, then you should
> >> post each, as a separate issue, possibly with consistent proposals for
> >> fixing them.  Follow protocol.  Posting a "The Kernel Is Falling" email
> >> gets people riled up, makes you look foolish, and gets nothing fixed.
> >> Noise.  Send signal.  We'll wait.
> >
> > Be it noted that you have clarified, and that the issue involves ARM and
> > trying to juggle solutions that have simpler alternatives; I just didn't
> > look low enough in the thread first.  My comments are superfluous at this
> > point.
>
> The thread in part diverged into three separate discussions more or less.
> I still have a big problem with how the development of the kernel is being
> done now, with a total lack of a stable branch.  Stable in my mind also
> means not a moving target for developers, nor maintainers.  Try maintaining
> a lot of very demanding applications that must run right so changes must
> always be fully tested before rolling out.  It makes it nearly impossible
> to do that when the kernel has no stable branch that's mostly bug fixes,
> instead any time a bug is discovered a full process must be started to make
> sure no new bugs in all the new code features, etc, that became present
> during the interim are not found.  It makes maintenance a real nightmare
> for atleast one environment in which I maintain production systems, and
> also makes it rather a bit more difficult in others too since changes must
> be vetted.  Not necessarily *all* of them, but when there's lots of changes
> it's hard to track whats 'interesting' and what doesn't affect one.  If
> there was/is a stable tree then when bugfixes come they are applied there,
> and one can upgrade along that tree with much less concern about things
> changing underfoot.
>
> That's my root problem.  The devfs stuff is just ancillary and came about
> as examples of where I've been backed into a no win situation.  Yes, I know
> it was and is deprecated, fact is I didn't write all of the code that is
> the problem, and some of it I don't even have access to either.  Yes some
> of it is maintained by the distro, some by third parties, some by me.  But
> they're all being broken because we either throw out or try to return
> systems with these newer chipsets, or start forking and maintaining
> separate kernel trees.
>
> Don't get me wrong, I understand the reasons, and I apologize for being so
> late to the party.
>
> Over on my end I have to make a decision as to if I have the time to try
> to...promote/lead some sort of effort along these lines so that we can all
> benefit instead of just those willing to use and install RedHat or SuSE or
> Debian or Ubuntu or whatever distro.
>

How about something along these lines :

What you want is a kernel that adheres to the rules set forth in
Documentation/stable_kernel_rules.txt , but you want it maintained for
longer than to the point where the next 2.6.x release happens - right?

So how about you pick, for example, the upcomming 2.6.16 kernel as
your stable target.
The first thing you do is join the -stable team to help review patches
going into 2.6.16.y and help find patches in the 2.6.17-rc kernels
that should go into -stable.
Then when 2.6.17 comes out the -stable team will normally abandon
2.6.16.y and move to 2.6.17 as the new -stable base, so now you have
to make a choice - you can either a) deside that 2.6.17 is an OK
upgrade for you and then the thing just reeats or b) you can deside
that you need to still stay with 2.6.16 for a bit longer.  In the case
of 'b' I'm sure noone would object to you keeing the 2.6.16.y -stable
tree going, so you keep backporting fixes to that (possibly some other
people will even help you with this) and continue to release 2.6.16.y
kernels.
At some point in time you deside to rebase on the latest 2.6.x kernel
and the whole thing repeats itself.

Help out the -stable team :)

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
