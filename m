Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277146AbRJHVaA>; Mon, 8 Oct 2001 17:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277144AbRJHV3v>; Mon, 8 Oct 2001 17:29:51 -0400
Received: from tangens.hometree.net ([212.34.181.34]:30898 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S277147AbRJHV3e>; Mon, 8 Oct 2001 17:29:34 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [OT] testing internet performance, esp latency/drops?
Date: Mon, 8 Oct 2001 21:30:03 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9pt5sr$eqb$1@forge.intermeta.de>
In-Reply-To: <20011008090203.L26223@work.bitmover.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1002576603 8135 212.34.181.4 (8 Oct 2001 21:30:03 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 8 Oct 2001 21:30:03 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

>However, web browsing sucks.  On about 80% of all links, there is a noticable
>hesitation, between 1-15 seconds, as it looks up the name and as it fetches
>the first page.  After that point, that site will appear to be OK.

This means, that 80% of all web site operators are too dumb to
configure a web server. Is it possible that your brand spanking new T1
addresses have no reverse name resolution? Are you using a proxy?

Look:

lm@bitmover   IP 1.2.3.4
    |
    |
"i want to surf to http://www.surf.xxx/"
    |
    |
    v
Website "www.surf.xxx"

"connect from 1.2.3.4" -> "Lookup for 4.3.2.1.IN-ADDR.ARPA"
                                       |
                                       |
                            1-15 Second timeout, "addr not found"
                                       |
                                       |
                                       v
                            send HTTP page to 1.2.3.4 anyway.


>Before I wander off to write a test for this, I'm wondering if anyone 
>knows of a test suite or a methodology which works.  I was thinking 

This has nothing to do with OSes, Linux or even a kernel. It is just
that most people on this net (and also most people who operate servers
or work at ISPs) are complete idiots that neither know how to operate
a webserver (set it to "name lookup off" and do address resolving for
web statistics offline) or an ip-space (how to setup a reverse
resolution).

I did consulting for an ISP that has > 50 Class C networks and not
_one_ had right forward and reverse resolution [1] as I arrived there.

	Regards
		Henning

[1] Now it has. ;-)      


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
