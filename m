Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287109AbSAZVnj>; Sat, 26 Jan 2002 16:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287106AbSAZVn3>; Sat, 26 Jan 2002 16:43:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:272 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287109AbSAZVnN>; Sat, 26 Jan 2002 16:43:13 -0500
Date: Sat, 26 Jan 2002 13:42:52 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <012d01c1a687$faa11120$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.33.0201261339220.17628-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 Jan 2002, Martin Eriksson wrote:
>
> Hmm.. I tried to compile the kernel with -Os (gcc 2.96-98) and I just got a
> ~1% smaller vmlinux and a ~3% smaller bzImage.

Note that while "-Os" exists and is documented, as far as I know gcc
doesn't actually do much with it. It really acts mostly as a "disable
certain optimizations" than anything else.

In the 3.0.x tree, it seems to change some of the weights of some
instructions, and it might make more of a difference there. But at the
same time it is quite telling that "-Os" doesn't even change any of the
alignments etc - because gcc developers do not seem to really support it
as a real option. It's an after-thought, not a big performance push.

		Linus

