Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSLICzZ>; Sun, 8 Dec 2002 21:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSLICzZ>; Sun, 8 Dec 2002 21:55:25 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:23707 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S262442AbSLICzY>; Sun, 8 Dec 2002 21:55:24 -0500
Message-ID: <3DF407E2.E974D5F8@attbi.com>
Date: Sun, 08 Dec 2002 22:02:58 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Everyone,

I ran into a lockup with the O(1) scheduler back in August and
exchanged email with Andrea. I tried a couple of his patches.
They prevented the lockup but it was still easy to have the
X server exiled to the inactive array for seconds at a time.
This got me started working on a patch to make the schedule
more fair.

I posted a patch archive here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103508412423719&w=2

It fixes fairness but breaks nice(2). Rik van Riel has a
patch here which builds on my patch which fixes this:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103651801424031&w=2

I tested the combination of these patches with linux-2.5.48 and
it seems well behaved:-)  

I found this problem with the LTP waitpid06 test.  It actually
produced a live-lock. See this mail:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103133744217082&w=2

I have been distracted by Posix timers but I plan to get back
finish this.

Jim Houston - Concurrent Computer Corp.
