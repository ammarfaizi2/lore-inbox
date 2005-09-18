Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVIRULs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVIRULs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVIRULs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:11:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:947 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932185AbVIRULr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:11:47 -0400
Message-Id: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
To: thenewme91@gmail.com
cc: Christoph Hellwig <hch@infradead.org>, Denis Vlasenko <vda@ilport.com.ua>,
       chriswhite@gentoo.org, Hans Reiser <reiser@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from michael chang <thenewme91@gmail.com> 
   of "Sun, 18 Sep 2005 13:22:27 -0400." <b14e81f0050918102254146224@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 18 Sep 2005 16:04:19 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

michael chang <thenewme91@gmail.com> wrote:
> On 9/18/05, Christoph Hellwig <hch@infradead.org> wrote:
> > On Sun, Sep 18, 2005 at 01:21:23PM +0300, Denis Vlasenko wrote:
> > > This is it. I do not say "accept reiser4 NOW", I am saying "give Hans
> > > good code review".

> > After he did his basic homework.  Note that reviewing hans code is probably
> > at the very end of everyones todo list because every critizm of his code
> > starts a huge flamewar where hans tries to attack everyone not on his
> > party line personally.

> > I've said I'm gonna do a proper review after he has done the basic
> > homework, which he seems to have half-done now at least.  Right now he
> > hasn't finished

> Explain to us all what is this "basic homework" of which you speak.

The required cleanups have been posted (in outline at least), several
times, by unrelated people.

> > that and there's much more exciting filesystems like ocfs2 around that

> This is exciting to... whom?

To Cristoph, obviously. You should thank him for doing the (hard, boring,
thankless) work of reviewing code for free. Even if it isn't yours. As he
is doing it as community service, I wouldn't dare blame him for picking
whatever he likes most, for whatever reasons.

>                               The only thing that appears remotely
> interesting about it is that it's made by Oracle and apparently is
> supposed to be geared toward parallel server whatsits.  This might be
> helpful to corporations, but seems senseless toward many consumers. 

Cristoph finds it interesting, that should be enough for everybody not
paying him for doing the work.

> (I'm assuming there's still at least one consumer left who still uses
> Linux.)

Count me in. That doesn't mean I agree with ReiserFS' goals...

> > are much easier to read and actually have developers that you can have
> > a reasonable conversation with.  (and that unlike hans actually try to

> Is that Hans' fault, or the fault of your lot?  Why can't we all just get
> along?

Hans is one person, and he has managed to alienate a most of the LKML
bunch. Sure, there are very abrasive people here, but there are plenty that
are extremely helpful to newbies that /really/ want to learn how to do
things right.

> Give Hans a chance; and please try to understand, even if he's hard to
> work with.  Discriminate him because he's not a developer you can talk
> with, and I believe that's like discriminating a guy in a wheelchair
> because he can't run with you when you jog in the morning.

Please consider that most people here are volunteers, they owe nobody
nothing. Quite the contrary: if somebody wants to unload their code (and
its future maintenance) on the kernel crew, they are in /great/ debt if it
gets accepted.

> > improve core code where it makes sense for them)

> Not everyone has the same "common sense" that you do.  Explain, fully,
> with reasoning, and reproducable back-up statistics on common hardware,
> what code is wrong, and what must be written instead.  We'd like to be
> efficient, and it's not being efficient to play a guessing game with us.
> If you don't have the time to review, then please hold off on replying
> until you have a through review of at least part of the code.

Can't do. It is mostly an artistic sense of taste.

> Unless you object fully to one particular, fixable thing that isn't the
> core of Reiser4, it'd be nice for you to wait on replying -- vagueness is
> not helpful to development in any way.  Are we supposed to be the million
> monkeys randomly typing on a million typewriters waiting for someone to
> give you code that you like, one in a million years?

You are the ones that want to benefit from having your code in the kernel.
You evaluate if the (standard!) cycle of "Code, propose, get rejected, fix,
repropose, ... until finally accepted" works for you or just isn't worth
the bother.

> Also, let's say that Reiser4 doesn't get into the kernel, as maybe XFS
> or ext2 or ext3 had never gotten into the kernel.  How would their
> development be now as opposed to how we see it, when they have gotten
> into the kernel?  I don't see anything wrong with the idea of letting
> what seems a mostly mature FS into the kernel; that is how most bugs
> are found in the first place.  Of course, there is nothing wrong with
> putting huge warnings on the FS; I'd recommend them, considering that
> some people are having funky problems with the patch.

Just unloading some untested code on unsuspecting, innocent users is not
very nice, is it?

> I'm willing to go compare Reiser4 to ext2/3 as like H.264 to Mpeg-2. 
> Indeed, H.264 crashes some computers, similar to Reiser4 might crash
> some machines, but this is merely because Reiser4 explores new
> concepts, meaning it may require hardyier hardware than ext2/3, as
> H.264 requries hardier hardware than Mpeg-2.

Either one crashing the machine is unacceptable (in principle at least). A
filesystem is so central to "everything is a file" that filesystem problems
are doubly unacceptable. There are lots of reports of ReiserFS 3
filesystems completely destroyed by minor hardware flakiness. And that has
/never/ been fixed, as the developers just went off to do the "next cool
thing". That history weighs against ReiserFS, heavily.

>                                               I believe that the
> concept is the same. (And all the same, media companies are embracing
> H.264 - why can't you guys embrace this new idea also?) Change is
> hard.  Besides, if Reiser4 is truely that flawed, we will see in a few
> releases, and then afterwards if it's proven to everyone that Reiser4
> is completely unrepairable and hopeless, it can then be ditched and
> thrown into the trash.

It is cheaper for everybody involved to throw it in the thrash /before/
lots of people are dependent on it, and throw it out then. Just consider
the pain caused by including (and now ditching) devfs.

> My apologies for my rudeness, but I am rather fond of the developments
> in Reiser4, and would love to see it in the kernel.  I am fond of
> Linux too, and the work that you guys do, and it would dissapoint me
> sorrily if Reiser4 never makes it into the Linux kernel.  Feel free to
> say I'm a tad biased; I will say now that I probably have much less
> merit in the field than you guys do.

All this has been discussed in BIGNUM flamewars already, neither your nor
my post helps a bit in either way (except in fanning the flames), so please
let's drop this.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
