Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290666AbSBLBBv>; Mon, 11 Feb 2002 20:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290665AbSBLBBn>; Mon, 11 Feb 2002 20:01:43 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:42177 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290669AbSBLBBa>;
	Mon, 11 Feb 2002 20:01:30 -0500
Date: Mon, 11 Feb 2002 17:01:24 -0800
From: David Mosberger <davidm@hpl.hp.com>
Message-Id: <200202120101.g1C11OJZ010115@napali.hpl.hp.com>
To: anton@samba.org, davem@redhat.com
Subject: Re: thread_info implementation
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
In-Reply-To: <20020211.164617.39155905.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: 	Mon, 11 Feb 2002 16:46:17 -0800 (PST)
> From: "David S. Miller" <davem@redhat.com>
>
>    From: Anton Blanchard <anton@samba.org>
>    Date: Tue, 12 Feb 2002 07:50:48 +1100
>
>    On archs where we use a register to point to current I cant see why we
>    need this thread_info junk. I'd be happy if we could put it all in the
>    task struct for non intel.
>
> I am in fact very happy with the thread_info implementation
> on sparc64.
>
> I was able to blow away all of the assembler offset stuff because now
> all the stuff assembly wants to get at is in one structure and it is
> trivial to compute the offsets by hand.

I hope you don't consider this a good argument to force all the other
platforms to throw away their perfectly good low-core code.  Like
Anton, I do not expect any benefits from thread_info for ia64.  In
fact, if anything it's going to slow things down.  And we don't need
it for task coloring either.  We can do that perfectly fine with the
old setup.

Thanks,

	--david
