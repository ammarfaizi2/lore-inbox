Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269540AbRHLWz2>; Sun, 12 Aug 2001 18:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269541AbRHLWzS>; Sun, 12 Aug 2001 18:55:18 -0400
Received: from leng.mclure.org ([64.81.48.142]:27919 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S269540AbRHLWzP>; Sun, 12 Aug 2001 18:55:15 -0400
Date: Sun, 12 Aug 2001 15:55:20 -0700
From: Manuel McLure <manuel@mclure.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Message-ID: <20010812155520.A935@ulthar.internal.mclure.org>
In-Reply-To: <20010812113142.G948@ulthar.internal.mclure.org> <E15W1eR-000691-00@the-village.bc.nu> <20010812133539.A17802@ulthar.internal.mclure.org> <20010812145953.A955@ulthar.internal.mclure.org> <200108122224.f7CMOGO01895@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200108122224.f7CMOGO01895@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Aug 12, 2001 at 15:24:16 -0700
X-Mailer: Balsa 1.2.pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.08.12 15:24 Linus Torvalds wrote:
> In article <20010812145953.A955@ulthar.internal.mclure.org> you write:
> >
> >I've answered that one on my own - I installed today's CVS emu10k1 and
> got
> >another Oops:
> 
> The oops seems to be due to "wave_dev->woinst" being NULL.
> 
> Can you try just adding the line
> 
> 	if (!woinst)
> 		return;
> 
> to the top of the function (just before the "spin_lock_irqsave()"). Does
> that fix it for you?
> 
> 		Linus

So far so good - however I don't have a consistent way to reproduce this.
I'll just keep running and see if the Oops happens again.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft
