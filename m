Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbSIRR4c>; Wed, 18 Sep 2002 13:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268631AbSIRR4b>; Wed, 18 Sep 2002 13:56:31 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:47320 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S268515AbSIRRzj>;
	Wed, 18 Sep 2002 13:55:39 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 18 Sep 2002 11:58:35 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918115835.B656@host110.fsmlabs.com>
References: <20020918113551.A654@host110.fsmlabs.com> <Pine.LNX.4.44.0209182001110.25303-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209182001110.25303-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Sep 18, 2002 at 08:02:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're talking about a different problem there.  Creating a thread within a
realistic time-limit for a sensible number of threads is not a bad idea.
Doing it for a huge number of threads may not be something that has to be
done right away.  Don't screw up the low to middle-end - that trend is
getting frightening in Linux.

} sorry, but creating a new thread within some realistic time limit,
} independently of how all the other threads are layed out, is not something
} i'd give up trying to solve.
