Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbTBQCDo>; Sun, 16 Feb 2003 21:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbTBQCDn>; Sun, 16 Feb 2003 21:03:43 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65042 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264920AbTBQCDn>; Sun, 16 Feb 2003 21:03:43 -0500
Date: Sun, 16 Feb 2003 21:10:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre4 comparison bugs
In-Reply-To: <20030208232510.GA1841@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1030216210059.29049F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, J.A. Magallon wrote:

> So:
> 
> unsgined f()
> {
> 	return -1;
> }
> 
> if ((int)f()<0)
> ??
> 
> Wouldn't you get killed by some kind of bit/sign extension in the return ?
> Just to be sure, probably the answer is just 'go learn C internals'...

Fuzzy thinking and non-portable. I think the answer is that someone didn't
put enough thought into the error returns. This is trickery to avoid
defining an error value to return. One of those "it works on most
compilers and computers" things. Definitely low human readability. If the
return value is always small enough to be positive if cast to (int), why
not return int? Can't say without looking at actual code rather than a
general example.

Because it mostly works, I'm not sure what priority a more readable return
code would have, though.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

