Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135491AbREAVUZ>; Tue, 1 May 2001 17:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135857AbREAVUP>; Tue, 1 May 2001 17:20:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33796 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135491AbREAVT7>; Tue, 1 May 2001 17:19:59 -0400
Date: Tue, 1 May 2001 14:19:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <20010501204543.B3541@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0105011417320.2667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 May 2001, Russell King wrote:
>
> Talking around this issue, is there any chance of getting the
> official use of the first parameter to ioremap documented in
> Documentation/IO-mapping.txt please?  There appears to be
> confusion as to whether it is:
>
> a) PCI bus address
> b) CPU untranslated address

It's neither.

It's a cookie that you can do arithmetic off and pass on to the
readx/writex, and nothing more. You cannot make any assumptions at all
about what it means.

In particular, you can _not_ assume that it is a PCI bus address ("WHICH
bus?") and you can absolutely not assume that it is a CPU address (many
CPU's do not "memory map" PCI at all).

		Linus

