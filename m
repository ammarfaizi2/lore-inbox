Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315272AbSDWR1N>; Tue, 23 Apr 2002 13:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315273AbSDWR1M>; Tue, 23 Apr 2002 13:27:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21926 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315272AbSDWR1M>;
	Tue, 23 Apr 2002 13:27:12 -0400
Date: Tue, 23 Apr 2002 17:23:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
In-Reply-To: <1019580821.2045.85.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0204231722330.16139-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Apr 2002, Robert Love wrote:

> Now the hard part is abstracting sched_find_first_set for an arbitrary
> MAX_RT_PRIO.

i'd suggest the following: keep the current hand-optimized one for the
bitrange it's good for, and use the find_bit variant for all other values.  
(We had this before, check out some of the older versions of the O(1)  
scheduler.)

	Ingo

