Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVJETQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVJETQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVJETQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:16:57 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:59663 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S965031AbVJETQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:16:57 -0400
To: Marc Perkel <marc@perkel.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	<4343E611.1000901@perkel.com>
	<20051005144441.GC8011@csclub.uwaterloo.ca>
	<4343E7AC.6000607@perkel.com>
	<20051005145606.GA7949@csclub.uwaterloo.ca>
	<4343EC6A.70603@perkel.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: more boundary conditions than the Middle East.
Date: Wed, 05 Oct 2005 20:16:19 +0100
In-Reply-To: <4343EC6A.70603@perkel.com> (Marc Perkel's message of "Wed, 05
 Oct 2005 08:08:26 -0700")
Message-ID: <874q7vhj0c.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Oct 2005, Marc Perkel yowled:
> Agian - thinking outside the box.

I hate that phrase. There is no `box'.

> If the permissions were don'e right in your own directories your
> inherited rights would give your permissions automatically to your
> home directory and all directories uner it. Netware has a concept
> called an inherited rights mask - something Linux lacks. Windows also
> has rights like this and Samba emulates it. So unless root put files
> in your directory and specifically denied you rights to them, you
> would have full rights to your own directory.

So, um, what happens to these permissions when you copy a file and put
it somewhere else? Do the inherited rights go with it or not? In Unix
it's pretty intuitive. In this system there seem to be two right
answers, both of which seem... risky from a security perspective.

> However - if you were browsing the /etc directory and there were files
> there that you had no read or write access to - then you wouldn't even
> be able to list them.

/tmp is the problem here, and shows the futility and pointlessness of
this feature. If you have an unlistable file in /tmp, *its name is still
determinable*, because other users cannot create files with that
name. The concept adds *nothing* over some combination of dirs with the
execute bit cleared for some set of users and subdirectories which
cannot be read by some set of users. There's no need for this profoundly
non-Unixlike permission at all. (As usual, ACLs make managing this on
a fine-grained scale rather easier.)

>                       If you went to the home directory and lets say
> everyone had 700 permissions on all the directories withing home, you
> would only see your own directory. You wouldn't even be able to know
> what other directories existed there.

This is what per-process filesystems are for.

> If you want to start thinking about DOING IT RIGHT you need to think
> beyond the Unix model and start looking at Netware. Maybe in 5 years
> Linux will evolve to where Netware was in 1990.

I think Plan 9 is a better goal than Netware. At least it was designed
by people aiming for a better Unix rather than people trying to build a
better DOS, and so is more likely to have a compatible philosophy.

> Unix permissions totally suck but it's old baggage that you're stuck
> with somewhat. Are you going to be stuck forever and is Linux ever
> going to grow up and move on to better things? Linux is crippled when
> it comes to permissions.

Well, you can't change it drastically without violating POSIX. There's
no damned way Linux is going to do *that*.

>                          The Windows people are laughing at you and
> you don't even get it why they are laughing.

You *do* realise just how incapable the Windows permission-management
GUI is, don't you? Any OS where the command-line tools hide half
the permissions model and the GUI hides a slightly different half,
and where looking at a set of permissions and hitting cancel can
*change* those permissions drastically, is not sane.

(Disclaimer: the last time I bothered to verify the latter behaviour
was in NT4. Maybe they've partially fixed it.)

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
