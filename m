Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130571AbRAISjV>; Tue, 9 Jan 2001 13:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131372AbRAISjF>; Tue, 9 Jan 2001 13:39:05 -0500
Received: from chiara.elte.hu ([157.181.150.200]:27660 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131230AbRAISiu>;
	Tue, 9 Jan 2001 13:38:50 -0500
Date: Tue, 9 Jan 2001 19:38:28 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, <riel@conectiva.com.br>,
        <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <20010109183808.A12128@suse.de>
Message-ID: <Pine.LNX.4.30.0101091935461.7155-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Jens Axboe wrote:

> > > ever seen, this is why i quoted it - the talk was about block-IO
> > > performance, and Stephen said that our block IO sucks. It used to suck,
> > > but in 2.4, with the right patch from Jens, it doesnt suck anymore. )
> >
> > Thats fine. Get me 128K-512K chunks nicely streaming into my raid controller
> > and I'll be a happy man
>
> No problem, apply blk-13B and you'll get 512K chunks for SCSI and RAID.

i cannot agree more - Jens' patch did wonders to IO performance here. It
fixes a long-standing bug in the Linux block-IO-scheduler that caused very
suboptimal requests being issued to lowlevel drivers once the request
queue gets full. I think this patch is a clear candidate for 2.4.x
inclusion.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
