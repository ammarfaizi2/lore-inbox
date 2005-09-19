Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVITDcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVITDcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVITDcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:32:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27605 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964860AbVITDcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:32:02 -0400
Message-Id: <200509192303.j8JN3ieA030649@inti.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Sun, 18 Sep 2005 22:44:04 MST." <432E5024.20709@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 19 Sep 2005 19:03:44 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Horst von Brand wrote:
> >>>that and there's much more exciting filesystems like ocfs2 around that

> >>This is exciting to... whom?

> >To Cristoph, obviously. You should thank him for doing the (hard, boring,
> >thankless) work of reviewing code for free. Even if it isn't yours. As he
> >is doing it as community service, I wouldn't dare blame him for picking
> >whatever he likes most, for whatever reasons.

> Well maybe he should just go away then and save his and our time. 

Your choice.

> Reiser4 works just fine without Christoph.  Users are happy with it. 
> None of them have asked for his help.  I don't consider Christoph to be
> qualified to work on our filesystem.  I would not hire him if he applied
> --- he is not capable of innovative work.

How do you know?

> Reiser4 is far from perfect, but it is ready for more users.

OK.

> >>Is that Hans' fault, or the fault of your lot?  Why can't we all just get
> >>along?

> >Hans is one person, and he has managed to alienate a most of the LKML
> >bunch. Sure, there are very abrasive people here, but there are plenty that
> >are extremely helpful to newbies that /really/ want to learn how to do
> >things right.

> Yes, but the helpful ones have nothing to do with VFS.

It just so happens that VFS is a central piece of Linux, and it is has been
carefully engineered over the years, for /lots/ of different filesystems. I
can understand that they don't want to change it willy-nilly.

>                                                        Linux has lost
> filesystem developers because of the VFS team, developers who I can tell
> you were very very  gifted DARPA researchers

Care to give names?

>                                              who decided to work on BSD
> because they had too much dignity to develop a filesystem for  Linux.

Their loss, I presume... and you clearly think the same way, because if it
weren't you wouldn't be around here trying to push ReiserFS into Linux, and
would be bothering one of the BSDs instead.

>                                                                        I
> assure you that no one on the VFS team is as bright or capable as one of
> the fellows I know of that they abused away.

Yo don't know the whole "VFS team", so...

> >>If you don't have the time to review, then please hold off on replying
> >>until you have a through review of at least part of the code.

> >Can't do. It is mostly an artistic sense of taste.

> Yes, which is why people who have not written a serious filesystem
> should not instruct those who have written the measurably fastest one.

It might be fast, but if the code is horrible, I don't want anything to do
with it. I prefer the code on which I depend reviewable, thank you very
much.

> >> Also, let's say that Reiser4 doesn't get into the kernel, as maybe XFS
> >>or ext2 or ext3 had never gotten into the kernel.  How would their
> >>development be now as opposed to how we see it, when they have gotten
> >>into the kernel?  I don't see anything wrong with the idea of letting
> >>what seems a mostly mature FS into the kernel; that is how most bugs
> >>are found in the first place.  Of course, there is nothing wrong with
> >>putting huge warnings on the FS; I'd recommend them, considering that
> >>some people are having funky problems with the patch.

> >Just unloading some untested code on unsuspecting, innocent users is not
> >very nice, is it?

> Christoph is not testing.  We have tested, our mailing list has
> tested.....

I'm not talking about Cristoph, I'm talking about unsuspecting users of
Linus' kernel (and users of distributions that will end up enabling
everything under Kconfig "just in case").

> >                                 There are lots of reports of ReiserFS 3
> >filesystems completely destroyed by minor hardware flakiness. And that has
> >/never/ been fixed, as the developers just went off to do the "next cool
> >thing". That history weighs against ReiserFS, heavily.

> We are supposed to write a filesystem so that overheating CPUs do not
> make it crash?

No... but at least try not to get completely hosed in that case.

> Prejudice is a very simple phenomenom.  When either ext3 or ReiserFS V3
> crash it is almost always due to bad hardware.  Prejudice is the process
> of remembering that one filesystem crashed due to bad hardware and not
> remembering that the other one crashed.

No. Here it is starkly remembering the cases where the crash got people to
loose /all/ their data, versus at best dimly remembering cases where a file
got into lost+found and had to be restored.

> It is remarkably simple how it works: people who use Reiser4 want it in,

Fair enough.

> people who use ext3 and don't want to have a choice of something else
> don't want it in.

As a ext3 user, I could not care less for XFS, or JFS, or... What I /do/
care about is the code quality of the kernel. And people who don't want to
(or can't) work nicely with the kernel crew just will screw it up, so I'd
veto their code.

>                    That was true of V3, and it is true of V4.  My point
> of course is that those who have used V4 know more about it than those
> who haven't......

People who work all day on the kernel and have looked at the code, and get
misdirected reports and outcries, know more about it than occassional
users...

> I think Alan Cox is the only poster who has no intention of using
> Reiser4 but said at one point that he thinks it should go in.

I too think that Linux can only win with more filesystems, as long as they
are maintainable and don't mean a burden on the core kernel crew. Note that
this means code in the style of the core kernel, and a developer community
that works well with the core crew.

> V3 is obsoleted by V4 in every way.  V3 is old code that should be
> marked as deprecated as soon as V4 has passed mass testing.   V4 is far
> superior in its coding style also.  Having V3 in and V4 out is at this
> point just stupid. 

V3 /is/ being used by many people. Just decreeing it has to be pulled out
"because V4 is better" is just irresponsible. And that is exactly the
attitude I don't like.

> This whole thing reminds me of an IBMer who told me that he thought that
> IBM lost to MS because they called OS/2 by a name other than DOS.  The
> sad thing is he was probably right. 

The IBMer was dead wrong, OS/2 was strangled by lack of applications.

> V4, as it is today, is as much superior to V3 as OS/2 was to DOS.  Any
> distro or user who would stay with V3 for new installs once we have
> passed mass testing is nuts.  We need the mass testing.

And people who have existing setups don't count? Cautious people who won't
touch a new filesystem with a ten foot pole until it has got mass testing
in a mainstream distribution for a couple of years are irrelevant?

BTW, your post (and my answer, for that matter) don't add any value to
LKML, so please stop here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

