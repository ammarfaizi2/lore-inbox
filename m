Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTLVSgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTLVSgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:36:12 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:61685 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S262745AbTLVSgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:36:08 -0500
Subject: Re: Oops with 2.4.23
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031222120557.A21530@netdirect.ca>
References: <20031219224402.GA1284@scrappy>
	 <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
	 <20031222021659.GA4857@ip68-4-255-84.oc.oc.cox.net>
	 <20031222120557.A21530@netdirect.ca>
Content-Type: text/plain
Message-Id: <1072118172.7007.32.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 13:36:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 12:05, Chris Frey wrote:
> At what point do people start suspecting the kernel?

Immediately. Maybe.  My problems seem to have been two-fold ('seem to'
because it could take up to a week to hit..).  First, the memory timings
listed by Kingston for this ram were way too aggressive for the ram+mobo
combo.  (FWIW, for anyone tracking this from the other thread, the epox
"if your motherboard sucks, use these" timings worked much better, and I
left cas at 2 instead of the epox-suggested 2.5. Oh, and memtest86
reported an -increase- in memory bandwidth with those settings.) And
second, the kernel didn't have erratta fixes and workarounds that MS
operating systems use to get io-apic running and stable, acpi stable,
etc...

> I mean, I would hope the linux kernel is not so badly written as to stress
> the machine 24/7.  So after 12 hours of running memtest86 with clean
> results, does that not begin to point to a software error rather than
> hardware?

Depends on the tests.  See my earlier results (and, if you want some
light reading, the memtest86 technical docs on the website) as an
example of why its important to run the full tests before fully
'certifying' a problem as software.  (Even though mine passed standard
tests, it failed extended.  And, for that matter, it passed both when I
first built it, before I put an OS on it.)

Evidently many people can look at an oops or crash path and be 90%
certain its bad/misperforming memory.  (How they do this I don't
know..)  I've noticed that 'check your ram' is not always given as the
answer, but it seems that most of the time when it is given its also
correct.

-- 
Disconnect <lkml@sigkill.net>

