Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTJaNDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTJaNDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:03:17 -0500
Received: from mail5.bluewin.ch ([195.186.1.207]:2006 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S263259AbTJaNCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:02:45 -0500
Date: Fri, 31 Oct 2003 13:59:42 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Con Kolivas <kernel@kolivas.org>
Cc: Rik van Riel <riel@redhat.com>, Chris Vine <chris@cvine.freeserve.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031031125942.GA11854@k3.hellgate.ch>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	Rik van Riel <riel@redhat.com>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	linux-kernel@vger.kernel.org
References: <200310292230.12304.chris@cvine.freeserve.co.uk> <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <20031031112615.GA10530@k3.hellgate.ch> <200310312337.34778.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310312337.34778.kernel@kolivas.org>
X-Operating-System: Linux 2.6.0-test9 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 23:37:34 +1100, Con Kolivas wrote:
> Yes it will show improvement, and I would like to hear how much given how 

I've been sitting on my data because I was waiting for the missing
pieces from my test box, but here's a data point: For my test case,
your patch improves run time from 500 to 440 seconds.

> simple it is, but I agree with you. There is an intrinsic difference in the 
> vm in 2.6 that makes it too hard for multiple running applications to have a 

My (probably surprising to many) finding is that there _isn't_
an intrinsic difference which makes 2.6 suck. There are a number of
_separate_ issues, and they are only related in their contribution to
making 2.6 thrashing behavior abysmal.

What I'm trying to find out is whether the issues are intrinsic to
a change in some mechanisms (which typically means it's a price we
have to pay for other benefits) or if they are just problems with the
implementation. I had tracked down vm_swappiness as one problem, and
your solution shows that the implementation could indeed be improved
without touching the fundamental VM workings at all.

Roger
