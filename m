Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbQLUK7d>; Thu, 21 Dec 2000 05:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130891AbQLUK7O>; Thu, 21 Dec 2000 05:59:14 -0500
Received: from dell-pe2450-1-eth0.cambridge.redhat.com ([172.16.18.1]:19973
	"HELO executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S130356AbQLUK7C>; Thu, 21 Dec 2000 05:59:02 -0500
Date: Thu, 21 Dec 2000 10:28:09 +0000 (GMT)
From: Bernd Schmidt <bernds@redhat.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Steve Grubb <ddata@gate.net>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] performance enhancement for simple_strtoul
In-Reply-To: <20001221101656.B8388@emma1.emma.line.org>
Message-ID: <Pine.LNX.4.30.0012211026390.24769-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Matthias Andree wrote:
>
> x * 10 can be written as:
>
> (x << 2 + x) << 1   = (4x+x) * 2
> (x << 3) + (x << 1) = 8x + 2x

Or as "x * 10".  Which has the advantage of actually being readable, and
letting the compiler optimize it into one of the other forms if that's
profitable on the machine you are compiling for.

Why do you guys bother making strtoul run fast anyway?  Surely it's not on
any critical path in the kernel?


Bernd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
