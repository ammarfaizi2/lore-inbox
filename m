Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUF1Q0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUF1Q0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUF1Q0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:26:16 -0400
Received: from mout2.freenet.de ([194.97.50.155]:49294 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S265058AbUF1QYh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:24:37 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: Nice 19 process still gets some CPU
Date: Mon, 28 Jun 2004 18:23:59 +0200
User-Agent: KMail/1.6.2
References: <40E03C2D.5000809@techsource.com> <40E0449F.5050104@nortelnetworks.com>
In-Reply-To: <40E0449F.5050104@nortelnetworks.com>
Cc: Con Kolivas <kernel@kolivas.org>, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406281824.01836.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Chris Friesen <cfriesen@nortelnetworks.com>:
> Timothy Miller wrote:
> > 
> > 
> > Con Kolivas wrote:
> > 
> >  >
> >  > It definitely should _not_ starve. That is the unixy way of doing
> >  > things. Everything must go forward. Around 5% cpu for nice 19 sounds
> >  > just right. If you want scheduling only when there's spare cpu cycles
> >  > you need a sched batch(idle) implementation.
> >  >
> >  >
> > 
> > Well, since I can't rewrite the app, I can't make it sched batch.  Nice
> > values are an easy thing to get at for anything that's running.
> 
> Sure you can.  You can set the scheduler policy on any process in the system, 
> while its running.
> 
> int sched_setscheduler(pid_t pid, int policy, const struct sched_param *p);
> 
> Takes about two minutes to write an equivalent to "nice" to set scheduler 
> policies and priorities.

Sounds cool. I was searching this syscall for a long time, now. :)
But batch scheduling is available in -ck only, so this works only
with -ck kernels. Correct?

> Chris

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4EYfFGK1OIvVOP4RAogAAKCQ8oYHshIKPXYNAVptHh1QJRRfywCfX8Cg
GxzK64XtYdtnJLReOMrzR3o=
=ithN
-----END PGP SIGNATURE-----
