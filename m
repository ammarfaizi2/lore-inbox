Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267973AbSIRRlR>; Wed, 18 Sep 2002 13:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267981AbSIRRlR>; Wed, 18 Sep 2002 13:41:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33796 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267973AbSIRRlQ>; Wed, 18 Sep 2002 13:41:16 -0400
Date: Wed, 18 Sep 2002 10:46:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Ingo Molnar <mingo@elte.hu>, Andries Brouwer <aebr@win.tue.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918173653.GV3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209181044240.1384-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, William Lee Irwin III wrote:
> 
> There were only 10K tasks, with likely consecutively-allocated PID's,
> and some minor background fork()/exit() activity, but there are more
> offenders on the read side than get_pid() itself.
> 
> There is no question of PID space: the full 2^30 was configured in
> the tests done after the PID space expansion. 

I bet the lockup was something else. There have been other bugs recently 
with the task state changes, and the lockup may just have been a regular 
plain lockup. Thread exit has been kind of fragile lately, although it 
looks better now.

		Linus

