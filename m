Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276829AbRJHWLz>; Mon, 8 Oct 2001 18:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276800AbRJHWLq>; Mon, 8 Oct 2001 18:11:46 -0400
Received: from web10301.mail.yahoo.com ([216.136.130.79]:25361 "HELO
	web10301.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276445AbRJHWLi>; Mon, 8 Oct 2001 18:11:38 -0400
Message-ID: <20011008221209.26310.qmail@web10301.mail.yahoo.com>
Date: Mon, 8 Oct 2001 23:12:09 +0100 (BST)
From: "=?iso-8859-1?q?J.D.=20Hood?=" <jdthood@yahoo.co.uk>
Subject: Re: Linux should not set the "PnP OS" boot flag
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011008152542.J12242@come.alcove-fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Stelian Pop <stelian.pop@fr.alcove.com> wrote: 
> Anyway, the PnP OS setting in the BIOS doesn't change anything
> regarding to the Linux PnP initialisation oops (same printouts,
> same calltrace, etc).

Too bad.  :(

Although it apparently won't help Stelian, I still think it's
good practice (1) to set the boot flags to what's safe, and
then (2) to give the user the ability to change the default if
s/he wants to try speeding things up.

(Parenthesis re: time savings
Alan: You say that setting the PnP-OS flag can save up to
thirty seconds at boot time.  My suspicion is that it may
actually be the diagnostics that take up all these seconds
(e.g., testing each of 128 million memory locations), not
the configuration process.  Are you sure that it isn't
clearing the DIAG flag that's important for time savings,
not setting the PNPOS flag?)

It's useful to be able to select a different default at build
time (CONFIG_SBF_PNPOS).  But in addition I would like to provide
/proc access to the bootflags.  That way, if I suspect a hardware
problem I can "echo 1 > /proc/sys/bootflags/diag" and reboot; or
if I am going to boot DOS I can "echo 0 > /proc/sys/bootflags/pnpos"
and reboot.  Question: Where should I put these entries under 
/proc.  Are my examples okay?

--
Thomas


____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
