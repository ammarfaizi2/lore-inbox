Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270350AbTHBTTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbTHBTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:19:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:39442 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S270524AbTHBTOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:14:38 -0400
Date: Sat, 2 Aug 2003 21:14:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10
Message-ID: <20030802191433.GD13525@alpha.home.local>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet> <20030801224753.GA912@alpha.home.local> <1059817370.1868.5.camel@tux.rsn.bth.se> <20030802181007.GB13525@alpha.home.local> <1059848925.1869.22.camel@tux.rsn.bth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059848925.1869.22.camel@tux.rsn.bth.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 08:28:46PM +0200, Martin Josefsson wrote:
 
> Uhm, my tests have shown it to be very fast and efficient. But I didn't
> look to see if all packets got through to the logfile. But getting it to
> write logs at ~35MB/s wasn't a problem.

I clearly didn't reach these numbers, I used LOGEMU, and while you're at it,
I must say that when I speak about 1500/s, it's about logs _written_ down.
The firewall can still can process 5k sessions/s, but looses many logs (3.5k
every second).

When I read the LOGEMU code, I had the impression that it was given more as
a proof of concept than anything else. Because there are many many many
"fprintf(of, something_trivial_enough_to_support_memcpy)".

> Did you specify --ulog-qthreshold 50 ?
> and did you specify --ulog-cprange at all? if you don't it will copy the
> entire packet to userspace. I copy 64 bytes to userspace and that's more
> than enough to log everything needed.

honnestly, i't 6 months old in my head, and I don't remember with which
parameters I played. But I'd happily restart a bench if you have some tuning
advices (provided that they are compatible with basic production constraints,
such as log rotation, and a few CPU left for monitoring processes :-))
I cannot promise to to it within a few days though.

Cheers,
Willy

