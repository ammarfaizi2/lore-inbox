Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317981AbSHLNR3>; Mon, 12 Aug 2002 09:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSHLNR3>; Mon, 12 Aug 2002 09:17:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12493 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317981AbSHLNR3>;
	Mon, 12 Aug 2002 09:17:29 -0400
Date: Mon, 12 Aug 2002 17:20:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <julliard@winehq.com>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <1029146896.16216.113.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208121717290.19150-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2002, Alan Cox wrote:

> Which does mean you can steal the old TLS value and put it back across
> the calls just by changing the TLS data for that process. [...]

yes - the 0x40 segment can be saved & restored safely. We have per-CPU
GDTs so nobody can modify them while the APM BIOS is executing. (assuming
preemption is disabled.)

> [...] For that matter on Windows emulation I thought Windows also needed
> 0x40 to be the same offset as the BIOS does so can't we leave it
> hardwired ?

another thing: do we want this with descriptor priviledge level 3? Because
the APM 0x40 GDT entry was a ring 0 descriptor, but that would not be
accessible to Wine or DOSEMU.

	Ingo

