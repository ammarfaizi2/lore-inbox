Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUHSRlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUHSRlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUHSRlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 13:41:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:44162 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266880AbUHSRh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 13:37:27 -0400
Message-Id: <200408191732.i7JHWSkL005470@laptop14.inf.utfsm.cl>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: B.Zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       fsteiner-mail@bio.ifi.lmu.de, diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices 
In-Reply-To: Message from Joerg Schilling <schilling@fokus.fraunhofer.de> 
   of "Thu, 19 Aug 2004 18:07:30 +0200." <4124D042.nail85A1E3BQ6@burner> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 19 Aug 2004 13:32:28 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> said:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> said:

> >> As a security fix it was sufficiently important that it had to be done.

> >IMO work-rounding this in kernel is a bad idea and could break a lot of
> >existing apps (some you even don't know about).  Much better way to deal
> >with this is to create library for handling I/O commands submission and
> >gradually teach user-space apps to use it.

Nonsense (as I just said in another message).

> This is exactly what libscg is for...... 
> libscg already includes similar support for Solaris 9 & Solaris 10.

OK, their problem.

> Cdrtools is is code freeze state. This is why I say the best idea is to
> remove this interface change from the current Linux kernel and wait until
> there will be new cdrtools alpha for 2.02 releases. These alpha could get
> support for uid switching. If Linux then would again switch the changes
> on, it makes sense.

Sorry, you have absolutely no say in the development of the kernel
here. You fix your broken app, code freeze or no code freeze. Or let others
that fix it alone.

> BTW: it makes absolutely no sense to have a list of "safe" commands in
> the kernel as the kernel simply cannot know which SCSI commands are
> "safe" and which not.

"Normal" read/write commands are safe, others are off-limits unless you
have the required capability (one which allows you to set the device on
fire at will, that is).

>                        The list would be if ever subject to changess on a
> dayly base which is a real bad idea.

Not unless standard SCSI commands change by the day. And I somewhat doubt
that to be the case.

> Note that having such a list of aparently safe commands would cause a lot of
> untracable problems (why does it run for you but not for me....).

Right. But better "Funny, it doesn't work here..." than "Sh*t! Another
CD/DVD-writer turned into a brick!".
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
