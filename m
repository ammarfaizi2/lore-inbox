Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRA2XFS>; Mon, 29 Jan 2001 18:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRA2XE6>; Mon, 29 Jan 2001 18:04:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:57618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129610AbRA2XEy>; Mon, 29 Jan 2001 18:04:54 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Recommended swap for 2.4.x.
Date: 29 Jan 2001 15:04:14 -0800
Organization: Transmeta Corporation
Message-ID: <954ste$9nh$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com> <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>,
Alan Olsen  <alan@clueserver.org> wrote:
>
>What is the recommended amount of swap with the 2.4.x kernels?
>
>The standard rule is usually memory x 2.  (But that is more a Solaris
>superstition than anything else.)

"memory x 2" is probably a good rule. With normal usage patterns, at the
point you fully use up your swap, you _want_ the system to start killing
things off due to out-of-memory errors.

But there really is no "fixed" rule: it can depend a lot on your usage
patterns. Some people have a lot of big background processes that don't
have a big active footprint but that have a lot of "idle" pages that can
successfully be swapped out - using up tons of swap-space without
actually causing any bad behaviour.

And you might end up adding more memory.. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
