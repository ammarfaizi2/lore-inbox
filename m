Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTEAPtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTEAPtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:49:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26117 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261433AbTEAPtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:49:06 -0400
Date: Thu, 1 May 2003 09:02:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Willy Tarreau <willy@w.ods.org>
cc: Daniel Phillips <dphillips@sistina.com>,
       Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <20030501091944.GA15827@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0305010852400.3055-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 1 May 2003, Willy Tarreau wrote:
>
>  BTW, has someone benchmarked BSF/BSR on x86 ? It should be
> faster, it it's also possible that a poor microcode implements it with a one
> bit/cycle algo, which will result in one instruction not being as fast as your
> code.

I think the original i386 did it with a one-bit-per-cycle algorithm,
anything since should be fine. In particular, on a P4 where I just tested,
the bsf seems to be 4 cycles over the whole input set (actually, my whole
loop was 4 cycles per iteration, so 4 cycles is worst-case. I'm assuming
the rest could have been done in parallell).

		Linus

