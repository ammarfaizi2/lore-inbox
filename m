Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSHLKx3>; Mon, 12 Aug 2002 06:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317861AbSHLKx3>; Mon, 12 Aug 2002 06:53:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11709 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317859AbSHLKx3>;
	Mon, 12 Aug 2002 06:53:29 -0400
Date: Mon, 12 Aug 2002 14:55:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <julliard@winehq.com>, <ldb@ldb.ods.org>
Subject: Re: [patch] tls-2.5.31-C3
In-Reply-To: <1029152837.16424.157.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208121454580.14271-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Aug 2002, Alan Cox wrote:

> > ugh, we do Linux interrupts while in the APM BIOS?
> 
> We have to. Most APM bios expects interrupts to be happening. In
> pre-emptive mode we may well even be switching to/from APM BIOS code in
> 2.5 at the moment. I've not looked into that.

i think that since we hold the APM spinlock (do we always, when calling
into the APM BIOS?), we should not preempt any APM BIOS code.

	Ingo

