Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281235AbRKEQi7>; Mon, 5 Nov 2001 11:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281233AbRKEQiu>; Mon, 5 Nov 2001 11:38:50 -0500
Received: from air-1.osdl.org ([65.201.151.5]:42766 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S281230AbRKEQij>;
	Mon, 5 Nov 2001 11:38:39 -0500
Subject: Re: Regression testing of 2.4.x before release?
From: "Timothy D. Witham" <wookie@osdl.org>
To: Dan Kegel <dank@kegel.com>
Cc: Luigi Genoni <kernel@Expansa.sns.it>, Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
In-Reply-To: <3BE5F0B5.52274D07@kegel.com>
In-Reply-To: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it> 
	<3BE5F0B5.52274D07@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.02.21.57 (Preview Release)
Date: 05 Nov 2001 08:39:37 -0800
Message-Id: <1004978377.1226.22.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 at 17:51, Dan Kegel wrote:
> Luigi Genoni wrote:
> > Problem is:
> > there is a lot of HW out there, and we should ALL do stress tests, to have
> > a wide basis for HWs and test cases.  Basically it is very hard to agree
> > about a set of stress tests, because we all have different needs, and our
> > tests are based on our needs. That is a streght, because they tend to be
> > real life tests.
> 

  I agree having the users run their applications and under their usage
model is a very good way of testing code drops.  Dan, I think that what
you are trying to say is that it might be a good idea to take a group
of tests and make them the standard set of "pass/fail" that people
should look to before doing their own testing.

> Sure, no argument there.
> 
> > In my esperience, if some default set of tests comes out, then software
> > tend to be optimized for this set. And that is badly wrong.
>

  Any time you start optimizing for a set of performance tests you
take the chance of doing things that only benefit the single test. The
good part about open source is that if somebody tries to do that
the rest of us can point out what a useless (or even counter productive)
optimization they are trying to implement. 

  Regression type pass/fail tests don't tend to have the benchmark
optimization issue but like any test they usually only find the
problems that you either already have had in the past or that are
obvious.  Not complete but they should be dynamic environment that
things are being added to all the time.  Also the nice part about a
knows series of tests is that if a problem pops up it is much
easier to reproduce for debugging purposes.

> My post was motivated by two observations:
> 
> 1. Alan Cox complains occasionally that Linus' trees are not well tested,
>    and can't survive the torture tests that the ac tree goes through before
>    release.  (e.g.
> "2.4.8-ac12
>         I'm trying to make sure I can keep this testable
>         as 2.4.9 vanilla isnt being stable on my test sets "
> 
> 2. The STP at OSDLab seems like a great resource that we might be able
> to leverage to solve the problem Alan points out.
>

  The nice part about the way that STP was designed is that it is 
extensible.  If somebody comes up with another test we can add it.
If we need to add additional equipment to get the run times down
to a usable level then that is easy to do also. 
 
> I'm not suggesting anyone do any less testing.  Just the opposite;
> if we set things up properly with the STP, we might be able to run
> many more tests before each final release.
>

  We are in the process of setting up the Kernel STP to automatically
grab the Linus and -ac kernels and run the full setup.  This will
do part of what Dan is asking for and it will also allow people who
are looking to supply patches a baseline for there patch testing.

Tim

 
> - Dan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)


