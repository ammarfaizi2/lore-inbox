Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131138AbRAURyj>; Sun, 21 Jan 2001 12:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131245AbRAURy3>; Sun, 21 Jan 2001 12:54:29 -0500
Received: from [216.151.155.116] ([216.151.155.116]:12806 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S131138AbRAURyS>; Sun, 21 Jan 2001 12:54:18 -0500
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: leitner@convergence.de, linux-kernel@vger.kernel.org
Subject: Re: Off-Topic: how do I trace a PID over double-forks?
In-Reply-To: <200101211747.LAA84311@tomcat.admin.navo.hpc.mil>
From: Doug McNaught <doug@wireboard.com>
Date: 21 Jan 2001 12:54:11 -0500
In-Reply-To: Jesse Pollard's message of "Sun, 21 Jan 2001 11:47:17 -0600 (CST)"
Message-ID: <m33dec7pvg.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> writes:

> Ummm ... basicly a "respawn" entry in the inittab is enough for that.

Nope, see below.

> If you wanted sendmail then:
> 
> sndm:234:respawn:/usr/lib/sendmail -bd -q15m
> 
> Will restart sendmail whenever it aborts in runleves 2,3, or 4.

Sendmail in daemon mode forks right away, and the child is the
daemon.  All init will know is that the process it started exited
right away, and you'll get a "respawning too fast" message.

I don't recall if there's an option to sendmail that says "be a
daemon, but run in the foreground."  Probably is, for debugging.

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
