Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRDSRjT>; Thu, 19 Apr 2001 13:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRDSRjK>; Thu, 19 Apr 2001 13:39:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:48141 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131587AbRDSRjF>; Thu, 19 Apr 2001 13:39:05 -0400
Date: Thu, 19 Apr 2001 10:38:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.GSO.4.21.0104191249200.16930-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0104191036220.5052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Alexander Viro wrote:
>
> Ehh... Non-lazy variant is just read() and write() as down_failed() and
> up_wakeup() Lazy... How about

Looks good to me. Anybody want to try this out and test some benchmarks?

There may be problems with large numbers of semaphores, but hopefully that
won't be an issue. And the ability to select/poll on these things might
come in handy for various implementation issues (ie locks with timeouts
etc).

		Linus

