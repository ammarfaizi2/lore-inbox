Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131331AbRCNI2u>; Wed, 14 Mar 2001 03:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131332AbRCNI2l>; Wed, 14 Mar 2001 03:28:41 -0500
Received: from limes.hometree.net ([194.231.17.49]:1657 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S131331AbRCNI2e>; Wed, 14 Mar 2001 03:28:34 -0500
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2001 08:12:06 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <98n94m$5pt$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <20010314015921.19287.qmail@web11808.mail.yahoo.com>, <15022.53815.129522.746120@pizda.ninka.net>
Reply-To: hps@tanstaafl.de
Subject: Re: poll() behaves differently in Linux 2.4.1 vs. Linux 2.2.14 (POLLHUP)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davem@redhat.com (David S. Miller) writes:

>Jeffrey Butler writes:
> >   I've noticed that poll() calls on IPv4 sockets do
> > not behave the same under linux 2.4 vs. linux 2.2.14. 
> > Linux 2.4 will return POLLHUP for a socket that is not
> > connected (and has never been connected) while Linux
> > 2.2 will not.
> >   The following example program demonstrates the
> > problem when it's run under linux 2.4:

>True, this behavior was changed from 2.2.x.  We now match the behavior
>of other svr4 systems, in particular Solaris.  This new behavior in
>2.4.x will not change.

Hi,

but Jeffrey wrote:

--- cut ---
JB> Other operating systems (not that they are necessarily
JB> correct) also output the same as Linux 2.2.14.  I
JB> tried this on FreeBSD 4.4.1, Solaris 5.7 (on a SPARC),
JB> and Windows 2000 with Cygwin 1.1.7.
--- cut ---

This is BSD, SysVR4 and an abomination all behaving like 2.2.x and not
2.4.x (which confuses the heck out of a poll()-using daemon
here... :-) )

I'd prefer not to have too many user space surprises in moving from
2.2 to 2.4.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
