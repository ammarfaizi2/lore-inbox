Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTDYEfG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTDYEfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:35:05 -0400
Received: from uidc2-5.inav.uiowa.net ([64.6.87.198]:62094 "EHLO
	digitasaru.net") by vger.kernel.org with ESMTP id S262945AbTDYEev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:34:51 -0400
Date: Thu, 24 Apr 2003 23:46:47 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: My take on Trusted Computing and DRM
Message-ID: <20030425044637.GA21291@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Weighing in.  Whee!  This is gonna be long!  I read a little bit on the
  Trusted Computing Platform Association's website, and it has had me
  thinking.

I believe that, if there were ever a DRM implementation to be trusted, it
  would have to be Free Software.  For example, look at Microsoft's
  source code access program for governments.  You may look, but not touch,
  may not discuss, and especially may not compile.
Yay.  Now, how exactly can we even *begin* trusting that the code we *saw*
  was the code we're *running*?!

In Free Software, it's transparent; what you see *is* indeed what you get.
  No hidden gimmicks or surprises (unless Richie did your C compiler.  ;)

It should be noted that we need to talk about two *separate* issues:
  Digial Rights Management, and Trusted Computing.  As a quick executive
  overview, I believe that Digital Rights Management, if implemented,
  should be handled in the programming equivalent of a full environmental
  suit--much, much harm can come from it.  Unfortunately, given the
  direction music and movie labels here in the 'States (which, unfortunately,
  counts for at least the very large majority of the movies and music seen/
  heard at leat in the 'States and in Europe, in my experience).  Thus,
  it is somewhat forced upon us, and we should have an optional(!)
  implementation of it, so that we can continue to interact with the
  complacent world.
Trusted Computing, on the other hand, holds a wealth of security enhancement
  possiblities for the educated user and for the enterprise, and should
  most definitely be embraced, although the non-toxic/carcinogenic
  equivalent of programming asbestos should be used, as it also carries with
  it the danger of abuse.  We *absolutely* need to get full disclosure on
  the hardware, and need to sit in on the industry steering committees, e.g.
  TCPA.  See also my Linux-NG posting at http://lists.debian.org/debian-devel/2002/debian-devel-200212/msg01719.html
  (the big section on security torwards the end) for some of what I'd like
  to see/implement.

DRM:
I am extremely cautious about Digital Rights Management.  Although there is
  a little good to be extracted from it (for instance, the ability to make
  sure that people can't revise a document one's written); there is much,
  much more harm in it.  The most obvious of these is the removal of the
  fair use rights (although not law, fair use ought to be!).  It is
  extremely possible and plausible to have DRM or software under the guise
  of DRM deny you the right to make a backup copy, change format, or even
  select a different player or create your own player!  I'm sure we're all
  familiar with the Content Scrambling System, yes?
That said, it is somewhat inevitable at this time.  The MPAA, RIAA, and
  others are forcing it down our throats at the CD and movie stores.  Yes,
  it can usually be broken, but that's a) illegal in the States, and
  b) just a workaround.  We should concentrate on elevating bit players to
  the foreground, and try to avoid putting any more money in the MPAA/RIAA/
  whoever coffers.  That's the long-term solution; promote business that
  doesn't try to screw us over (as much).  I know it's hard; I like to buy
  DVDs and CDs too.  In fact, I feel like a hypocrite, 'cause I will most
  definitely be purchasing CDs and DVDs in the future.  *sigh*  Any
  suggestions on how to not support them (legally!) would be most welcome.

Trusted Computing:
There is actually quite a bit of good that I can see coming from trusted
  computing, _provided_ that some things are in place.  *If* the user
  can set up the signatures herself, this can be a great boon to security.
  Imagine being able to ensure that the kernel you're booting was indeed
  the one you compiled and signed, and that it's not been rootkited.  Even
  better, envision signed modules and binaries, making rootkits much, much
  harder.  How?  Well, sign the modules.  The kernel then has the public
  key and can verify that the module hasn't been tampered with.  Even
  better, it can refuse to load modules you've not signed, so that crackers
  can't set up a module so that not even your low-level tools can pick up
  the DoS daemon they've got running on port 666.
Programs, already signed by you or the distro, could be kept signed on disk,
  and the kernel, having the appropriate public key supplied by you and/or
  the distro, could then verify that the binary hasn't been tampered with.
  Extend this to files, so that, for example, the cracker can't edit
  inetd.conf to make a bash instance listen in on port 1337, since inetd
  could ask the kernel to verify the signature of the file.  And, even
  better, distribution updates can still be transparent, so long as the
  keys haven't changed.  The package system just updates the signatures
  automatically with the files.  This would require adding metadata to the
  file to store the signature, but it'd work and do quite a bit to make
  rootkits that much harder to implement.
Can this be abused?  Absolutely.  StarOffice 8 could ask the kernel to
  ensure that the StarWriter file has not been modified.  But, nobody's
  forcing you to use StarOffice 8; use AbiWord instead.  Indeed, aside
  from asking the kernel to verify the file's integrity, nothing is there
  that can't be done with existing cryptographic routines.  The difference
  is that the kernel is Linux, and doesn't care *what* the word processor
  is, so long as it's carrying a trusted signature (by you and/or the
  distro).  Remember, this is Linux, and you can get the source, and make
  it go yourself.  It's not Windows, which is closed and has Microsoft's
  business plan and Microsoft's interests behind it.  Effectively, it's
  *your* kernel, and it has *your* interests behind it, because the
  hardware only cares that you signed it.
SO LONG as the hardware gives you that right.  This is why it's imperative
  that we get people on the steering committees.  Do we already?  It's
  extremely unfortunate that one has to be a *business* in order to join
  a standards group and steer the future of technology.  Unless you happen
  to have thousands, if not tens of thousands of dollars lying around that
  can't be put to better use.  Hopefully, our corporate backers can help
  get us in to these meetings; it's imperative that we (the users) can tell
  the hardware what to do; not for the hardware to tell *us* what we can do.
  We *must* be able to set the signatures via *some* method.  This doesn't
  need to circumvent the system if designed properly [for instance, requiring
  physical access + special knowledge (e.g. password)].  Won't stop
  everything, but neither will anything else [for instance, FBI could force
  chipmaker to make special chips with special keys to allow them to load,
  say, a keysniffer, even if it's embedded into a chip and not otherwise
  settable].
There's more that could be done with a trusted architecture [fast hardware
  encryption, storing keys so that not even the kernel knows them nor can
  get at them; mutual distrust between the key/user credential storage and
  the kernel, etc.] to make it a very secure system *if* we can hack on it
  too, and ensure that the user is in control.  Essentially, we (linux, BSD,
  and others) are the ones working for the users.  We are extremely 
  necessary in the fixating the digital future for the users.

This last part was the last part of my debian-devel posting; I think I've
  covered it all.  I hope that we can adopt the good parts of Trusted
  Computing, and I really hope we can help steer it to make sure it goes
  in a way that's not constrictive.  It's a fine line, but, maybe with
  corp. backing (Transmeta, Sun, IBM, Red Hat), we might be able to get
  some developers in to the TCPA and others.

After all, if Microsoft can do it, we can do it *better*.  (and freer ;)

-Joseph


-- 
Joseph===============================================trelane@digitasaru.net
"Isn't it illegal for Microsoft to tie any of its software products to its
  OS?"  --Rob Riggs on slashdot (www.slashdot.org) about Microsoft's order
  to cease and decist using Visual Fox Pro on Linux, a non-Microsoft OS.
"Yes. The penalty is dinner with no dessert." --Alien Being, response
