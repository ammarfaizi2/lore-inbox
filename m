Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318846AbSIISy1>; Mon, 9 Sep 2002 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSIISy0>; Mon, 9 Sep 2002 14:54:26 -0400
Received: from [63.209.4.196] ([63.209.4.196]:19472 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318846AbSIISxN>; Mon, 9 Sep 2002 14:53:13 -0400
Date: Mon, 9 Sep 2002 12:01:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: do_syslog/__down_trylock lockup in current BK
In-Reply-To: <Pine.LNX.4.44.0209092052250.30743-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0209091154270.14841-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Ingo Molnar wrote:
> 
> i can reproduce the following lockup in BK-current, SMP:

Hmm. The only potential lockup source I could see is that semaphore
waitqueue spinlock. 

>  >>EIP; c0106c57 <__down_trylock+a7/b4>   <=====

Are you sure your system.map is correct? __down_trylock() should _not_ be 
that big - it's just 67 bytes for me (and apparently almost three times 
the size for you). Spinlock debugging or something?

		Linus

