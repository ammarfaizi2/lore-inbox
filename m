Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRDDO0s>; Wed, 4 Apr 2001 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132827AbRDDO00>; Wed, 4 Apr 2001 10:26:26 -0400
Received: from chiara.elte.hu ([157.181.150.200]:40204 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S132830AbRDDOZc>;
	Wed, 4 Apr 2001 10:25:32 -0400
Date: Wed, 4 Apr 2001 15:23:34 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Hubertus Franke <frankeh@us.ibm.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: a quest for a better scheduler
In-Reply-To: <OFB30A8B18.2E3AD16C-ON85256A24.004BD696@pok.ibm.com>
Message-ID: <Pine.LNX.4.30.0104041518540.5382-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Apr 2001, Hubertus Franke wrote:

> I understand the dilemma that the Linux scheduler is in, namely
> satisfy the low end at all cost. [...]

nope. The goal is to satisfy runnable processes in the range of NR_CPUS.
You are playing word games by suggesting that the current behavior prefers
'low end'. 'thousands of runnable processes' is not 'high end' at all,
it's 'broken end'. Thousands of runnable processes are the sign of a
broken application design, and 'fixing' the scheduler to perform better in
that case is just fixing the symptom. [changing the scheduler to perform
better in such situations is possible too, but all solutions proposed so
far had strings attached.]

	Ingo

