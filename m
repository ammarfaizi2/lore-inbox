Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUHSRZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUHSRZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUHSRZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:25:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19692 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266833AbUHSRZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:25:13 -0400
Message-Id: <200408191724.i7JHOTPY005432@laptop14.inf.utfsm.cl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices 
In-Reply-To: Message from Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> 
   of "Thu, 19 Aug 2004 18:00:56 +0200." <200408191800.56581.bzolnier@elka.pw.edu.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 19 Aug 2004 13:24:29 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> said:
> On Thursday 19 August 2004 16:32, Alan Cox wrote:
> > On Iau, 2004-08-19 at 15:32, Frank Steiner wrote:
> > > What a stupid claim. When I call cdrecord on SuSE 9.1, I can burn CDs and
> > > DVDs as normal user, without root permissions, without suid, without
> > > ide-scsi, using /dev/hdc as device.
> > >
> > > And this just works fine. So where's the problem?
> >
> > You can also erase the drive firmware as a user etc. That's the problem.
> > When you fix that cdrecord gets broken by the security fix if you are
> > using the SG_IO interface. Patches are kicking around to try and sort
> > things out so cd burning is safe as non-root. cdrecord works as root.
> >
> > As a security fix it was sufficiently important that it had to be done.

> IMO work-rounding this in kernel is a bad idea and could break a lot of
> existing apps (some you even don't know about).  Much better way to deal
> with this is to create library for handling I/O commands submission and
> gradually teach user-space apps to use it.

Sorry to disagree, but no way. If security is involved, depending on people
do do "the right thing" because they are nice (and update their code, and
follow "good practice", and ...) is suicide. Better be safe, and swallow
the flames caused by unfixed apps while it lasts.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513 
