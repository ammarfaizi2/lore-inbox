Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbSLIUCe>; Mon, 9 Dec 2002 15:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266122AbSLIUCe>; Mon, 9 Dec 2002 15:02:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20393 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S266116AbSLIUCd>;
	Mon, 9 Dec 2002 15:02:33 -0500
Date: Mon, 9 Dec 2002 21:13:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
In-Reply-To: <3DF3A3FA.D1571CCD@digeo.com>
Message-ID: <Pine.LNX.4.44.0212092109270.6663-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Dec 2002, Andrew Morton wrote:

> Yes, thanks.  Will we also be seeing the "interactivity estimator" fixes
> in 2.5?

yes, but i'd like to clarify one more thing - worst-case O(1)  
interactivity indeed is indeed very jerky (eg. the fast window moving
thing you noticed), but the normal behavior is much better than the old
scheduler's. Just try compiling the kernel with make -j4 under stock 2.4
and _everything_ in X will be jerky. With the O(1) scheduler things are
just as smooth as on an idle system - as long as your application does not
get rated CPU-intensive. [which happens too fast in the case you
described.] So we do have something in 2.5 that is visibly better in a
number of cases, and i want to preserve that - while fixing the
corner-cases discussed here. I'm working on it.

	Ingo

