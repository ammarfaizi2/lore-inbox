Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131812AbQLVPrv>; Fri, 22 Dec 2000 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131764AbQLVPrl>; Fri, 22 Dec 2000 10:47:41 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:41230 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S132022AbQLVPra>;
	Fri, 22 Dec 2000 10:47:30 -0500
Date: Fri, 22 Dec 2000 16:16:34 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Referencing PHYSICAL (what you see on the bus) memory?
Message-ID: <20001222161634.L599@almesberger.net>
In-Reply-To: <Pine.LNX.3.95.1001222090540.9114A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1001222090540.9114A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Dec 22, 2000 at 09:11:07AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> I am finishing up a memory-test program. I want to get the
> true linear address of some failing memory. I have obtained
> the virtual (user-space) address.
> 
> Since going through all the PTEs seems to be a bitch, I thought
> it would be easier to do the following:

Hmm, for some unusual definition of "easy", perhaps ...

For an ugly hack that works remarkably well, look at ptable.c in Andrew
Tridgell's capture program: http://samba.org/picturebook/

Note: you probably also want to check if you find multiple addresses
for the page, i.e. if the hack didn't quite work. (Due to odd
side-effects, incomplete address decoding, etc.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
