Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbSIYINR>; Wed, 25 Sep 2002 04:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbSIYINR>; Wed, 25 Sep 2002 04:13:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27309 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261943AbSIYINQ>;
	Wed, 25 Sep 2002 04:13:16 -0400
Date: Wed, 25 Sep 2002 10:26:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Drokin <green@namesys.com>
Cc: "David S. Miller" <davem@redhat.com>, <zaitcev@redhat.com>,
       <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: cmpxchg in 2.5.38
In-Reply-To: <20020925120725.A23559@namesys.com>
Message-ID: <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Oleg Drokin wrote:

> Ingo's argument was that since there is only one place in code that
> accesses that variable (map->page), it is safe to rely on such a
> crippled cmpxchg implementation.

yes. It's only this place in the code that ever modifies that word, and
that happens only once during the lifetime of this address, so i'll rather
add a spinlock to the generic PID allocator code, it's a very very rare
slowpath.

	Ingo

