Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262012AbSIVJts>; Sun, 22 Sep 2002 05:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbSIVJts>; Sun, 22 Sep 2002 05:49:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4304 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262012AbSIVJtr>;
	Sun, 22 Sep 2002 05:49:47 -0400
Date: Sun, 22 Sep 2002 12:02:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Cort Dougan <cort@fsmlabs.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020922003448.GU1345@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0209221157030.19753-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Andrea Arcangeli wrote:

> Nevertheless the current get_pid is very bad when the tasklist grows and
> the pid space is reduced, [...]

> It may not be the best for a 1million pid case, but certainly it is a
> must have for 2.4 and I think it could be ok for 2.5 too. It is been
> submitted for 2.5 a number of times, I quote below the 2.4 version just
> so you know what I'm talking about exactly [...]

Andrea, the new PID allocator (and new pidhash) went into 2.5.37, there's
no get_pid() anymore. Do we agree that the runtime-bitmap hack^H^H^H^patch
is now moot for 2.5?

	Ingo


