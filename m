Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129162AbRBDLA7>; Sun, 4 Feb 2001 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbRBDLAt>; Sun, 4 Feb 2001 06:00:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29966 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129162AbRBDLAi>; Sun, 4 Feb 2001 06:00:38 -0500
Subject: Re: System unresponsitive when copying HD/HD
To: law@sgi.com (LA Walsh)
Date: Sun, 4 Feb 2001 11:01:27 +0000 (GMT)
Cc: birtl00@dmi.usherb.ca (Delta), linux-kernel@vger.kernel.org
In-Reply-To: <3A7C64F9.F3192611@sgi.com> from "LA Walsh" at Feb 03, 2001 12:07:21 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PMvB-0001Mq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I have vmstat running, I notice blocks trickling out to the disk, 5sec averages
> 495,142,151,155,136,257,15,0.  Note that the maximum read rate (hdparm -t) of this
> disk is in the 12-14M/s range.  I'm getting about 1-5% of that on output with the
> system's disk subsystem being apparently unable to do anything else.
> 
> This is with IDE hard disk with DMA enabled.
> 
> a) is this expected performance on a large linear write?  

No

> b) should I expect other disk operations to be denied service as long as
> 	the write is 'flushing'?

No

But try 2.4.1 before worrying too much. That fixed a lot of the block 
performance problems I was seeing (2.4.1 ruins the VM performance under paging
loads but the I/O speed is fixed ;))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
