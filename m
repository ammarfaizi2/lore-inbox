Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLWRxD>; Sat, 23 Dec 2000 12:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLWRwx>; Sat, 23 Dec 2000 12:52:53 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129352AbQLWRws>; Sat, 23 Dec 2000 12:52:48 -0500
Date: Sat, 23 Dec 2000 09:21:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Chen <michaelc@turbolinux.com.cn>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn>
Message-ID: <Pine.LNX.4.10.10012230920330.2066-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Dec 1999, michael chen wrote:
>         I found that when I compiled the 2.4 kernel with the option
>     of Pentium III or Pentium 4 on a Celeron's PC, it could cause  the
>     system hang at very beginning boot stage, and I found the problem
>     is cause by the fact that Intel Celeron doesn't have a real memory
>     barrier,but when you choose the Pentium III option, the kernel
>     assume the processor has a real memory barrier.
>     Here is a patch to fix it:

No.

The fix is to not lie to the configurator.

A Celeron isn't a PIII, and you shouldn't tell the configure that it is.

The whole point of being able to choose the CPU to optimize for is that we
can optimize things at compile-time.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
