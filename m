Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbTLRWzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbTLRWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:55:45 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:26817 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S265378AbTLRWyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:54:41 -0500
Date: Thu, 18 Dec 2003 23:53:25 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031218225324.GA24850@k3.hellgate.ch>
Mail-Followup-To: Rik van Riel <riel@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
	wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com
References: <20031217214107.GA3650@k3.hellgate.ch> <Pine.LNX.4.44.0312171921180.12531-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312171921180.12531-100000@chimarrao.boston.redhat.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 19:21:52 -0500, Rik van Riel wrote:
> > For efax, a benchmark run with mem=32M, the difference in run time
> > between values 256 and 1024 for /proc/sys/vm/min_free_kbytes is noise
> > (< 1%).
> 
> OK, so I guess you're not as close to the knee
> of the curve as this kind of tests tend to be ;)

Depends on the axis in your graph. The benchmarks I am using are not
balancing on the verge of going bad, if that's what you mean. They
cut deep (30 to 100 MB) into swap through most of their run time,
and there's quite a bit of swap turnover with compiling stuff.

I also completed a best effort attempt at determining the impact of
any differences between mem= and actual RAM removal. I had to adapt
the kbuild benchmark somewhat to the available hardware. I benchmarked
with 48 MB RAM at mem=16M and again after removing 32MB of RAM. If there
was a difference in performance, it was very small for both 2.4.23 and
2.6.0-test11, with the latter taking over 2.5 times as long to complete
the benchmark.

Roger
