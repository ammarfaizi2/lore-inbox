Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSFLUGI>; Wed, 12 Jun 2002 16:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSFLUGH>; Wed, 12 Jun 2002 16:06:07 -0400
Received: from waste.org ([209.173.204.2]:29075 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313190AbSFLUGH>;
	Wed, 12 Jun 2002 16:06:07 -0400
Date: Wed, 12 Jun 2002 15:05:47 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>, <frankeh@watson.ibm.com>
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.44.0206120946100.22189-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0206121459110.30179-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Linus Torvalds wrote:

> Any amount of tracking would be _extremely_ expensive. Right now getting
> an uncontended lock is about 15 CPU cycles in user space.
>
> Tryin to tell the kernel about gettign that lock takes about 1us on a P4
> (system call overhead), ie we're talking 18000 cycles. 18 THOUSAND cycles
> minimum. Compared to the current 15 cycles. That's more than three orders
> of magnitude slower than the current code, and you just lost the whole
> point of doing this all in user space in the first place.

That doesn't rule out approaches like storing a cookie alongside the lock
once it's acquired (or in a parallel space). Which can easily be done with
a wrapper around lock acquisition. And stale lock detection needn't be
done in kernel space either.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

