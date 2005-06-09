Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVFIKli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVFIKli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 06:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVFIKli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 06:41:38 -0400
Received: from mailfe05.swip.net ([212.247.154.129]:47274 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262342AbVFIKl1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 06:41:27 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Thu, 9 Jun 2005 12:41:40 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
Subject: Re: [TTY] exclusive mode question
Message-ID: <20050609104140.GB507@gilgamesh.home.res>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	Frederik Deweerdt <dev.deweerdt@laposte.net>,
	linux-kernel@vger.kernel.org
References: <20050609093642.GA507@gilgamesh.home.res> <20050609095927.59628.qmail@web25803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050609095927.59628.qmail@web25803.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/06/05 11:59 +0200, moreau francis écrivit:
> 
> --- Frederik Deweerdt <dev.deweerdt@laposte.net> a écrit :
> 
> > I've just greped and I found :
> > 
> > if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) &&
> > !capable(CAP_SYS_ADMIN))
> > 	retval = -EBUSY;
> > in drivers/char/tty_io.c:tty_open
> > 
> > Which sources are you looking at?
> > 
> 
> same source code but if another process has previously open the tty, how does
> this source code detect it ?
> 
Sorry I misunderstood your question, there's no check on previous opens:
from man tty_ioctl:

       TIOCEXCL  void
              Put the tty into exclusive mode.  No _further_ open(2) operations  on  the  terminal  are  permitted.
              (They will fail with EBUSY, except for root.)

Emphasis mine.
Regards,
Frederik Deweerdt
