Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTHVPNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTHVPNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:13:17 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:34227 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S263497AbTHVPNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:13:10 -0400
Date: Fri, 22 Aug 2003 17:11:50 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] new scheduler policy
Message-ID: <20030822151150.GA27508@k3.hellgate.ch>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F4182FD.3040900@cyberone.com.au> <20030822085508.GA10215@k3.hellgate.ch> <3F4615D8.9030200@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4615D8.9030200@cyberone.com.au>
X-Operating-System: Linux 2.6.0-test3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003 23:08:40 +1000, Nick Piggin wrote:
> >I timed a pathological benchmark from hell I've been playing with lately.
> >Three consecutive runs following a fresh boot. Time is in seconds:
> >
> >2.4.21			821	21	25
> >2.6.0-test3-mm1		724	946	896
> >2.6.0-test3-mm1-nick	905	987	997
> >
> >Runtime with ideal scheduling: < 2 seconds (we're thrashing).
> >
> 
> Cool. Can you post the benchmark source please?

http://hellgate.ch/code/ploc/thrash.c

A parallel kernel build can generate some decent thrashing, too, but I
wanted a short and simple test case that conveniently provides the
information I need for both logging daemon and post processing tool.

Note: The benchmark could trivially be made more evil which would prevent
2.4.21 from finishing over 30 times faster (as it often does). I
intentionally left it they way it is.

While everybody seems to be working on interactivity, I am currently
looking at this corner case. This should be pretty much orthogonal to your
own work.

Roger
