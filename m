Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUBVU0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUBVU0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:26:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:18359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261743AbUBVU0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:26:48 -0500
Date: Sun, 22 Feb 2004 12:32:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
In-Reply-To: <c1b2f9$sfj$1@terminus.zytor.com>
Message-ID: <Pine.LNX.4.58.0402221230390.1395@ppc970.osdl.org>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
 <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz>
 <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org> <c1b2f9$sfj$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Feb 2004, H. Peter Anvin wrote:
> 
> The above code is just plain wrong: the cast to (unsigned long) has
> higher precedence than the shift, so on i386 (which I presume this is)
> it will become an unsigned long, and the shifts will bring it down to
> zero.

WHICH IS WHAT WE WANT. On x86.

But ..

> You might as well write zero if that's what you mean.

No. Because on x86-64 it is NOT zero. Because there "unsigned long" is
64-bit, and it results in the high 32 bits. Which is, again, exactly what
we want.

Guys, give it up. The code is not only already committed, it's simply the 
best way to do what it does.

		Linus
