Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288548AbSA0UEX>; Sun, 27 Jan 2002 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288544AbSA0UEN>; Sun, 27 Jan 2002 15:04:13 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:33677 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S288548AbSA0UEB>; Sun, 27 Jan 2002 15:04:01 -0500
Date: Sun, 27 Jan 2002 19:59:32 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall latency improvement #1
Message-ID: <20020127195932.H4818@kushida.apsleyroad.org>
In-Reply-To: <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com> <E16UXjj-0005su-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16UXjj-0005su-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 26, 2002 at 06:39:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > NOTE! There are potentially other ways to do all of this, _without_ losing
> > atomicity. For example, you can move the "flags" value into the slot saved
> > for the CS segment (which, modulo vm86, will always be at a constant
> > offset on the stack), and make CS=0 be the work flag. That will cause the
> > CPU to trap atomically at the "iret".
> 
> Is the test even needed. Suppose we instead patch the return stack if we
> set need_resched/sigpending, and do it on the rare occassion we set the
> value.

Yes, that's what you'll find in one of Ingo Molnar's low latency patches.

-- Jamie
