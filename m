Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUIGDOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUIGDOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 23:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267515AbUIGDOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 23:14:38 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30646 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S267511AbUIGDOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 23:14:30 -0400
Message-Id: <200409070206.i8726vrG006493@localhost.localdomain>
To: David Masover <ninja@slaphack.com>
cc: Spam <spam@tnonline.net>, Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Mon, 06 Sep 2004 13:53:13 EST." <413CB219.5030800@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 06 Sep 2004 22:06:57 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> said:
> Horst von Brand wrote:
> | Spam <spam@tnonline.net> said:
> |
> | [...]
> |
> |
> |>  The problem with the userspace library is standardization. What
> |>  would be needed is a userspace library that has a extensible plugin
> |>  interface that is standardized. Otherwise we would need lots of
> |>  different libraries, and I seriously doubt that 1) this will happen
> |>  and 2) we get all Linux programs to be patched to use it.
> |
> |
> | What is the difference with a kernel implementation? Not by being
> | in-kernel will it make all the incompatible ways of doing this
> | magically vanish, and give outstanding performance. Plus handling
> | and maintaining the in-kernel stuff is _much_ harder than userspace
> | libraries.

> First of all, only the interface has to be in the kernel.  I haven't
> heard anyone suggest otherwise.

Right. But it is _another_ interface in the kernel, plus special userland
code supporting it.

> Second, there are quite a few things which I might want to do, which can
> be done with this interface and without patching programs,

Such as?

>                                                            but would
> require massive patches to userspace.  There have been numerous examples.

Haven't seen any that made sense to me, sorry.

> There are some things which can't be solved without patching.

Maybe. Question is, is it worth it (kernel modifications + userland
support, or just userland support, or leave it alone). Sure, it might make
your particular application easier to write (at a cost for _all_ filesystem
hackers!), perhaps even a bit faster; but is _your_ particular convenience
worth the cost for _everybody_?

>                                                                Version
> control is one such thing.

bk, cvs, svn, rcs, ... are working just fine here, thank you so much. Used
to work on SunOS and Solaris, even SCO Unix (I used at least rcs and cvs
there). No Reiser4 in sight.

>                             But then there can be more generic patches
> - -- as soon as the transaction API is done, you only have to patch apps
> to use that, and have a version control reiser4 plugin.

Again, _what_ version control exactly? Will the above packages be able to
make use of it (remember they all are cross-platform (at least cross-Unix),
and so quite unlikely to make use of a Reiser4 on Linux whackiness...)?

> | I'd go the other way around: Get userspace to agree on a common framework,
> | make it work in userspace; if (extensive, hopefully) experience shows that
> | a pure userspace solution has issues that can't be solved except by kernel
> | assistance, so be it.

> We already have such a framework -- it's called "VFS".

Right. It offers what applications need to build their own stuff. It is
minimalistic (well, sort of) and  time-proven.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
