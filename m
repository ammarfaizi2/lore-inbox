Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274040AbRI0WzW>; Thu, 27 Sep 2001 18:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274049AbRI0WzP>; Thu, 27 Sep 2001 18:55:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27666 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274040AbRI0Wy4>; Thu, 27 Sep 2001 18:54:56 -0400
Subject: Re: Locking comment on shrink_caches()
To: davem@redhat.com (David S. Miller)
Date: Thu, 27 Sep 2001 23:59:38 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com, bcrl@redhat.com,
        marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010927.124134.28787324.davem@redhat.com> from "David S. Miller" at Sep 27, 2001 12:41:34 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mk82-0005N5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    See prefetching - the CPU prefetching will hide some of the effect and
>    the spin_lock_prefetch() macro does wonders for the rest.
>    
> Well, if prefetching can do it faster than avoiding the transaction
> altogether, I'm game :-)

That would depend on the cost of avoidance, the amount of contention and
the distance ahead you can fetch. Avoiding it also rather more portable so
I suspect you win 

