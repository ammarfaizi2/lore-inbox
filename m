Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311618AbSDSGwc>; Fri, 19 Apr 2002 02:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311701AbSDSGwb>; Fri, 19 Apr 2002 02:52:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40423 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S311618AbSDSGwa>;
	Fri, 19 Apr 2002 02:52:30 -0400
Date: Fri, 19 Apr 2002 06:48:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] migration thread fix
In-Reply-To: <20020419064851.GC21206@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0204190646380.4350-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Apr 2002, William Lee Irwin III wrote:

> > a HT box wouldnt boot without an artificial mdelay(1000) in
> > migration_init() - while i havent fully debugged it (given Erich's patch),
> > it appeared to be some sort of race between idle thread startup and
> > migration init.
> 
> I've got a few of those around, I'll see if I can reproduce it. How many
> cpu's did you need to bring it out?

2 physical - but i'd suggest to test Erich's patch instead. I had
debugging code in the scheduler which did printks, which slowed down some
of the operations in question, such as the startup of the idle thread -
which created weird situations. [which might not occur in normal testing,
but which are possible nevertheless.]

	Ingo

