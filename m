Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSJNTEX>; Mon, 14 Oct 2002 15:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbSJNTEX>; Mon, 14 Oct 2002 15:04:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38890 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262100AbSJNTEW>;
	Mon, 14 Oct 2002 15:04:22 -0400
Date: Mon, 14 Oct 2002 21:21:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [RFC] Rename _bh to _softirq 
In-Reply-To: <5.1.0.14.2.20021014115238.084140f8@mail1.qualcomm.com>
Message-ID: <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Oct 2002, Maksim (Max) Krasnyanskiy wrote:

> Old BHs have been almost completely replaced with tasklets and softirqs.
> Should we then rename _bh to _softirq ?
> i.e
>          local_bh_disable()      ->      local_softirq_disable()
>          spin_lock_bh()          ->      spin_lock_softirq()
>          bh_lock_sock()          ->      softirq_sock_lock()
>          etc

i wanted to do this as part of the irqlock cleanups, but generally we dont
change existing interfaces unless it's really universally agreed upon. Eg.  
we had cli() around for a *long* time although it's an x86 (-mostly)
instruction name. But yes, i agree, and there are a number of other
renames that would make perfect sense.

	Ingo

