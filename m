Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269146AbRHBUxZ>; Thu, 2 Aug 2001 16:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269144AbRHBUxR>; Thu, 2 Aug 2001 16:53:17 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:4069 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S269145AbRHBUxL>; Thu, 2 Aug 2001 16:53:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Richard B. Johnson" <root@chaos.analogic.com>,
        kumar M <kumarm4@hotmail.com>
Subject: Re: GPL issuefor run time kernel function overwrite
Date: Mon, 30 Jul 2001 20:31:26 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010730104556.1947A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010730104556.1947A-100000@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <01073020312601.00672@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 July 2001 10:48, Richard B. Johnson wrote:
> On Mon, 30 Jul 2001, kumar M wrote:
> > Hi,
> >
> > I have a query regarding the GPL for Linux kernel.
> > We were having a heated discussion regarding
> > opening up / disclosing  source code for features
> > added to  kernel (as per GPL) if we do the following  :
> >
> > * We implement a driver which will overwrite any existing
> > (global kernel data strcuture) function pointer in linux
> > kernel space run-time.
> > * No kernel source code is modified in the process.

You mean like writing to /dev/kmem or some such?

Good luck.  Deep, evil black magic.  According to Linus you can basically do 
anything you want from user space (including loading binary kernel modules at 
run-time), but the only way any sort of hook to make intrusive binary-only 
changes EASIER is over Linus's dead body.  That's my understanding of it, 
anyway.

It's going to break going from 2.4.7 to 2.4.8.  And then it's going to break 
again going from 2.4.8 to 2.4.9.  And anybody who has a kernel with your 
binary-only gorp in it won't even be LISTENED to if they submit bug reports 
to this list with that stuff loaded.  They will be sent back to you for all 
support including stuff that IS a problem with the rest of the kernel.

> > regards,
> > Kumar
>
> Not only is the wording of GPL, but also its intentions important.
> If the intentions of the GPL are to help promote the free flow
> of ideas, and to show explicitly how some software is implemented,
> then any attempt to obscure, disguise or hide the implementation
> details is contrary to its intent.
>
> It is my opinion that any software that is provided without its
> source-code is contrary to the intent of GPL.

Sure.  Including anyone anywhere on the planet to buy or use a copy of 
Windows.  But intent isn't the only consideration, there ARE the questions of 
applicability and standing. :)

> However, I'm sure
> that there are lawyers who will disagree.

Most of them, I suspect.

The intent of the GPL is also bounded by what copyright law will allow (and, 
if supplemented by contract law, fun little issues like informed consent and 
some formal phrasing of "reasonableness" which I can't remember at the 
moment).

You can write a license that says everybody who views your web page owes you 
a pint of blood.  And although they DID copy your web page (downloading it 
and viewing it), it would be just about impossible to enforce in court for a 
ton of reasons.

> We already have so-called "proprietary" code being included into
> the kernel. This started with "harmless" bits of binary which is
> uploaded into the hardware when some drivers are installed.
> Including such binary is also contrary to GPL, but without this
> secret goo, the hardware won't run.

Yup.  LIke the BIOS calls that boot the sucker up and handle half of APM...

> This exception to GPL, in my opinion, opened the door to future
> corruption and exploitation. Time will tell.

Yeah, so did switching from a "no commercial sales" to the GPL in the first 
place.  Never play Holier Than Thou with Zeus.  (Or Richard Stallman.)

I think the door was open for corruption and exploitation when Linus uploaded 
his "term program that grew legs" to the net at large.  Once you no longer 
personally know all the users...

Linus's weapon against this is frequent, flagrant, severe, and even 
gratuitous breakage of intra-kernel binary compatability.  You gotta 
recompile all your modules with every dot-release.  In fact there's the 
"include version info" option that make you do that even when nothing really
changed. :)

Anybody who wants to maintain a binary-only module is welcome to try.  And is 
in for a WORLD of pain.  No license by itself will protect code from 
exploitation.  And neither will wishful thinking about how that license 
SHOULD work.  An active and informed user community that responds and adapts 
to things is what will do it.  Only thing that can.

> Now, if your code attacks and destroys, replaces, or otherwise
> modifies a kernel, I think that's fine as long as the source-code
> is provided. You can even develop modules that are designed to
> do harm.

Copyright does not cover use.  Copyright has never covered use.  It covers 
creation and "first sale" disposal of copies.  If you own two books, and you 
cut and paste the pages together to form a third book, you haven't violated 
either copyright.  They are your pages, if the use you choose to make of them 
involves sticking them in a blender or lining a bird cage with them, that's 
your option.  Making MORE copies you don't have the legal authority to do, 
but manipulating your existing legal copy is your problem.

Computer distribution is slightly different because each time it's 
distributed you're making a new copy.  (Even if you copy it onto a disk.)  So 
"first sale" turned into "the license is the entity you own, not any 
particular copy of the I.P.", thanks to a certain redmond company lobbying 
circa 1980.  (Bill Gates did invent ONE thing.  Most of the legal backing for 
modern proprietary software.  He WAS studying to be a lawyer at Harvard 
before dropping out...)

But there's still fair use, which got extended to making an archival copy of 
things (which you're still allowed to do), and of course space shifting and 
time shifting and such...

Creating copies of derived works IS covered by copyright law, and since 
that's integral to distribution of computerized gorp, copyright directly 
applies (regardless of first sale limits, it seems).  Or looked at another 
way, the license you own has terms which can make it expire.  This has never 
quite been upheld in court but has been taken as policy for years and years, 
and if it WAS overturned it would probably do a lot MORE damage to 
proprietary software companies (out there selling licenses that may not be 
worth much, with shrinkwrap clauses limiting the number of "seats" a server 
install is good for and such) than to free software.  (You'll notice MS is 
happy to badmouth the GPL, but isn't going to go near it with lawyers any 
time soon.)

Stallman was the first person to figure out that turnabout could be fair 
play, and make his own license with terms that followed the software and 
dictated terms about its distribution.

So if you make your own program that XORs the kernel image, or compresses it, 
your program doesn't have to be GPL.  This is fair use, of your own data on 
your own hard drive.  (And THIS kind of copying has been confirmed fair use a 
number of times.  Loading a program from disk into ram is not a copyright 
violation, it's what the program is FOR.)

And if your program patches the kernel on your hard drive, and your program 
contains no GPL itself, the GPL doesn't have any kind of hold over your 
program.  It hasn't got any leverage to apply copyright law to it.

It's only when you distribute the modified version you get into trouble.  If 
neither the license nor fair use give you the right to do that, then you're 
in for a speeding ticket.

>
> Cheers,
> Dick Johnson

Rob

(P.S.  I'm a big fan of the GPL.  But trying to stretch it too far, or 
claiming it can do things that it can't, only weakens it.  Understand your 
tools...)

