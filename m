Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbRGSVzR>; Thu, 19 Jul 2001 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbRGSVzH>; Thu, 19 Jul 2001 17:55:07 -0400
Received: from t2.redhat.com ([199.183.24.243]:21494 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266069AbRGSVyv>; Thu, 19 Jul 2001 17:54:51 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz> 
In-Reply-To: <917E9842025@vcnet.vc.cvut.cz> 
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: bitops.h ifdef __KERNEL__ cleanup. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Jul 2001 22:53:32 +0100
Message-ID: <11472.995579612@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


VANDROVE@vc.cvut.cz said:
>  If you do not want kernel headers to be used in apps, just move them
> from asm and linux into msa and xunil. Then you can simple remove all
> #ifdef __KERNEL__ from them...

It has been stated many times that kernel headers should not be used in
apps. Renaming or moving them should not be necessary - and people would
probably only start to use them again anyway. We'd see autoconf checks to 
find whether it's linux/private.h or xunil/private.h :)

In the absence of any expectation that userspace developers will ever obey
the simple and oft-repeated rule that you don't use kernel headers from
userspace, the #ifdef __KERNEL__ approach would seem to be the best on
offer.

> P.S.: Part of ncpfs's configure.ac. I do not think that it is that
> hard...

I'm not very familiar with autoconf, but doesn't the snippet you pasted just 
check that the program compiles and links? It won't notice if you build a 
binary with privileged instructions in, or one which just fails to provide 
the correct semantics when the routine is used in a environment for which 
it was not designed?

Where is this used in ncpfs that it makes _such_ a difference?

--
dwmw2


