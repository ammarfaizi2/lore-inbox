Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTDVPnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbTDVPnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:43:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41447 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263212AbTDVPnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:43:09 -0400
Date: Tue, 22 Apr 2003 11:55:00 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Andrea Arcangeli <andrea@suse.de>, <mingo@elte.hu>, <hugh@veritas.com>,
       <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030422154248.GI8978@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0304221152500.10400-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, William Lee Irwin III wrote:

> I have to apologize for my misstatements of the problem here. You
> yourself pointed out to me the hold time was, in fact, linear. Despite
> the linearity of the algorithm, the failure mode persists. I've
> postponed further investigation until later, when more invasive
> techniques are admissible; /proc/ alone will not suffice if linear
> algorithms under tasklist_lock can trigger this failure mode.

well, i have myself reproduced 30+ secs worth of pid-alloc related lockups
on my box, so it's was definitely not a fata morgana, and the
pid-allocation code was definitely quadratic near the PID-space saturation
point.

There might be something else still biting your system, i'd really be
interested in hearing more about it. What workload are you using to
trigger it?

	Ingo

