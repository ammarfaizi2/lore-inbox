Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268064AbUHTJH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268064AbUHTJH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 05:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHTJF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 05:05:28 -0400
Received: from pop.gmx.net ([213.165.64.20]:38620 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267737AbUHTJCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 05:02:40 -0400
Date: Fri, 20 Aug 2004 11:02:36 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: roland@redhat.com, torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <28571.1092981652@www22.gmx.net>
Subject: Re: [PATCH] waitid system call
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <20310.1092992556@www22.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

Just to follow up with one more data point.

> I did some more investigaton and testing:
> 
> -- Tru64 5.1 behaves like Solaris 8 -- si_pid == 0 for
>    the WNOHANG with no children case.
> 
> -- HP-UX 11 is different -- not even POSIX compliant.  It
>    returns -1 with ECHILD in this scenario.  
> 
> -- According to the man pages, waitid() is also present on
>    Irix 6.5 and UnixWare 7, but I don't have access to 
>    those systems to run a test (my earlier test program
>    would be sufficient to test on those systems).
> 
> So, discounting the non-compliant HP-UX, on other 
> implementations we have 2 out of 2 for the "si_pid == 0"
> behavior.  (I will see if I can get access to other
> systems for further testing.)  So, how about 
> reconsidering the approach for Linux?

Someone has supplied with me with a data point for Irix 6.5 
(and 6.2).  Irix behaves like Solaris 8.  So that's 3 out 
of 3 for the "si_pid == 0" behavior (plus a buggy HP-UX 11).
I will try to get a Unixware data point, but that will 
probably take several days.  (I wonder if anyone can supply 
an AIX data point?)

Cheers,

Michael

Cheers,

Michael

-- 
NEU: Bis zu 10 GB Speicher für e-mails & Dateien!
1 GB bereits bei GMX FreeMail http://www.gmx.net/de/go/mail

