Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRKFAHZ>; Mon, 5 Nov 2001 19:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276057AbRKFAHP>; Mon, 5 Nov 2001 19:07:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275973AbRKFAHH>; Mon, 5 Nov 2001 19:07:07 -0500
Date: Mon, 5 Nov 2001 16:03:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.LNX.4.33.0111051543440.15533-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111051557520.1059-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Nov 2001, Linus Torvalds wrote:
>
> A five-time slowdown on real work _is_ pure hell. You've not shown a
> credible argument that the slow-growth behaviour would ever result in a
> five-time slowdown for _anything_.

There might also be heuristics that explicitly _notice_ slow growth, not
necessarily as a function of time, but as a function of the tree structure
itself.

For example, spreading out (and the inherent assumption of "slow growth")
might make sense for the root directory, and possibly for a level below
that. It almost certainly does _not_ make sense for a directory created
four levels down.

		Linus

