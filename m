Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVFILmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVFILmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVFILmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:42:17 -0400
Received: from web25807.mail.ukl.yahoo.com ([217.12.10.192]:29779 "HELO
	web25807.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262173AbVFILly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:41:54 -0400
Message-ID: <20050609114149.60315.qmail@web25807.mail.ukl.yahoo.com>
Date: Thu, 9 Jun 2005 13:41:49 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [TTY] exclusive mode question
To: Frederik Deweerdt <dev.deweerdt@laposte.net>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050609104140.GB507@gilgamesh.home.res>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :

> > > I've just greped and I found :
> > > 
> > > if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) &&
> > > !capable(CAP_SYS_ADMIN))
> > > 	retval = -EBUSY;
> > > in drivers/char/tty_io.c:tty_open
> > > 
> > > Which sources are you looking at?
> > > 
> > 
> > same source code but if another process has previously open the tty, how
> does
> > this source code detect it ?
> > 
> Sorry I misunderstood your question, there's no check on previous opens:
> from man tty_ioctl:
> 
>        TIOCEXCL  void
>               Put the tty into exclusive mode.  No _further_ open(2)
> operations  on  the  terminal  are  permitted.
>               (They will fail with EBUSY, except for root.)
> 

oh ok...sorry I misunderstood TIOEXCL meaning ;)
Do you know how I could implement such exclusive mode (the one I described) ?

thanks

            Francis


	
	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
