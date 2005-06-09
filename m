Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVFIMQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVFIMQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVFIMQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:16:44 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:9621 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262368AbVFIMQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:16:21 -0400
Message-ID: <20050609121613.43867.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 9 Jun 2005 14:16:13 +0200 (CEST)
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

> Le 09/06/05 11:59 +0200, moreau francis écrivit:
> > 
> > --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> > 
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

BTW, I don't see any use of this mode since it can't ensure that nothing is
using the tty...Do you know what kind of purpose it is for ?

               Francis


	
	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
