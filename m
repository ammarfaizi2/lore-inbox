Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263924AbRFEIwQ>; Tue, 5 Jun 2001 04:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263925AbRFEIwG>; Tue, 5 Jun 2001 04:52:06 -0400
Received: from chiara.elte.hu ([157.181.150.200]:36367 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S263924AbRFEIvx>;
	Tue, 5 Jun 2001 04:51:53 -0400
Date: Tue, 5 Jun 2001 10:49:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Akash Jain <aki.jain@stanford.edu>, <linux-kernel@vger.kernel.org>,
        <su.class.cs99q@nntp.stanford.edu>
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <E156o6c-0005AB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106051047460.2339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Jun 2001, Alan Cox wrote:

> >  - the kernel stack is 4kB, and _nobody_ has the right to eat up a
> >    noticeable portion of it. It doesn't matter if you "know" your caller
>
> Umm Linus on what platform - its 8K or more on all that I can think of

it's 8K-sizeof(struct task_struct). On x86, the size of task_struct is
getting near to 2K already, and it's not getting smaller in the future, so
4K is a safe thing.

	Ingo


