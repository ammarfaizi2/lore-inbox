Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUBZVOh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUBZVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:14:37 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28681 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261242AbUBZVOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:14:34 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, Tomas Szepe <szepe@pinerecords.com>
Subject: Re: can i modify ls
Date: Thu, 26 Feb 2004 22:56:13 +0200
User-Agent: KMail/1.5.4
Cc: sandr8@crocetta.org, Gautam Pagedar <gautam@cins.unipune.ernet.in>,
       linux-kernel@vger.kernel.org
References: <005601c3fd75$1c681510$8c01080a@crayii> <20040224165943.GB24370@louise.pinerecords.com> <Pine.LNX.4.53.0402241338210.916@chaos>
In-Reply-To: <Pine.LNX.4.53.0402241338210.916@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402262256.13994.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 20:44, Richard B. Johnson wrote:
> On Tue, 24 Feb 2004, Tomas Szepe wrote:
> > On Feb-24 2004, Tue, 11:44 -0500
> >
> > Richard B. Johnson <root@chaos.analogic.com> wrote:
> > > On Tue, 24 Feb 2004, Tomas Szepe wrote:
> > > > On Feb-24 2004, Tue, 15:55 +0000
> > > >
> > > > Alessandro Salvatori <a.salvatori@universitari.crocetta.org> wrote:
> > > > > it's quite interesting...
> > > >
> > > > Actually, it's not.
> > > >
> > > > 1) The presence/absence of the read permission on a directory
> > > > determines whether the user will be able to list the directory's
> > > > contents.
> > > >
> > > > 2) The fs permission model is enforced by the kernel.  Trying to
> > > > impose additional restrictions in userspace is fragile, futile and an
> > > > incredibly stupid idea.
> > >
> > > If you don't have any programming tools and no access to any (like
> > > a banking or restrictive office environment), and there is no
> > > way to get any external executable files to run, i.e., no floppy
> > > or no shell that could possibly access one, then writing a minimal
> > > 'ls' program that allows the clerk to see what's in her directory
> > > might be useful.
> >
> > So what is it exactly that prevents the admin from running /bin/chmod
> > in the setup you're describing?
>
> No such program. FYI, there are lots of systems where the root file-system
> has a very limited set of tools, sometimes it's on NFS. The machine needs
> to be booted with a different root for maintenance. This is even
> commonplace for store cash-register, and resturant menu setups
> where there is a "server" in the back room that needs to be restarted
> in a maintenance mode, been that way since DOS 3.0. A system is
> secure if (1) there are no tools available to harm it, and (2) if
> the box that contains additional tools is (physically) locked up.

Yes.
But if user has sh, cat and single writable location,
he can just type in any ELF executable, provided (s)he
is clever/mad enough.

That is the exact reason why I abolished [/usr]/sbin
silliness on all my boxen long ago. Copied everything
into corresponding bin/ and chmod'ed a+rx.

I keep symlinks (sbin -> bin) just in case some silly
script expects them to exist.
--
vda

