Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264397AbRFHXEA>; Fri, 8 Jun 2001 19:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264398AbRFHXDu>; Fri, 8 Jun 2001 19:03:50 -0400
Received: from waste.org ([209.173.204.2]:61760 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S264397AbRFHXDc>;
	Fri, 8 Jun 2001 19:03:32 -0400
Date: Fri, 8 Jun 2001 18:06:00 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel headers violate RFC2553
In-Reply-To: <9frh99$7bi$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0106081753350.16106-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Jun 2001, Linus Torvalds wrote:

> The basic issue is that the kernel will _refuse_ to follow the
> "namespace of the day" rules of C89, C99, POSIX, BSD, SuS, GNU .. the
> list goes on. The kernel headers are not meant to be used in user space,
> and will not have the strict namespace rules that a lot of standards
> spend so much time playing with.

Add something like this to linux/config.h in 2.5?

#if !defined(__KERNEL__) || !defined(__KERNEL_ME_HARDER__)
#warning "Using kernel headers in userspace apps is unsupported."
#warning "Don't come crying to us when it breaks."
#endif

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

