Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbRBKSXJ>; Sun, 11 Feb 2001 13:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129746AbRBKSW7>; Sun, 11 Feb 2001 13:22:59 -0500
Received: from www.wen-online.de ([212.223.88.39]:61200 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129660AbRBKSWt>;
	Sun, 11 Feb 2001 13:22:49 -0500
Date: Sun, 11 Feb 2001 19:22:13 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.LNX.4.21.0102111243090.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10102111814140.521-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, Rik van Riel wrote:

> On Sun, 11 Feb 2001, Mike Galbraith wrote:
> > On Sun, 11 Feb 2001, Mike Galbraith wrote:
> > 
> > > Something else I see while watching it run:  MUCH more swapout than
> > > swapin.  Does that mean we're sending pages to swap only to find out
> > > that we never need them again?
> > 
> > (numbers might be more descriptive)
> > 
> > user  :       0:07:21.70  54.3%  page in :   142613
> > nice  :       0:00:00.00   0.0%  page out:   155454
> > system:       0:03:40.63  27.1%  swap in :    56334
> > idle  :       0:02:30.50  18.5%  swap out:   149872
> > uptime:       0:13:32.83         context :   519726
> 
> Indeed, in this case we send a lot more pages to swap
> than we read back in from swap, this means that the
> data is still sitting in swap space and was never needed
> again.

But it looks and feels (box is I/O hyper-saturated) like
it wrote it all to disk.

(btw, ac5 does more disk read.. ie the reduced cache size
of earlier kernels under heavy pressure does have it's price
with this workload.. quite visible in agregates.  looks to
be much cheaper than swap though.. for this workload)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
