Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUHSXGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUHSXGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 19:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267509AbUHSXGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 19:06:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267505AbUHSXCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 19:02:52 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Fri, 20 Aug 2004 01:02:04 +0200
User-Agent: KMail/1.6.2
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       fsteiner-mail@bio.ifi.lmu.de, diablod3@gmail.com
References: <200408191732.i7JHWSkL005470@laptop14.inf.utfsm.cl>
In-Reply-To: <200408191732.i7JHWSkL005470@laptop14.inf.utfsm.cl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408200102.04377.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 19:32, Horst von Brand wrote:
> Joerg Schilling <schilling@fokus.fraunhofer.de> said:
> > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> said:
> > >> As a security fix it was sufficiently important that it had to be
> > >> done.
> > >
> > >IMO work-rounding this in kernel is a bad idea and could break a lot of
> > >existing apps (some you even don't know about).  Much better way to deal
> > >with this is to create library for handling I/O commands submission and
> > >gradually teach user-space apps to use it.
>
> Nonsense (as I just said in another message).

Please read Mark Lord's mail and my reply.

> > This is exactly what libscg is for......
> > libscg already includes similar support for Solaris 9 & Solaris 10.
>
> OK, their problem.
>
> > Cdrtools is is code freeze state. This is why I say the best idea is to
> > remove this interface change from the current Linux kernel and wait until
> > there will be new cdrtools alpha for 2.02 releases. These alpha could get
> > support for uid switching. If Linux then would again switch the changes
> > on, it makes sense.
>
> Sorry, you have absolutely no say in the development of the kernel
> here. You fix your broken app, code freeze or no code freeze. Or let others
> that fix it alone.
>
> > BTW: it makes absolutely no sense to have a list of "safe" commands in
> > the kernel as the kernel simply cannot know which SCSI commands are
> > "safe" and which not.
>
> "Normal" read/write commands are safe, others are off-limits unless you
> have the required capability (one which allows you to set the device on
> fire at will, that is).
>
> >                        The list would be if ever subject to changess on a
> > dayly base which is a real bad idea.
>
> Not unless standard SCSI commands change by the day. And I somewhat doubt
> that to be the case.

theory != practice

> > Note that having such a list of aparently safe commands would cause a lot
> > of untracable problems (why does it run for you but not for me....).
>
> Right. But better "Funny, it doesn't work here..." than "Sh*t! Another
> CD/DVD-writer turned into a brick!".

Horst, the fact that Joerg is hard to deal with and usually not right doesn't 
mean that he can't be right sometimes. ;-)

Bartlomiej
