Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278382AbRJMTqn>; Sat, 13 Oct 2001 15:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278383AbRJMTqe>; Sat, 13 Oct 2001 15:46:34 -0400
Received: from [212.21.93.146] ([212.21.93.146]:8324 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278382AbRJMTqW>; Sat, 13 Oct 2001 15:46:22 -0400
Date: Sat, 13 Oct 2001 21:46:03 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011013214603.A1144@kushida.jlokier.co.uk>
In-Reply-To: <20011013205445.A24854@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110131219520.8900-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Oct 13, 2001 at 12:23:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > In fact it was proposed here on this list years ago, and I think you
> > argued against it (TLB flush costs).  The costs and kernel
> > infrastructure have changed and maybe the idea could be revisited now.
> 
> It's still not entirely unlikely that doing VM mappings is simply more
> expensive than just doing a memcpy. The TLB invalidate is only part of the
> issue - you also have the page table walk, the VM lock, and the fact that
> PAGE_COPY itself ends up being overhead.

There are applications (GCC comes to mind) which are using mmap() to
read files now because it is measurably faster than read(), for
sufficiently large source files.

I don't know where the optimal costs lie.

-- Jamie
