Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268224AbTALEvF>; Sat, 11 Jan 2003 23:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268231AbTALEvF>; Sat, 11 Jan 2003 23:51:05 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:59124 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S268224AbTALEvD>; Sat, 11 Jan 2003 23:51:03 -0500
Date: Sat, 11 Jan 2003 23:55:39 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: The GPL, the kernel, and everything else.
In-reply-to: <Pine.LNX.4.44.0301112006430.30519-100000@dlang.diginsite.com>
To: David Lang <dlang@diginsite.com>
Cc: Ryan Anderson <ryan@michonline.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042347339.1033.191.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301112006430.30519-100000@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 23:21, David Lang wrote:
> 1. some developers are militant about not wanting to have binary drivers
> (as is shown by this flamewar)

Well, at least _this_ particular "flamewar" is relevant to the kernel
list.  Also, please read the lkml FAQ which specifically says to write
your message below any quoted text .. http://www.tux.org/lkml/#s3-9 --
See the part about RFC 1855...

Do these developers include the primary developer, Linus?  He's the one
ultimately responsible for the decision for the maintenance of the
kernel which almost everyone (ok, everyone) uses.  If he's militant
about it, then I guess it's pointless to argue about it.  I got the
feeling from reading his biography ("Just for fun" - that's the title)
that he's the type to let others duke it out and he lets them decide
without really caring which technology makes it into the kernel.

> 2. modules not only need to be called with the correct parameters, they
> also need to do the proper locking. as locking evolves what needs to be
> done by the module changes. This can only be solved by every module doing
> locking 'just in casee' at which point the unessasary locking becomes a
> significant performance issue (Larry McVoy has written a document about
> why locking is bad and why excessive locking is very bad, search archives
> for the link to his site)

I don't need to read an article to know why locking is bad.  However, if
we can broadly generalize drivers into categories (instead of just
"modules", for example, there could be a generic "video module"
structure and that could have a specific kind of locking that a video
driver would need, and the same would go for other specific types of
drivers).

> 3. you say that 'all that is needed' is to design an API that covers every
> possible function a module needs. the problem is that if you try doing
> this you end up with several results.
> 
> A. the API is very complex (since it does cover every possible
> application)

Start simple -- like I said above.. Split the "modules" into categorized
modules and implement one or two subtypes at a time.  For example, leave
the generic "modules" and add a "video module" as above and give it a
specific API which may be complex but less complex than imagined since
it targets a specific piece of functionality.  Other modules can be
devised by studying what drivers are already in the kernel.

I'll avoid replying to points B and C, but I read them..  In part, they
are addressed by the above.

> 4. since no designer (or group of designers) can think of everything your
> API is going to be incomplete anyway. you can either pretend this isn't
> the case and limit yourself to the things that you origionally imagined,
> change your API (and now what do you do with things that used the

Why is it that Windows doesn't seem to have a problem providing a
generic binary driver interface -- one that is portable accross
operating systems as mentioned before -- drivers which work on Windows
98 are binary compatible with Windows 2000 and Windows XP despite major
difference in the systems never mind minor kernel changes.

I'd suggest that a linux kernel developer get their hands on a copy of
the specs for the wdm (windows device driver model) and learn what
useful information they can from it.  

> as for signing kernel modules as being 'good' you have a serious problem
> in the Linux world that there is no central authority to do any such
> signing. 

Microsoft uses Verisign I believe, which is a company linux commands
like "whois" already use to do nameserver lookups for example.  It's a
third party, and hardware manufacturers probably already have
certificates from them.

-Rob

