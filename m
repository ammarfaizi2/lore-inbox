Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269979AbRHJTLl>; Fri, 10 Aug 2001 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269975AbRHJTLc>; Fri, 10 Aug 2001 15:11:32 -0400
Received: from ns.caldera.de ([212.34.180.1]:12249 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S269974AbRHJTLR>;
	Fri, 10 Aug 2001 15:11:17 -0400
Date: Fri, 10 Aug 2001 21:11:11 +0200
Message-Id: <200108101911.f7AJBBU28476@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: bruce.holzrichter@monster.com ("Holzrichter, Bruce")
Cc: linux-kernel@vger.kernel.org, sparc-linux@vger.kernel.org
Subject: Re: 2.4.7ac9,10,11 compile error on Sparc (revisited)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B7006@nocmail.ma.tmpw.net>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3AB544CBBBE7BF428DA7DBEA1B85C79C9B7006@nocmail.ma.tmpw.net> you wrote:
> Error:
> In file included from sched.c:26:
>
> /usr/src/linux-2.4.7/include/linux/irq.h:61: asm/hw_irq.h: No such file or
> directory

Quickhack:  touch include-asm-sparc64/hw_irq.h.

Right soloution: replaces <linux/irq.h> with <asm/irq.h> in sched.c,
fix eventual problems with that.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
