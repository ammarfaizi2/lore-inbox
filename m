Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbRAERLu>; Fri, 5 Jan 2001 12:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbRAERLj>; Fri, 5 Jan 2001 12:11:39 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:14088 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S129436AbRAERLd>; Fri, 5 Jan 2001 12:11:33 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Daniel Phillips <phillips@innominate.de>
cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Message-ID: <862569CB.005E6373.00@smtpnotes.altec.com>
Date: Fri, 5 Jan 2001 11:11:27 -0600
Subject: Re: Change of policy for future 2.2 driver submissions
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In other words, there's no longer any such thing as a "stable" branch.  The
whole point of having separate production and development branches was to have
one in which each succeeding patch could be counted upon to be more reliable
than the last.  If new development is going into the "stable" kernels, then
there's no way to be certain that the latest patches don't have more bugs than
the earlier ones, at least not without thoroughly testing them.  And if testing
is necessary, then we might as well just use the development kernels for
everything, because we have to test them anyway.

Wayne




Daniel Phillips <phillips@innominate.de> on 01/05/2001 06:52:00 AM

To:   Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
      linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: Change of policy for future 2.2 driver submissions



Mark Hahn wrote:
> > I personaly do not trust the 2.4.x kernel entirely yet, and would prefer to
> ...
> > afraid that this may partialy criple 2.2 driver development.
>
> egads!  how can there be "development" on a *stable* kernel line?
>
> maybe this is the time to reconsider terminology/policy:
> does "stable" mean "bugfixes only"?
> or does it mean "development kernel for conservatives"?

It means development kernel for those who don't have enough time to
debug the main kernel as well as their own project.  The stable branch
tends to be *far* better documented than the bleeding edge branch.  Try
to find documentation on the all-important page cache, for example.  It
makes a whole lot of sense to develop in the stable branch, especially
for new kernel developers, providing, of course, that the stable branch
has the basic capabilities you need for your project.

Alan isn't telling anybody which branch to develop in - he's telling
people what they have to do if they want their code in his tree.  This
means that when you develop in the stable branch you've got an extra
step to do at the end of your project: port to the unstable branch.
This only has to be done once and your code *will* get cleaned up a lot
in the process.  (It's amazing how the prospect of merging 500 lines of
rejected patch tends to concentrate the mind.)  I'd even suggest another
step after that: port your unstable version back to the stable branch,
and both versions will be cleaned up.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
