Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274179AbRI3VEU>; Sun, 30 Sep 2001 17:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274180AbRI3VEL>; Sun, 30 Sep 2001 17:04:11 -0400
Received: from sm10.texas.rr.com ([24.93.35.222]:45767 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S274179AbRI3VEC>;
	Sun, 30 Sep 2001 17:04:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
Date: Sun, 30 Sep 2001 16:08:40 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15nnXL-0007aB-00@the-village.bc.nu>
In-Reply-To: <E15nnXL-0007aB-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01093016084007.00965@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright. Until the situation clarifies you might tell RH turn off OSB4 by 
default in future releases. It caused us no end of grief with 2.4.3-12.

-- 
Marvin Justice
Software Developer
BOXX Technologies, Inc.
www.boxxtech.com
512-235-6318 (V)
512-835-0434 (F)


On Sunday 30 September 2001 03:50 pm, Alan Cox wrote:
> > Curious - OSB4 thinks the DMA is still running.
> > OSB4 wait exit
>
> This is an OSB4 trap for a problem I've seen with seagate drivers on some
> boxes. Under very high load with UDMA seagate drives the OSB4 returns to
> us with the chip reporting DMA in progress. The next I/O after this will
> cause disk corruption as it DMA's the last 4 bytes of the previous write,
> then the data shifted up by 4 bytes until the end of that I/O. I need
> to confirm nobody else is seeing this with other working workloads, then
> I'll swap it for a panic - better to die than kill the disc contents.
>
> Serverworks have been looking at the problem but have yet to duplicate it.
> As far as we can tell (and Red Hat have been working with a customer on
> this directly) your choices are
>
> 1.	Use multiword DMA not UDMA
> 2.	Use non seagate disks with that controller
>
> I am hopeful that serverworks will figure out what is up, but not every box
> sees it - and indeed they've yet to be able to reproduce it.
>
>
> Alan

