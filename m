Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129905AbQJ2Rkt>; Sun, 29 Oct 2000 12:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130356AbQJ2Rkj>; Sun, 29 Oct 2000 12:40:39 -0500
Received: from zeus.kernel.org ([209.10.41.242]:12303 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129905AbQJ2RkV>;
	Sun, 29 Oct 2000 12:40:21 -0500
From: Stephen Harris <sweh@spuddy.mew.co.uk>
Message-Id: <200010291718.RAA19325@spuddy.mew.co.uk>
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
To: pollard@cats-chateau.net
Date: Sun, 29 Oct 2000 17:18:22 +0000 (GMT)
Cc: vonbrand@sleipnir.valparaiso.cl, linux-kernel@vger.kernel.org
In-Reply-To: <00102910423100.15754@tabby> from "Jesse Pollard" at Oct 29, 2000 10:35:27 am
X-Mailer: ELM [version 2.4 PL17]
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was NOT ignored. If syslogd dies, then the system SHOULD stop, after a

Huh?  "SHOULD"?   Why?  If syslog dies for any reason (bug, DOS, hack,
admin stupidity) then I sure don't want the system freezing up.

( heh...  at work on Solaris I monitor 300+ systems, and it's not unusual
to find 1 box a week with syslog not running for some reason or another.
I can't decide whether it's admin stupidity or bugs in Solaris syslog - of
which there are many :-(( )

syslog is not meant to be a secure audit system.  Messages can be
legitimately dropped.   Applications have been coded assuming that they
will not be frozen in syslog().  Linux should not be different in this
respect.   Hmm... it might be nice to be this a system tunable parameter
but I'm not sure the best way of doing that (glibc maybe?)

                                 Stephen Harris
                 sweh@spuddy.mew.co.uk   http://www.spuddy.org/
      The truth is the truth, and opinion just opinion.  But what is what?
       My employer pays to ignore my opinions; you get to do it for free.      
  * Meeeeow ! Call  Spud the Cat on > 01708 442043 < for free Usenet access *
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
