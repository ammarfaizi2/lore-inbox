Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbSITQVS>; Fri, 20 Sep 2002 12:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSITQVS>; Fri, 20 Sep 2002 12:21:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52435 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262829AbSITQVS>;
	Fri, 20 Sep 2002 12:21:18 -0400
Date: Fri, 20 Sep 2002 18:34:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Oleg Drokin <green@namesys.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <20020920154347.A12399@namesys.com>
Message-ID: <Pine.LNX.4.44.0209201828090.8547-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Oleg Drokin wrote:

> I mean it is only safe to use such spinlock-based function if all other
> places read and write this value via special functions that are also
> taking this spinlock.

yes - but this is true in this specific PID allocator case, we only access
it via cmpxchg().

	Ingo


