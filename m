Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUFEJTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUFEJTR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 05:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266045AbUFEJTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 05:19:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34957 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266013AbUFEJTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 05:19:05 -0400
Date: Sat, 5 Jun 2004 11:18:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Message-ID: <20040605091853.GA13641@suse.de>
References: <1085689455.7831.8.camel@localhost> <200406041534.48688.bzolnier@elka.pw.edu.pl> <20040604152347.GD1946@suse.de> <200406041814.35003.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041814.35003.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04 2004, Bartlomiej Zolnierkiewicz wrote:
> > > Yep, you prefer to increase my work load instead.
> >
> > If you think that any change to the ide base is increasing your work
> > load, then yes. Otherwise no.
> 
> No, only the messy ones.
>
> > > > That you need to queue pre/post flushes to support barriers is a
> > > > _driver implementation detail_ in my opinion. You don't want to even
> > > > advertise
> > >
> > > It is implementation braindamage IMO (but I'll buy it if rest is OK).
> >
> > Well feel free to pull a rabbit out of your hat and suggest something
> > else that works for barriers. It's mind boggling that nothing so far has
> > come out of t13 to address this, I guess data integrity isn't high on
> > their list.
> >
> > So in short, either shut up or put up.
> 
> Yeah, this the hardest part.  I'll see what can be done.
> 
> > > > that to upper layers. I will move a little of that into the block
> > > > layer, if only because SATA will need it as well.
> > > >
> > > > As for REQ_DRIVE_TASK and ide_get_error_location(), well hell I do take
> > > > patches! If there's something you consider broken, damnit send a patch
> > >
> > > It is _your_ job to do it properly.
> >
> > I _am_ doing it properly. If you think otherwise, then I suggest you
> > show in code what you want changed. If you think it's my job to keep
> > changing the code based on unclear suggestions, then you are sadly
> > mistaken.
> 
> Suggestions were clear, you've chosen to ignore them wishing that
> I will correct the patch or that you will push patch upstream anyway.

And you seem to think that an IDE maintainers listing provides you with
a magical wand that says what goes and doesn't. You might want to check
if that hat is fits too tightly.  Generally, I'd like folks to help out.
And generally, I like people to provide code comments that are to the
point - or, even better, show what they mean with a patch. If you have
no technical arguments except saying 'crap', then don't expect me to put
much value into your comments.

> > > There are no double standards, 'IDE crap embargo' holds for everyone.
> >
> > Like it or not, but ide code needs changing to support barriers one way
> 
> Rule is simple "no more crappola in IDE" and I don't care what your
> patch does if this rule is violated.

I'm really sick of having this debate, it's a complete waste of time.
I'm not looking for your approval or anything in that order, and since
we don't agree all the points in solving this problem, there's no point
in continuing.

> > or the other. If there's some part of the implementation you don't like,
> > then I suggest you show why. Since we appear to have reached a
> 
> Damn, I showed it few times.  You seem to contradict yourself.

A few of the points. Your main argument on the pre/post flush business
makes zero sense still, and that seems to be the heart of your
'crappola' argument.

I already said that I can move the business of queueing post/pre flushes
into the block core instead. You seem to the very way of using pre/post
flushes to provide barriers, and to that I can only say tough shit.
Unless you can pull a rabbit out of your hat and suggest something
better, then your 'crappola' argument holds absolutely no grounds
whatsoever. The pre/post flush approach has worked successfully, it's
been tested extensively, and it works. Your pipe dreams of absolutely no
substance need no further comments.

> > discussion dead lock, I suggest you do so by showing a patch changing eg
> > the ide_get_error_location() stuff. Sadly you could have done this
> > roughly 10 times in the same time frame that you have written these
> > emails.
> 
> Are you trying to trick me into doing your task?

I don't know why you keep thinking this is my job to complete this
project 100% on my own?! There's a general problem that needs solving,
and I would hope that others would be willing to help out where needed.
I would encourage people to help out if they care about the issue.

I'm not going to comment further on your mails in this thread, unless
they have substantial technical comment. Your 'crap' arguments so far
have been largely unsubstantiated, and as such they don't accomplish
much except waste time.

-- 
Jens Axboe

