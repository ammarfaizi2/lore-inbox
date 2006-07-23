Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWGWIUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWGWIUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 04:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWGWIUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 04:20:38 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:43648 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750755AbWGWIUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 04:20:38 -0400
Message-ID: <44C32348.8020704@namesys.com>
Date: Sun, 23 Jul 2006 01:20:40 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org>
In-Reply-To: <44C28A8F.1050408@garzik.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, I think that a large part of what is going on is that any patch
that can be read in 15 minutes gets reviewed immediately, and any patch
that is worked on for 5 years and then takes a week to read gets
neglected.  This is true even if line for line the 1 week to read patch
is more valuable.    What is more is that people know this is
irrational, but aren't able to cure it in themselves.  Even I have a
problem of paying too much attention to endless 5 minute emails when I
know I should instead, say, read the compression plugin from beginning
to end.

There is nothing about small patches that makes them better code.  There
is no reason we should favor them, if the developers are willing to work
on something for 5 years to escape a local optimum, that is often the
RIGHT thing to do.

It is importand that we embrace our diversity, and be happy for the
strength it gives us.  Some of us are good at small patches that evolve,
and some are good at escaping local optimums.  We all have value, both
trees and grass have their place in the world.


>
>
> With you in particular, you demonstrated NO interest in maintaining
> reiser3, once reiser4 began to make a splash.  Linux kernel code
> exists for DECADES, and as such, long term maintenance is a CRITICAL
> aspect of development.

You are rejecting the development model which is based on stable
branches getting only bugfixes.  V3 is a stable branch.  It just had a
feature added to it which added a bug that MythTV users are hitting. 
Some of them are responding to it by walking away from Reiser3, and no
doubt muttering about what an unstable pile of shit our code is.  On
monday one of my guys is stopping work on V4 to send in a bug fix for a
feature that should have gone into V4 first, and then maybe gotten
backported after it was proven in V4.

So, given that Jeff and Chris can often be gotten to fix bugs, do I ask
them to do it whenever there is a bug to fix and they will fix it?  Oh
yes!  The despiriting thing though is that there is usually another
reason to let them fix it, which is that almost all v3 bugs are in
features they have added to what ought to have been a stable branch, and
since it is their code, they should be the ones to fix it.  We might,
maybe, get one bug report a year in code written by Namesys before  I
announced code freeze on V3.

I just got an email from the programmer who wrote the MythTV bug saying
that he is just too busy to bother fixing the bug in his code.....  so
my response is that a Namesys programmer is going to fix it on Monday.

All this talk about how you guys worry that code is going to be
abandoned, you know, try policing the kids in their 20's who do it, not
those who have been working since 1984 on developing the thing you
somehow are worried they will abandon.  I am not 20 something anymore, I
am getting fat no matter how much I exercise, and I stick with things,
and I only wish some things didn't stick so much with my middle....

>
> Regardless of whatever new whiz-bang technology exists in reiser4,
> there is a very real worry that you will abandon reiser4 once its in
> the tree for a few years, just like what happened with reiser3.

And look at how Linus abandoned 2.4!  Users of 2.4 needed so many
features that were put into 2.6 instead, and they were just abandoned
and neglected and....  Do you think he will abandon 2.6.18 also?

The stable branch of code getting only bugfixes and the development
branch getting all the new features model of development is something
most release management professionals agree is the right way to do
things.  I worked with release management teams some, and I have to say
that the dominant paradigm in the software industry is, in this case,
the best one yet.

Of course, I want to make it a little better, you know how I am, and as
I was just discussing on the reiserfs-list, with plugins we can now move
to a model in which if you mount reiser4 using the -o reiser4.1-beta
mount option, it changes what the default plugin is, and that is how we
do releases, we put our beta code in different plugins, and let the user
choose whether to upgrade to a new release by just choosing what plugins
to use as his default.  Now that we paid the 5 year development price
tag to get everything as plugins, we can now upgrade in littler pieces
than any other FS.  Hmm, I need a buzz phrase, its not extreme
programming, maybe "moderate programming".  Does that sound exciting to
others.;-)  Seriously though, I am curious to see whether plugin based
release management works out as pleasantly for users as I am hoping it will.

Hans
