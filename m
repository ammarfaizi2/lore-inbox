Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVAZAu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVAZAu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVAZAr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:47:57 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63441 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262098AbVAZAko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:40:44 -0500
Message-ID: <41F6E716.3090505@comcast.net>
Date: Tue, 25 Jan 2005 19:40:54 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.3.96.1050125185641.18684A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1050125185641.18684A-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Bill Davidsen wrote:
> On Tue, 25 Jan 2005, John Richard Moser wrote:
> 
> 
> 
>>Thus, by having fewer exploits available, fewer successful attacks
>>should happen due to the laws of probability.  So the goal becomes to
>>fix as many bugs as possible, but also to mitigate the ones we don't
>>know about.  To truly mitigate any security flaw, we must make a
>>non-circumventable protection.
> 
> 
> To the extent that this means "if you see a bug, fix the bug, even if it's
> unrelated" I agree completely.
> 

That's the old, old, OLD method.  :)  It's a fundamental principle of
good programming, a good one that some people (*cough*Microsoft*Cough*)
have forgotten, and we see the results and know not to forget it ourselves.

But I also like to go beyond that, to the extent that if you toss a
wrench in it, it'll sieze up, but won't break.  Some of this is
userspace, and some is kernelspace.  It's possible to fix userspace
problems like code injection and tempfile races with kernel level
policies on memory protections and filesystem intrinsics
(symlink/hardlink rules).

I believe that these and similar concepts should be explored, so that we
can truly progress rather than simply continue in the archaic manner
that we use today.  Eventually we will evolve from "look for security
vulns and fix them before they're exploited" to "fix unhandled security
vulns first, and treat handled vulns as normal bugs."  That is, we'll
still fix the bugs; but we'll have a much smaller range of bugs that are
actually exploitable, and thus a better, smaller, more refined set of
high-priority focus issues.

We already do this with everything else.  The kernel developers, both
LKML and external projects, have and are still exploring new schedulers
for disk, IO, and networking; new memory managment and threading models;
and new security concepts.  We have everything from genetics algorithms
to binary signing on the outside, as well as a O(1) CPU scheduler and
security hook framework in vanilla.  I want things to just continue moving.

It's interesting to me mainly that something like 80% of the USNs Ubuntu
puts out contain exploits that could only manage to be used as DoS
attacks if the right systems were put in place, only counting the ones I
actually know and understand myself.  Not all of those protections are
kernel-based, but the kernel based ones 'should' touch on each exploit
in some way.  I believe these are suitable for widespread deployment, so
of course my idea of progress includes widespread deployment of these :)

It's not entirely relavent to argue this here, but it gives me something
to do while I'm extremely bored (hell I've even done an LSM clone that's
simpler and implements full stacking just to occupy myself).  Hopefully
the Ubuntu developers deploy and run this stuff, so after being around
4-6 years, the merits of some often overlooked systems will finally be
widely demonstrated and assessable.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9ucWhDd4aOud5P8RAt57AJwNGyBm9jn87da+JJCbnYXQp+KH4QCbBupJ
mEPqyDIE7ZZitAG1tTKo4qI=
=rCVA
-----END PGP SIGNATURE-----
