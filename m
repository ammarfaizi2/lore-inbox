Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQJ3OH2>; Mon, 30 Oct 2000 09:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129430AbQJ3OHS>; Mon, 30 Oct 2000 09:07:18 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:35381 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129208AbQJ3OHN>; Mon, 30 Oct 2000 09:07:13 -0500
Date: Mon, 30 Oct 2000 08:06:19 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200010301406.IAA224051@tomcat.admin.navo.hpc.mil>
To: pollard@cats-chateau.net, Stephen Harris <sweh@spuddy.mew.co.uk>,
        vonbrand@sleipnir.valparaiso.cl (Horst von Brand)
Subject: Re: syslog() blocks on glibc 2.1.3 with kernel 2.2.x
In-Reply-To: <00102910423100.15754@tabby>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

Jesse Pollard <pollard@cats-chateau.net>:
> On Sun, 29 Oct 2000, Stephen Harris wrote:
> >Horst von Brand wrote:
> >
> >> > > If you send SIGSTOP to syslogd on a Red Hat 6.2 system (glibc 2.1.3,
> >> > > kernel 2.2.x), within a few minutes you will find your entire machine
> >> > > grinds to a halt.  For example, nobody can log in.
> >> 
> >> Great! Yet another way in which root can get the rope to shoot herself in
> >> the foot. Anything _really_ new?
> >
> >OK, let's go a step further - what if syslog dies or breaks in some way
> >shape or form so that the syslog() function blocks...?
> >
> >My worry is the one that was originally raised but ignored:  syslog() should
> >not BLOCK regardless of whether it's local or remote.  syslog is not a
> >reliable mechanism and many programs have been written assuming they can
> >fire off syslog() calls without worry.
> 
> It was NOT ignored. If syslogd dies, then the system SHOULD stop, after a
> few seconds (depending on the log rate...).
> 
> I do believe that restarting syslog should be possible... Perhaps syslog
> should be started by inetd at the very beginning. Then it could be restarted
> after an exit/abort.
> 
> This can STILL fail if the syslog.conf is completely invalid - but then the
> system SHOULD be stopped pending the investigation of why the file has been
> corrupted, or syslogd falls back on a default configuration (record everything
> in the syslog file).

As was pointed out in a separate E-mail: I ment to say "init" instead of
"inetd", since inetd can generate syslog messages...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
