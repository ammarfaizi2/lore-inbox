Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318016AbSHLNKO>; Mon, 12 Aug 2002 09:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSHLNKO>; Mon, 12 Aug 2002 09:10:14 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32204 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318016AbSHLNKN>;
	Mon, 12 Aug 2002 09:10:13 -0400
Date: Mon, 12 Aug 2002 17:12:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <1029154707.4258.28.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208121708050.19150-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2002, Luca Barbieri wrote:

> Numbers:
> unconditional copy of 2 tls descs: 5 cycles
> this patch with 1 tls desc: 26 cycles
> this patch with 8 tls descs: 52 cycles

[ 0 tls descs: 2 cycles. ]

but yes, this is rougly what i'd say this approach costs.

> lldt: 51 cycles
> lgdt: 50 cycles
> context switch: 2000 cycles (measured with pipe read/write and vmstat so
> it's not very accurate)

> So this patch causes a 1% context switch performance drop for
> multithreaded applications.

how did you calculate this? glibc multithreaded applications can avoid the
lldt via using the TLS, and thus it's a net win.

	Ingo

