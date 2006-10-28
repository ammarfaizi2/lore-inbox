Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWJ1TSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJ1TSG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWJ1TSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:18:06 -0400
Received: from teetot.devrandom.net ([66.35.250.243]:55182 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1751359AbWJ1TSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:18:04 -0400
Date: Sat, 28 Oct 2006 12:18:00 -0700
From: thockin@hockin.org
To: Willy Tarreau <w@1wt.eu>
Cc: Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028191800.GA20701@hockin.org>
References: <1161969308.27225.120.camel@mindpipe> <1162006081.27225.257.camel@mindpipe> <20061028052837.GC1709@1wt.eu> <200610281137.22451.ak@suse.de> <20061028191515.GA1603@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028191515.GA1603@1wt.eu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 09:15:15PM +0200, Willy Tarreau wrote:
> > While gtod is time critical and often appears high on profile lists it is 
> > normally not as time critical as you're claiming it is; especially not
> > time critical enough to warrant such radical action.
> 
> Yes it was, because the small gain of using a dual core with such
> a workload was clearly lost by that change. IIRC, I reached 25000
> sessions/s on dual core with TSC if I didn't care about the clock,
> 20000 without TSC, and 18000 on single core+TSC. But with the sniffer,
> it was even worse : I had 500 kpps in dual-core+TSC, 70kpps without
> TSC and 300 kpps with single-core+TSC. Since I had to buy the same
> machines for both uses, this last argument was enough for me to stick
> to a single core.

Was the problem that they were not synced at poweron or that they would
drift due to power-states?

Did you try running with idle=poll, to avoid ever entering C1 state (hlt)?

