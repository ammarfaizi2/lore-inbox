Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273229AbRIPXTZ>; Sun, 16 Sep 2001 19:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273228AbRIPXTQ>; Sun, 16 Sep 2001 19:19:16 -0400
Received: from chiara.elte.hu ([157.181.150.200]:56590 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273210AbRIPXTA>;
	Sun, 16 Sep 2001 19:19:00 -0400
Date: Mon, 17 Sep 2001 01:16:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] multipath RAID personality, 2.4.10-pre9
In-Reply-To: <20010916150806.E1541@turbolinux.com>
Message-ID: <Pine.LNX.4.33.0109170113010.3960-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Sep 2001, Andreas Dilger wrote:

> I'm not sure I understand why this is here? [...]

(it's mostly an outdated and incorrect comment.)

> If we are talking about a multipath situation, there IS only a single
> disk, so which path is chosen is mostly irrelevant. [...]

yes, but not necesserily so. If there is a physically redundant topology
of connections that are otherwise equivalent (the majority of today's
solution are not in this category), then it might make sense to 'load
balance' between available paths. We are prepared to do this,
architecturally.

> [...] Also, it is my understanding that with some multipath hardware,
> if you read from the "backup" path it will kill access to the primary
> path (this can be used when more than one system access shared disk
> for failover).  As a result, we should always read from the "primary"
> path for each disk unless there is an error.

yes, and this is being done currently, only the primary path is used.

	Ingo

