Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265242AbTLaVEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 16:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbTLaVEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 16:04:46 -0500
Received: from mail3.bluewin.ch ([195.186.1.75]:64656 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S265242AbTLaVEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 16:04:44 -0500
Date: Wed, 31 Dec 2003 22:03:54 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jens Axboe <axboe@suse.de>
Cc: Thomas Molina <tmolina@cablespeed.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andy Isaacson <adi@hexapodia.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031231210354.GA9804@k3.hellgate.ch>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Thomas Molina <tmolina@cablespeed.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain> <20031230132145.B32120@hexapodia.org> <20031230194051.GD22443@holomorphy.com> <20031230222403.GA8412@k3.hellgate.ch> <Pine.LNX.4.58.0312301921510.3193@localhost.localdomain> <20031231101741.GA4378@k3.hellgate.ch> <20031231112119.GB3089@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231112119.GB3089@suse.de>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 12:21:19 +0100, Jens Axboe wrote:
> > Thanks. 2.5.39 alone will do, actually. I'm just curious how far the
> > similarity between qsbench and bk export goes.
> 
> 2.5.39 is when the deadline io scheduler was merged. How do you define
> the qsbench suckiness?

2.5.39 was the biggest regression for qsbench (fixed later, most notably
in 2.5.41). 2.5.39 was a significant improvement for efax ("fixed"
in 2.5.43).

All I'm doing here is reading the graph I posted at:
http://hellgate.ch/bench/thrash.tar.gz

For the systematic testing, I used "qsbench -p 4 -m 96" on a 256 MB
machine. This allowed the kernel to achieve high performance with
unfairness -- that's what 2.4 does: One process dominates all others
and finishes very early, taking away most of the memory pressure.
The spike for qsbench in 2.5.39 remains if only one process is forked
(-p1 -m 384), though.

I asked for the bk export numbers with 2.5.39 because I'm curious how
close to qsbench the behavior really is.

> Do you have numbers for 2.4.x and 2.6.1-rc with
> the various io schedulers (it would be interesting to see stock,
> elevator=deadline, and elevator=noop).

I planned to compare the io schedulers in 2.6.0 anyway. Do you expect
different numbers for a recent bk snapshot?

Roger
