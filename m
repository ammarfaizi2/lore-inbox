Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135567AbRANV54>; Sun, 14 Jan 2001 16:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRANV5h>; Sun, 14 Jan 2001 16:57:37 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:61702 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S135567AbRANV53>; Sun, 14 Jan 2001 16:57:29 -0500
Date: Sun, 14 Jan 2001 21:57:20 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, <kaos@ocs.com.au>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <Pine.LNX.4.10.10101141344430.4505-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101142149490.25589-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Jan 2001, Linus Torvalds wrote:
> On Sun, 14 Jan 2001, David Woodhouse wrote:
> > That's the one flaw in the inter_module_get() stuff - we could do with a
> > way to put entries in the table at _compile_ time, rather than _only_ 
> > at run time. 

> Ok, I can buy that. Not having to initialize explicitly would be nice, but
> if so we should make module loading do it automatically too, so that we
> don't generate unnecessary differences between module and compiled in (ie
> I'd rather avoid the situation that "if you're a module, you need to
> explicitly export your inter_module_stuff(), while if you're compiled-in
> it will be exported automatically").

Yep. Modutils can probably handle that case without too much difficulty, 
if we go with sticking the static inter_module_entries in a special ELF 
section as I originally suggested. Keith?

-- 
dwmw2




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
