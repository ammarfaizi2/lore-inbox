Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTGVHqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 03:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267520AbTGVHqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 03:46:39 -0400
Received: from sun13.bham.ac.uk ([147.188.128.145]:6567 "EHLO sun13.bham.ac.uk")
	by vger.kernel.org with ESMTP id S262439AbTGVHqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 03:46:37 -0400
Subject: Re: pre6 oddity (fwd)
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030720081321.GC643@alpha.home.local>
References: <Pine.LNX.4.55L.0307191805200.11090@freak.distro.conectiva>
	 <20030720081321.GC643@alpha.home.local>
Content-Type: text/plain
Organization: University Of Birmingham
Message-Id: <1058860900.31625.3.camel@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jul 2003 09:01:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Confirmed - I updated to procps 3.1.11 and the oddity with the display
is gone.

Thanks Willy.

Mark

On Sun, 2003-07-20 at 09:13, Willy Tarreau wrote:
> Hi Marcelo,
> 
> This was a procps bug. 2.0.11 I believe. There was something like a
> printf("%ull", prio) with prio=-1, which prints 2^64-1 (the high number seen
> here). Upgrading to 2.0.13 fixed the problem for me.
> 
> Cheers,
> Willy
> 
> On Sat, Jul 19, 2003 at 06:07:42PM -0300, Marcelo Tosatti wrote:
> > 
> > Bogus.
> > 
> > ---------- Forwarded message ----------
> > Date: 19 Jul 2003 08:54:55 +0100
> > From: Mark Cooke <mpc@star.sr.bham.ac.uk>
> > To: Marcelo Tosatti <marcelo@conectiva.com.br>
> > Subject: pre6 oddity
> > 
> > Hi Marcelo,
> > 
> > On two of my machines running pre6, I am seeing top report very odd
> > priorities for two kernel tasks:
> > 
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
> > COMMAND
> > 
> >     8 root     18446744073709551615 -20     0    0     0 SW<   0.0
> > 0.0   0:00   0 mdrecoveryd
> >    16 root     18446744073709551615 -20     0    0     0 SW<   0.0
> > 0.0   0:00   0 raid1d
> > 
> > 
> > Something related to the scheduling changes going on ?
> > 
> > (RedHat 9 base system)
> > 
> > Mark
> > 
> > -- 
> > Mark Cooke <mpc@star.sr.bham.ac.uk>
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mark Cooke <mpc@star.sr.bham.ac.uk>
University Of Birmingham

