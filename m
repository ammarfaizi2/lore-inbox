Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270030AbUIDDYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270030AbUIDDYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270033AbUIDDXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:23:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45208 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S270030AbUIDDTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:19:15 -0400
Message-Id: <200409032145.i83LjdXG002843@localhost.localdomain>
To: Spam <spam@tnonline.net>
cc: Dave Kleikamp <shaggy@austin.ibm.com>, Paul Jakma <paul@clubi.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4) 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Fri, 03 Sep 2004 15:16:19 +0200." <642078516.20040903151619@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 03 Sep 2004 17:45:39 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> Dave Kleikamp <shaggy@austin.ibm.com> said:
> >Spam <spam@tnonline.net> said:

[...]

> > You're missing the point.  We don't need transparency in all apps.  You
> > can write an application to be as transparent as you want, but you don't
> > need every app to to understand every file format.

>   No, but not every user "can write an application" either, or even
>   have the skills to apply patches. What I was talking about wasn't
>   just tar, which itself isn't the best example anyway, but the idea
>   that users can load plugins that will extend the functionality of
>   their filesystems. That idea seem to be to be _much_ better than
>   trying to teach every user how to write applications or patch
>   existing ones.

Why compare "write application or apply patches" to "load plugin"? It
would be locical to compare running applications with loading plugins (and
even so, loading plugins is presumably root-only).

[...]

> > There are userland tools that deal with hundreds of file formats. Use
> > the tool you need, rather than try to have the kernel do everything.

>   No, but if I wanted to have an encryption plugin active for some of
>   my files or directories then why should I not be able to? I still
>   want to edit, view and save my encrypted files.

Use an editor that knows about encrypted files. Decrypt/edit/encrypt if no
other option (I'm sure emacs can be coerced to do that transparently ;-). I
for one would be _way_ more confortable with my users doing that than them
loading random modules into the kernel. Besides, if one of my users doesn't
trust the system encryption programs, and prefers hers, she can be happy.

>   Again, this was just an example of what could be done with plugins.
>   It is not said that every conceivable plugin will be written, nor
>   loaded per default. Even though plugins cannot today be dynamically
>   used, they will be eventually. Reiser4 is still very young.

Modules of the kernel were supposed to have all those magic properties too,
until there were nasty races... and it was _seriously_ considered to take
them out. They stayed because they are root-only business, and (un)loading
is rare. FS plugins are kernel modules, AFAIU, and are subject to the same
problems.

>   Please separate your thoughts for specific plugins from those of the
>   idea to have plugins at all.

If you can't find concrete uses for specific plugins, they are the
proverbial solution searching for a problem.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
