Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRCTEgR>; Mon, 19 Mar 2001 23:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbRCTEgH>; Mon, 19 Mar 2001 23:36:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34054 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129719AbRCTEf7>; Mon, 19 Mar 2001 23:35:59 -0500
Date: Tue, 20 Mar 2001 01:35:15 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: 3rd version of R/W mmap_sem patch available
In-Reply-To: <001201c0b0ca$30eb1910$5517fea9@local>
Message-ID: <Pine.LNX.4.33.0103200133240.2830-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Manfred Spraul wrote:
> >
> > Besides, the fair semaphores would potentially slow things down, while
> > this potentially speeds things up. So.. It looks obvious enough.
>
> Rik, did you check that {pte,pmd}_alloc are thread safe? At
> least in 2.4.2 they aren't (include/asm-i386/pgalloc.h), and
> your patch doesn't touch pgalloc.

I checked and they're not. This still needs to be fixed...

(ie the patch really isn't ready yet to be included in the
main kernel ... OTOH, the changes needed to make it ready
are all trivial and tedious ;))

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

