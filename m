Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSAFDbM>; Sat, 5 Jan 2002 22:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287665AbSAFDbE>; Sat, 5 Jan 2002 22:31:04 -0500
Received: from epic7.Stanford.EDU ([171.64.15.40]:32390 "EHLO
	epic7.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S287658AbSAFDay>; Sat, 5 Jan 2002 22:30:54 -0500
Date: Sat, 5 Jan 2002 19:30:40 -0800 (PST)
From: Vikram <vvikram@stanford.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.17 kernel without modules...was Re:O(1) SMP and UP scheduler
In-Reply-To: <E16N2oW-00021c-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0201051927140.23441-100000@epic7.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi ingo,

i am running 2.4.17 on an AMD duron 256MB RAM here. i tried the 2.4.17-B4
patch on a freshly built UP kernel . it applied successfully.

as you had mentioned earlier i built it _without_ modules. it
boots up fine and all that....goes to xdm ---> hard lockup after that.

	Vikram



On Sun, 6 Jan 2002, Alan Cox wrote:

> > Ingo, you don't need that many queues, 32 are more than sufficent.
> > If you look at the distribution you'll see that it matters ( for
> > interactive feel ) only the very first ( top ) queues, while lower ones
> > can very easily tollerate a FIFO pickup w/out bad feelings.
>
> 64 queues costs a tiny amount more than 32 queues. If you can get it down
> to eight or nine queues with no actual cost (espcially for non realtime queues)
> then it represents a huge win since an 8bit ffz can be done by lookup table
> and that is fast on all processors
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


