Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135518AbRANVsG>; Sun, 14 Jan 2001 16:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135587AbRANVr4>; Sun, 14 Jan 2001 16:47:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6925 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135564AbRANVrv>; Sun, 14 Jan 2001 16:47:51 -0500
Date: Sun, 14 Jan 2001 13:47:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <Pine.LNX.4.30.0101142107420.25589-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10101141344430.4505-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Jan 2001, David Woodhouse wrote:
> 
> That's the one flaw in the inter_module_get() stuff - we could do with a
> way to put entries in the table at _compile_ time, rather than _only_ at
> run time. 

Ok, I can buy that. Not having to initialize explicitly would be nice, but
if so we should make module loading do it automatically too, so that we
don't generate unnecessary differences between module and compiled in (ie
I'd rather avoid the situation that "if you're a module, you need to
explicitly export your inter_module_stuff(), while if you're compiled-in
it will be exported automatically").

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
