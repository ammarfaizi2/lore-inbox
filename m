Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272090AbRIRPZD>; Tue, 18 Sep 2001 11:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272135AbRIRPYx>; Tue, 18 Sep 2001 11:24:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31332 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272090AbRIRPYv>; Tue, 18 Sep 2001 11:24:51 -0400
Date: Tue, 18 Sep 2001 17:25:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: jogi@planetzork.ping.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
Message-ID: <20010918172500.F19092@athlon.random>
In-Reply-To: <20010918171416.A6540@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918171416.A6540@planetzork.spacenet>; from jogi@planetzork.ping.de on Tue, Sep 18, 2001 at 05:14:16PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:14:16PM +0200, jogi@planetzork.ping.de wrote:
> Hello Andrea,
> 
> I gave your new vm a try and I have to report a problem. System is an
> Athlon 1200 with 256MB memory. Workload:
> 
> 1. top refreshing every second reniced to -10
> 2. alsaplayer -n -q -r *.wav
> 3. make -j4 bzImage modules
> 
> The problem is that with 2.4.10-pre11 alsaplayer is skiping very much.
> Almost every ten seconds and then the break seems to be relatevily long
> (like >1s). With 2.4.10-pre10 I noticed alsaplayer skiping once or twice

the skips shouldn't really be realated to vm changes, if something to
the schedrt fix. but the real issue is that you should avoid to run top
at -10 (or you meant +10?). Running top at -10 isn't a good idea, it is
allowing it to get more cpu than the other tasks for no good reason.

Andrea
