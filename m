Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbTFARFj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264671AbTFARFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:05:39 -0400
Received: from miranda.zianet.com ([216.234.192.169]:6931 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264670AbTFARFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:05:37 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Jonathan Lundell <linux@lundell-bros.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030601165252.GD3012@work.bitmover.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601132626.GA3012@work.bitmover.com>
	 <20030601134942.GA10750@alpha.home.local>
	 <20030601140602.GA3641@work.bitmover.com>
	 <p05210609baffd3a79cfb@[207.213.214.37]>
	 <20030601161133.GC3012@work.bitmover.com> <1054485978.19557.93.camel@spc>
	 <20030601165252.GD3012@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054487927.19551.99.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Jun 2003 11:18:47 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 10:52, Larry McVoy wrote:
> > Thanks for the input.  You've convinced me.  When going through
> > arch/ppc/xmon/xmon.c, I will leave things like the following unchanged:
> > 
> > /* Command interpreting routine */
> > static int
> > cmds(struct pt_regs *excp)
> > {
> 
> Great.
> 
> > My changes will be similar to the following:
> > 
> > @@ -1837,9 +1818,7 @@
> >         return *lineptr++;
> >  }
> > 
> > -void
> > -take_input(str)
> > -char *str;
> > +void take_input(char *str)
> >  {
> >         lineptr = str;
> >  }
> 
> OK, I'm confused.  You said you were convinced but then shouldn't that be
> 
> void
> take_input(char *str)
> {
>        lineptr = str;
> }
> 
> ??
Yeah, I realized the inconsistency of that after sending.  This is with
that change backed out (same as your example above):

@@ -1838,8 +1819,7 @@
 }

 void
-take_input(str)
-char *str;
+take_input(char *str)
 {
        lineptr = str;
 }


My guiding principle in all this is "first, do no harm".  That's why I
posted my question in the first place.  Thanks for the help.

Steven

