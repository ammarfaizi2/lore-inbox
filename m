Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVF3SvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVF3SvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVF3SvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:51:03 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55003 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262905AbVF3Suq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:50:46 -0400
Message-Id: <200506301847.j5UIlp6u012775@laptop11.inf.utfsm.cl>
To: Hubert Chan <hubert@uhoreg.ca>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Weinehall <tao@acc.umu.se> 
   of "Thu, 30 Jun 2005 19:10:57 +0200." <20050630171057.GT16867@khan.acc.umu.se> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 30 Jun 2005 14:47:51 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall <tao@acc.umu.se> wrote:
> On Thu, Jun 30, 2005 at 11:57:27AM -0400, Hubert Chan wrote:
> > On Thu, 30 Jun 2005 08:29:56 +0200, David Weinehall <tao@acc.umu.se> said:

[...]

> > >From the web *browser*'s point of view, it is handled by the
> > "filesystem" (which is provided by the various servers).  The browser
> > doesn't care how or where the data is stored.  It just requests a file,
> > and gets some data back.  So the browser doesn't have to check for
> > http://www.example.com/, get a failure (trying to read a directory),
> > check for http://www.example.com/index.html, etc.  In this way, the web
> > server controls (which I think takes the place of the filesystem in this
> > case) what gets shown (index.html.sv, etc.), instead of the leaving it
> > up to the browser.

> > In the same way, you don't want every single user program to have to
> > guess whether it should look at .data, or .contents, or whatever.
> 
> For the analogy to be complete:

> User has a file browser (say Nautilus)
> The file browser sees the userland VFS (say a unified VFS between GNOME
> and KDE)
> The VFS sees the real file system

> This way the userland VFS can be ported to almost any platform.

That is /very/ nice to have.

> When toying around on the desktop, an abstraction of what a file
> is works fine with me.  When doing serious work (programming,
> tar:ing up stuff, etc) I want to be bloody sure that I see the
> files in the same way always.  I don't want surprises such as
> files suddenly behaving as directories or vice versa.

Let me moderate that a bit: I'd be happy to have (some) files behaving
strangely, /if in exchange I get something very worthwhile/. I.e., Unix
filesystem sockets, named pipes, virtual filesystems all behave in weird
ways, but this downside is more than compensated by huge advantages (even
being able to do things that would otherwise be impossible). But all I see
is that file-is-directory advocates explain over and over how they are
bending over backards to get the whole mess working exactly like true
directories (nothing more, in the end quite a bit less). The uses I've seen
discussed don't really need files-as-directories (you get most of the
advantages by just tar(1)-ing up the contents, or packing them in some
other way; OpenOffice /has/ structured files, XML inside zipped files, Java
also uses zip files for its structuring needs, etc), or are ideas that
might be nice to have on exclusively one-user, isolated machines, like
"keep /my/ annotations/icon/application name/whatever with the file's
data", but that break down in multiuser (even serially, one user after the
other) systems or when files are shared (via network, or simply by sending
by mail or by copying from one machine to the other). In my rather ample
experience, that situation is rare today, rapidly dwindling in the arena
where Linux is mostly used. So this particular case of strange semantics
for files has no upsides I can see, only downsides. The downsides have been
discussed to death, and AFAICS there are fundamental problems with the idea
that can't be fixed or sanely worked around. So why bother?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

