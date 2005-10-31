Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVJaKSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVJaKSG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVJaKSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:18:06 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:29874 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S932429AbVJaKSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:18:05 -0500
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
In-Reply-To: <53qJ9-1YO-5@gated-at.bofh.it>
References: <53bh4-4UB-5@gated-at.bofh.it> <53qzy-1yA-7@gated-at.bofh.it> <53qJ9-1YO-5@gated-at.bofh.it>
Date: Mon, 31 Oct 2005 11:17:56 +0100
Message-Id: <E1EWWjk-000583-NS@shinjuku.zaphods.net>
From: "Stefan Schmidt,,," <zaphodb@shinjuku.zaphods.net>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: zaphodb@shinjuku.zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> Unfortunately, the machine does quite a bit of other work apart from BIND, so
> unless somebody can reproduce this on another machine, it will be a bit
> difficult.

I saw the same error with 2.6.14-rc5 and filed bug #5505 against it. I
was also able to reproduce the behaviour using the same kernel and same
library/compiler versions on another machine using the same set of zones
and tcpreplay to simulate the query load. Our machine gets around 10
queries per second at ~40k slave zones. BIND version is 9.3.2v1 which
runs smoothly on our in-production nameserver with kernel 2.6.13.4 now.

netdev and the usual suspects are aware of the problem.

	Stefan
