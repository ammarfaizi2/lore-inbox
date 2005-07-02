Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVGDCkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVGDCkw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 22:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVGDCkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 22:40:52 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30165 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261333AbVGDCkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 22:40:36 -0400
Message-Id: <200507020212.j622CQgb006811@laptop11.inf.utfsm.cl>
To: Kevin Bowen <kevin@ucsd.edu>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Kevin Bowen <kevin@ucsd.edu> 
   of "Fri, 01 Jul 2005 13:26:31 MST." <1120249592.22241.84.camel@punchline.ucsd.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 01 Jul 2005 22:12:26 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Bowen <kevin@ucsd.edu> wrote:

[...]

> > So, for instance, if I want to grab all mp3s with Artist "Paul 
> > Oakenfold" and change the genre to "techno" (can you do that?), I can 
> > use Beagle's search tool to find all mp3s by Oakenfold, but to change 
> > the genre, I have to use some separate tool to manipulate id3 tags, 

> Yes, this is basically what I was getting at, although I was thinking
> more in terms of the reiser5/6/whatever set theoretic semantics, which,
> from my point of view at least, reiser4 is simply the first step towards
> building the enabling infrastructure of. But the fact that reiser4
> semantics + trivial shell scripting enables, as illustrated by David,
> the rough equivalent of set-theoretic semantics, demonstrates how
> reiser4 is in fact a step in this direction.

I don't see any "trivial shell scripting", just need for a plethora of
magic extract-this-or-that-metadata programs. Which can very well work
exactly the same on independent files, no need to shove junk /into/ the
indexed files.

> > > moment the case of system-wide or network-wide shared data,
> > I.e., something like 90% of the use of Linux here. OK.

> 90% of *what* exactly? 90% of what machines deal with, or 90% of what
> humans interact with?

Both. Most use here is in computer labs, where most is shared via NFS
(readonly), plus user data mounted read-write.

> > > users needs. In fact, I believe there is currently a JSR in 
> > > progress to develop a more sophisticated Java packaging model.

> > Presumably based on ReiserFS 4, which then has to be ported to 
> > whatever platform you want to run Java on ASAP? Great for you! Wait a
> > bit, and you'll get what you want then, even across the board!

> No, obviously that's not what I was saying. But the need for these kinds
> of domain-specific packaging/metadata formats, each requiring their own
> tools to work with, would be alleviated if there were simply a more
> powerful filesystem semantic.

*Please explain HOW*!! The domain-specific formats /will/ stay (if nothing
else, because the /domains/ have /specific/ needs), the special tools to
work with them /will/ have to be written exactly the same (because of the
above). All for use on /one/ non-standard filesystem. Plus exactly the same
stuff to work on sane filesystems. The kernel is *not* a magic piece of
software that solves the problem of world hunger if you just can figure out
what strange extension to force onto Linus' kernel version.

>                               Clearly forcing reiser on the world is a
> non-starter, but try extending your imagination a little bit to a future
> in which there's a 'new POSIX' specifying a set-theoretic filesystem
> model.

Sorry, I just don't see any need of shoving Oracle into the kernel. It
leads a quite confortable life in userland.

>        So-called 'database-filesystems' ARE coming, whether from
> Microsoft, Apple, or us.

IBM did it, long ago (AS/400 and OS/400 ring a bell?). And is now slowly
moving away from it (and other structured filesystems), AFAICS, towards
(guess what!) POSIX and Linux...

Again, Linux is what it is today in large part because "We have to get
$FEATURE, because if not, $COMPETITOR will win on us!" arguments have no
traction.

>                          Who gets there first will determine who gets to
> make the rules.

So what? Let /them/ make the mistakes and pay for them, and learn how to do
it /right/, even if later!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
