Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWHJJsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWHJJsL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 05:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWHJJsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 05:48:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:5142 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161097AbWHJJsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 05:48:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D5Keuv7igaPR6/vCT7exeZP0kO4B7n8aIL5tyDlWXfxTjA1jl19gCnEmUN6tkyyingcz/It9pmAhsNKWhTDOj8MUX1edCeAe/n7oSXAFZB0Yq1lIwJzwuY5J+3dIvUxudWu+EbbrYj5/YFLWGeMVfEIs6PGrGxCmadvor5PKyPE=
Message-ID: <62b0912f0608100248w2b3c2243xec588aee8c5a9079@mail.gmail.com>
Date: Thu, 10 Aug 2006 11:48:08 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
In-Reply-To: <20060810030602.GA29664@mail>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <20060810030602.GA29664@mail>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duane Griffin wrote:
> It takes into account some of them (such as reading data from the
> backup superblock if it detects corruption). Others will be
> irrelevent for further operations.

Ok, maybe it is accurate?

> Many reports will be accurate

Ok, perhaps not then :-).

I'm still confused as to the performance of "-n".
It would be _very_ good to fix this deficiency in the man page of e2fsck.


Thanks Duane, you've been most helpful.


Jim Crilly wrote:
> > Right.  It's all just "Linux" to me ;-).
>
> Then I guess it's time to break out the learning cap and figure
> out what's what. =)

;-).

You can start by phoning Red Hat.  They call their entire product
"Red Hat Linux", so that pretty much means that "Linux" basically
covers everything, not just the kernel.


> > It's indeed a redhat, though - Red Hat Linux release 9 (Shrike).
>
> Why are you using such an old distribution? I know it's only been 3
> years, but a lot has changed and I don't think anyone supports RH9
> or earlier anymore.

As far as I remember, I configured it to automatically update everything.
Apparently that function just broke itself very early on :-).

I guess the problem is that I don't know a single Linux packaging system
that actually works well enough to keep a system up to date at all times,
and I don't have any free time to spend on reinstalling systems all the
time.

I think most of the package managers break because their dependency system
sucks.  Some of them doesn't suck, but they break because there's no
integrity checks, and package maintainers can dump any kind of bizarre
corrupt dependencies they like into them.  That's how Gentoo works, for
example.  Others have even more bizarre ways of breaking, again Gentoo as
an example requires the user to run a "switch to newer GCC" command from
time to time, otherwise random packages just start breaking.

AFAIK, every single Linux package manager on the planet is half-ass, broken
like above or in some other way.  If you know of one that's actually well
thought through on all planes and well implemented and thus works good enough
to keep a system up to date for three years in a row without human
intervention....
Please speak up!!!


> > (Maybe the kernel SHOULD coordinate it somehow,
> > seems like some of the distros are doing a pretty bad job as is.)
>
> That's pretty much impossible, the best the kernel can do is send
> signals to all of the running processes.

Impossible?  Few things in the software world are impossible.

Surely it's possible to create a kernel interface where processes
can tell the kernel about which other processes they'd like to
outlive and which ones they'd like to get killed before.

The kernel could then coordinate the killing of processes in a
"shutdown" function, which the various distro's 'reboot' and
'shutdown' scripts could call.

And voila, that difficult task of assessing in which order to do
things is out of the hands of distros like Red Hat, and into the
hands of those people who actually make the binaries.

Which is probably a good thing, because

a) Red Hat's init scripts probably fails for me because there's
   something in my setup that Red Hat didn't expect.  A greatly
   simplified system as outlined above would help to fix things
   like this.

b) Less duplicated effort in the form of init script coding for
   the distro maintainers.

I realize that details totally absent in the above, but at least
it doesn't look to me like it's impossible at all.


> ext2 breaks the filesystem up into block groups,

Thanks for the info!

> a wild guess about the error message would be that it couldn't
> find the block bitmap for a certain group

Hmm, I would have expected it to find something completely
corrupt somewhere instead of finding nothing at all.

> or the bitmap that it did find wasn't in the correct group.

Implying that they're linked both ways?
That would probably be a very good thing wrt. recoverability.
Interesting thought!
