Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSJQNRN>; Thu, 17 Oct 2002 09:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJQNRN>; Thu, 17 Oct 2002 09:17:13 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:6407 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261424AbSJQNQX>; Thu, 17 Oct 2002 09:16:23 -0400
Message-Id: <200210171322.g9HDME7o024177@pincoya.inf.utfsm.cl>
To: GrandMasterLee <masterlee@digitalroadkill.net>
cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities 
In-Reply-To: Message from GrandMasterLee <masterlee@digitalroadkill.net> 
   of "16 Oct 2002 23:00:20 CDT." <1034827220.32333.69.camel@localhost> 
Date: Thu, 17 Oct 2002 10:22:14 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GrandMasterLee <masterlee@digitalroadkill.net> said:
> On Wed, 2002-10-16 at 22:26, Theodore Ts'o wrote:

[...]

> > Personally, I'm not so convinced that capabilities are such a great
> > idea.  System administrators have a hard enough time keeping 12 bits
> > of permissions correct on executable files; with capabilities they
> > have to keep track of several hundred bits of capabilties flags, which
> > must be set precisely correctly, or the programs will either (a) fail
> > to function, or (b) have a gaping huge security hole.  

Nodz.

> While working with LIDS in it's early stages of implementation, and
> having written some documentation around CAPs and  extended attributes,
> as well as managing that environment, I see value in CAPs, but I see it
> a difficult task to say, manage 100 servers with very tight CAPs set. 

It is easier on the sysadmin for the people upstream (developers,
distributors, ...) to set up stuff sanely in the executable. Sure, a lot of
flexibility is lost this way.

> > This probablem could be solved with some really scary, complex user
> > tools (which no one has written yet). 

> Looking at CA Unicenter, they have an ACLs and CAPs product which does
> centralized management of those attributes to keep the configs sane
> across your environment. Not trying to advertise for them, but the point
> is, if a commercial product exists to do this, then it should be highly
> possible in the OSS community as well.

Sorry, but I gather the vast mayority of Linux instalations to be
single-machine (home use, ...). I have yet to see a hundred-machine setup
myself (maximal is some 30 around here), so this is out of the league of
most people anyway. Plus Linux is falling more and more into the hands of
the unwashed masses, who have a dificult time remembering not to do
everything as root (leave alone fix up permissions).

> >  Alternatively you could just
> > let programs continue to be setuid root, but modify the executable to
> > explicitly drop all the capabilities except for the ones that are
> > actually needed as one of the first things that executable does.
> 
> To make management easy for the admins when I dealt with LIDS and making
> it *very* tight, I had to write several wrappers, replace commands, etc
> so they ran chrooted automatically, etc. It was a PITA. Cool when it
> worked, but it was still a PITA.

But a once-in-the-development PITA, not a once-for-each-installation PITA

> > It perhaps only gives you 90% of the benefits of the full-fledged
> > capabilities model, but it's much more fool proof, and much easier to
> > administer.

> Perhaps exntending the security module to actually have a centralized
> host configuration utility, using say AES or diffie-hellman and SSL or
> SSH to do the configuration management of this. Centralizing, or
> distributing the management of this, but with a decided upon security
> architecture is what, imho, will actually make this type of
> configuration very useable, and manageable. 

Have you seen any such centralized configuration management in real use?
The nearest we come here is Red Hat's kickstart for configuring the whole
Lab (mostly) the same when installing, and that is for only slightly
heterogeneous machines that must look the same to users.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
