Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSHZTY6>; Mon, 26 Aug 2002 15:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSHZTY6>; Mon, 26 Aug 2002 15:24:58 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:17171
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S317772AbSHZTYR>; Mon, 26 Aug 2002 15:24:17 -0400
Subject: Re: [patch] clone-detached-2.5.31-B0
From: Robert Love <rml@tech9.net>
To: Pavel Machek <pavel@elf.ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020826123528.GB359@elf.ucw.cz>
References: <Pine.LNX.4.44.0208132307340.12804-100000@localhost.localdomain>
	<Pine.LNX.4.44.0208151715320.2982-100000@localhost.localdomain> 
	<20020826123528.GB359@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 15:28:25 -0400
Message-Id: <1030390106.15007.306.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 08:35, Pavel Machek wrote:

> > --- kernel/signal.c.orig	Thu Aug 15 17:12:02 2002
> > +++ kernel/signal.c	Thu Aug 15 17:12:34 2002
> > @@ -774,7 +774,7 @@
> >  	int why, status;
> >  
> >  	/* is the thread detached? */
> > -	if (sig == -1 || tsk->exit_signal == -1)
> > +	if (sig == -1)
> >  		BUG();
> >  
> >  	info.si_signo = sig;
> 
> Why not BUG_ON()?

Ingo has said previously that he does not like the syntax of BUG_ON.

I disagree, but it is his code - what we _should_ do here is mark the
branch unlikey() if nothing else.

	Robert Love

