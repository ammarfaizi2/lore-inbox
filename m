Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272295AbRIRPoX>; Tue, 18 Sep 2001 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272280AbRIRPoN>; Tue, 18 Sep 2001 11:44:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:28266 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272270AbRIRPoH>; Tue, 18 Sep 2001 11:44:07 -0400
Date: Tue, 18 Sep 2001 17:44:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: jogi@planetzork.ping.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11: alsaplayer skiping during kernel build (-pre10 did not)
Message-ID: <20010918174434.I19092@athlon.random>
In-Reply-To: <20010918171416.A6540@planetzork.spacenet> <20010918172500.F19092@athlon.random> <20010918173515.B6698@planetzork.spacenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010918173515.B6698@planetzork.spacenet>; from jogi@planetzork.ping.de on Tue, Sep 18, 2001 at 05:35:15PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:35:15PM +0200, jogi@planetzork.ping.de wrote:
> Since I am not using md there are not that much changes left between
> -pre10 and -pre11. Or do you think that it is caused by the console
> locking changes?

certainly not from the console locking changes. Can you just go back to
pre10 and verify you don't get those skips to just to be 100% sure the
userspace config is the same?

The only scheduler change in pre11 is this one:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.10pre10aa1/00_sched-rt-fix-1

which should be infact a bugfix for rt threads, also discussed on l-k
recently, so it's not clear how this odd regression happened.

You can try to back it out and see if helps just in case.

Andrea
