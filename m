Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbTBQOoV>; Mon, 17 Feb 2003 09:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTBQOnJ>; Mon, 17 Feb 2003 09:43:09 -0500
Received: from mx1.elte.hu ([157.181.1.137]:27115 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267287AbTBQOnB>;
	Mon, 17 Feb 2003 09:43:01 -0500
Date: Mon, 17 Feb 2003 15:52:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Don't wake up tasks on offline processors
In-Reply-To: <Pine.LNX.4.50.0302170933150.18087-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0302171551090.24755-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Zwane Mwaikambo wrote:

> Ok i'll have a go at that instead, however how hard would it be to do a
> multiple lock acquisition of that magnitude on 16+ cpus?

just do a simple loop of spin_lock()'s over all online CPUs, in forward
order, ordering between runqueue locks is ordered by CPU number.

	Ingo

