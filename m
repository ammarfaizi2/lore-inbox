Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132763AbRDURSf>; Sat, 21 Apr 2001 13:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbRDURSZ>; Sat, 21 Apr 2001 13:18:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:41742 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132765AbRDURSN>; Sat, 21 Apr 2001 13:18:13 -0400
Date: Sat, 21 Apr 2001 10:18:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>,
        "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem
 benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
In-Reply-To: <20010421151737.A7576@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0104211017180.17558-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Apr 2001, Russell King wrote:
>
> Erm, spin_lock()?  What if up_read or up_write gets called from interrupt
> context (is this allowed)?

Currently that is not allowed.

We allow it for regular semaphores, but not for rw-semaphores.

We may some day have to revisit that issue, but I suspect we won't have
much reason to.

		Linus

