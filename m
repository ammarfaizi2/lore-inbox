Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135660AbRDSNJo>; Thu, 19 Apr 2001 09:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135658AbRDSNJe>; Thu, 19 Apr 2001 09:09:34 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:22799 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135662AbRDSNJR>;
	Thu, 19 Apr 2001 09:09:17 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104191309.f3JD93V24427@oboe.it.uc3m.es>
Subject: Re: block devices don't work without plugging in 2.4.3
In-Reply-To: <20010419144025.T16822@suse.de> from "Jens Axboe" at "Apr 19, 2001
 02:40:25 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Thu, 19 Apr 2001 15:09:03 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jens Axboe wrote:"
> Examine _why_ you don't want plugging. In 2.2, you would have to edit
> the kernel manually to disable it for your device.

True. Except that I borrowed a major which already got that special
treatment.

>                                            For 2.4, as long as
> there has been blk_queue_pluggable, there has also been the
> disable-merge function mentioned. Why are you disabling plugging??

Fundamentally, to disable merging, as you suggest. I had merging
working fine in 2.0.*. Then I never could figure out what had to be
done in 2.2.*, so I disabled it. In 2.4, things work nicely - I don't
have to do anything and it all happens magically.

Nevertheless, I am left with baggage that I have to maintain -
certainly the driver has to work in 2.2 as well as in 2.4. Removing
the blah_plugging function now in 2.4 after having started off 2.4 
with it around gives me one more #ifdef kernel_version in my code.

I don't think that's good for my code, and in general I don't think one
should remove this function half way through a stable series. Leave it
there, mark it as deprecated in big letters, and make it do nothing,
but leave it there, no?

Peter
