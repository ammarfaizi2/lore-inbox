Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131574AbQJ2JiC>; Sun, 29 Oct 2000 04:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131589AbQJ2Jhw>; Sun, 29 Oct 2000 04:37:52 -0500
Received: from mail.bilboul.com ([193.117.73.30]:7945 "EHLO www.bilboul.com")
	by vger.kernel.org with ESMTP id <S131574AbQJ2Jhe>;
	Sun, 29 Oct 2000 04:37:34 -0500
From: Stephen Harris <sweh@spuddy.mew.co.uk>
Message-Id: <200010290920.JAA03918@spuddy.mew.co.uk>
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
To: vonbrand@sleipnir.valparaiso.cl (Horst von Brand)
Date: Sun, 29 Oct 2000 09:20:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200010282351.e9SNpjk11986@sleipnir.valparaiso.cl> from "Horst von Brand" at Oct 28, 2000 08:51:45 pm
X-Mailer: ELM [version 2.4 PL17]
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

> > > If you send SIGSTOP to syslogd on a Red Hat 6.2 system (glibc 2.1.3,
> > > kernel 2.2.x), within a few minutes you will find your entire machine
> > > grinds to a halt.  For example, nobody can log in.
> 
> Great! Yet another way in which root can get the rope to shoot herself in
> the foot. Anything _really_ new?

OK, let's go a step further - what if syslog dies or breaks in some way
shape or form so that the syslog() function blocks...?

My worry is the one that was originally raised but ignored:  syslog() should
not BLOCK regardless of whether it's local or remote.  syslog is not a
reliable mechanism and many programs have been written assuming they can
fire off syslog() calls without worry.

                                 Stephen Harris
                 sweh@spuddy.mew.co.uk   http://www.spuddy.org/
      The truth is the truth, and opinion just opinion.  But what is what?
       My employer pays to ignore my opinions; you get to do it for free.      
  * Meeeeow ! Call  Spud the Cat on > 01708 442043 < for free Usenet access *
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
