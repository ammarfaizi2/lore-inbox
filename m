Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbQLXW5M>; Sun, 24 Dec 2000 17:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbQLXW5D>; Sun, 24 Dec 2000 17:57:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28428 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130466AbQLXW4t>; Sun, 24 Dec 2000 17:56:49 -0500
Date: Sun, 24 Dec 2000 14:25:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tim Wright <timw@splhi.com>
cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <20001224125023.A1900@scutter.internal.splhi.com>
Message-ID: <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2000, Tim Wright wrote:
> > 
> > Which is all fine, but maybe the kernel really ought to detect that  
> > problem and complain at boot time?
> > 
> > Or does that happen already?
> 
> There was a similar thread to this recently. The issue is that if you
> choose the wrong processor type, you may not even be able to complain.

Indeed. Some of the issues end up just becoming compiler flags, which
means that anything that uses C is "tainted" by the processor choice. And
happily there isn't all that much non-C in the kernel any more.

One thing we _could_ potentially do is to simplify the CPU selection a
bit, and make it a two-stage process. Basically have a

	bool "Optimize for current CPU" CONFIG_CPU_CURRENT

which most people who just want to get the best kernel would use. Less
confusion that way.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
