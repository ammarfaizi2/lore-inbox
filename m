Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279891AbRJ3Hgn>; Tue, 30 Oct 2001 02:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279889AbRJ3Hgd>; Tue, 30 Oct 2001 02:36:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279891AbRJ3Hg1>; Tue, 30 Oct 2001 02:36:27 -0500
Date: Mon, 29 Oct 2001 23:34:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: i/o stalls on 2.4.14-pre3 with ext3
In-Reply-To: <3BDE4B56.F90300C5@zip.com.au>
Message-ID: <Pine.LNX.4.33.0110292332210.8287-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Andrew Morton wrote:
>
> Hum.   I did a quick test here.  cvs checkout of a kernel
> tree with source and dest both on the same platter.  Using
> ext2:
>
> 2.4.13: 	1:34
> 2.4.14-pre3:	1:28
> 2.4.14-pre5:	1:37
>
> We need more silly bugs.

Well, considering that the silly bug could result in request queue
corruption, I really suspect you'll be happier without it ;)

The io_request_lock wasn't held in a critical place, which would
potentially improve performance, but ...

> I'll poke at it a bit more.  One perennial problem which
> we face is that there isn't, IMO, a good set of tests for tracking
> changes in thoughput.  All the tools which are readily available
> are good for stress testing and silly corner cases but they
> don't seem to model real-world workloads well.

Agreed.

		Linus

