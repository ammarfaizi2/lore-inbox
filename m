Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAXHvr>; Wed, 24 Jan 2001 02:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129776AbRAXHvh>; Wed, 24 Jan 2001 02:51:37 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:2565 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129742AbRAXHv1>; Wed, 24 Jan 2001 02:51:27 -0500
Date: Tue, 23 Jan 2001 23:51:15 -0800
From: Richard Henderson <rth@twiddle.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010123235115.A14786@twiddle.net>
In-Reply-To: <20010110163158.F19503@athlon.random> <200101102209.f0AM9N803486@flint.arm.linux.org.uk> <20010111005924.L29093@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010111005924.L29093@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 12:59:24AM +0100, Andrea Arcangeli wrote:
> What I said is that I can write this C code:
> 
> 	int x[2], * p = (int *) (((char *) &x)+1);
> 	main()
> 	{
> 		*p = 0;
> 	}
> 
> This is legal C code.

Err, no.  This is not "legal" by any stretch of the imagination.
This code has undefined behaviour.

As such, it may work, it may sigbus, it may write data at some
address unrelated to "x", or it may start World War III (with
appropriate hardware attached).

We aren't even obliged to allow this to compile.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
