Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbRLEUog>; Wed, 5 Dec 2001 15:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284691AbRLEUo1>; Wed, 5 Dec 2001 15:44:27 -0500
Received: from ns.suse.de ([213.95.15.193]:36879 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284676AbRLEUoU>;
	Wed, 5 Dec 2001 15:44:20 -0500
To: erich@uruk.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Loadable drivers  [was  SMP/cc Cluster description ]
In-Reply-To: <E16BY3e-0005S9-00@the-village.bc.nu.suse.lists.linux.kernel> <E16Bhtn-0004xf-00@trillium-hollow.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Dec 2001 21:44:06 +0100
In-Reply-To: erich@uruk.org's message of "5 Dec 2001 20:43:05 +0100"
Message-ID: <p738zch8kix.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

erich@uruk.org writes:
> 
> MS with Windows (and even DOS) went the right direction here.  In fact,
> they have been hurting themselves by what lack of driver interoperability
> there is even between Windows NT/2K/XP.  Admittedly they didn't have much
> of a choice with their closed-source scheme, but it still is a better
> solution from a usability and stability point of view in general.

I remember some quote from a Microsoft manager when they released Win2k.
(paraphrased) "A significant percentage of the blue screens in NT4 were 
caused by buggy third party drivers." (and then how they will try to avoid
it in the future by having more stringent windows logo tests etc.

The experience in recemt Linux is basically similar. Single Linux has
gained vendor support in drivers it has gotten a lot more unstable
than it used to be (sad but true). There are first a lot more and more
complex drivers than there used to be.  A lot of drivers both writen
by individuals and also companies for their are simply crappy buggy
code. I could give you numerous examples here; names withheld to
protect the guilty. For hardware companies it might be because driver
writing is not a profit center, but a cost. There might be other
reasons. There are just a lot of bad drivers around.

[This is not a general insult on driver writers; there are some very well
written drivers, but also unfortunately a lot of bad ones.]

Now when a driver crashes guess who is blamed? Not the driver author
but the Linux kernel is seen as unstable and it effectively is as 
a end result - it doesn't work for the user. All just because of bad drivers. 

The solution that is tried in Linux land to avoid the "buggy drivers" ->
"linux going to windows levels of stability" trap is to keep drivers in tree
and aggressively auditing them; trying to fix their bugs.

A lot of driver code is actually cut'n'pasted or based
on other driver code (or you can say they often use common design patterns)
Now when a bug/race/.. is found and fixed in one driver having the majority
of drivers in tree makes it actually possible to fix the bug who is likely
in other drivers who use similar code there too. With having drivers in external
trees that crashing/angry user/debugging/etc. would likely need to be done once 
per driver; overall causing much more pain for everybody. 

Your scheme would make this strategy of tight quality control of
drivers much harder, and I think it wouldn't do good to the long term
stability of linux.

There are other reasons why linux has really no stable driver interface.
Sometimes it is just needed to break drivers to fix some bugs cleanly.
Getting rid of this possibility (fixing bugs cleanly even if it requires
changes in other kernel code) would also cause more bugs in the long term.

-Andi

