Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUBDUUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266470AbUBDUUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:20:10 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:4417 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S266458AbUBDUTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:19:34 -0500
Date: Wed, 4 Feb 2004 21:19:33 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 15/42]
Message-ID: <20040204201933.GA1240@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan> <20040202194631.GO6785@dreamland.darkstar.lan> <Pine.LNX.4.58L.0402041445480.1324@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0402041445480.1324@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Wed, Feb 04, 2004 at 02:46:01PM -0200, Marcelo Tosatti ha scritto: 
> > ../fdomain.c:565: warning: `fdomain_setup' defined but not used
> >
> > fdomain_setup isn't used when the driver is modular.
> >
> > diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/fdomain.c linux-2.4/drivers/scsi/fdomain.c
> > --- linux-2.4-vanilla/drivers/scsi/fdomain.c	Sat Jan 31 15:54:42 2004
> > +++ linux-2.4/drivers/scsi/fdomain.c	Sat Jan 31 17:21:13 2004
> > @@ -561,6 +561,7 @@
> >     printk( "\n" );
> >  }
> >
> > +#ifndef MODULE
> >  static int __init fdomain_setup( char *str )
> >  {
> >  	int ints[4];
> > @@ -584,6 +585,7 @@
> >  }
> >
> >  __setup("fdomain=", fdomain_setup);
> > +#endif
> >
> >
> >  static void do_pause( unsigned amount )	/* Pause for amount*10 milliseconds */
> 
> What?
> 
> from fdomain.c:
> 
> #ifdef MODULE
>         if (fdomain)
>                 fdomain_setup(fdomain);
> #endif

Sorry, I misread the #ifdef. Drop the patch.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel
