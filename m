Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268350AbSIRRtF>; Wed, 18 Sep 2002 13:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbSIRRsP>; Wed, 18 Sep 2002 13:48:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18158 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268335AbSIRRra>;
	Wed, 18 Sep 2002 13:47:30 -0400
Date: Wed, 18 Sep 2002 19:59:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918173653.GV3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209181958440.25303-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, William Lee Irwin III wrote:

> There were only 10K tasks, with likely consecutively-allocated PID's,
> and some minor background fork()/exit() activity, but there are more
> offenders on the read side than get_pid() itself.
> 
> There is no question of PID space: the full 2^30 was configured in the
> tests done after the PID space expansion.

oh. Well, there are a whole lot of other places in the unpatched kernel
that iterate over every task. So with the patch applied, all these lockups
go away?

	Ingo

