Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275096AbRJFI7r>; Sat, 6 Oct 2001 04:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275110AbRJFI7g>; Sat, 6 Oct 2001 04:59:36 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:27148 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S275096AbRJFI7X>;
	Sat, 6 Oct 2001 04:59:23 -0400
Date: Sat, 6 Oct 2001 10:59:47 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Simon Kirby <sim@netnation.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <20011006010656.A968@netnation.com>
Message-ID: <Pine.LNX.4.33.0110061048140.29350-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Simon Kirby wrote:

> 2.4.11pre4 is swapping out on me while burning a CD at 4x.
> 2.4.11pre2 (or maybe it was pre1) seemed to be a lot better.
> 2.4.10pre10 still seems to be the best for me so far...

I can confirm that in 2.4.11-pre4, the used-once pages are causing
page-out activity, as opposed to 2.4.11-pre2 which did not.  Streaming i/o
performce is down, and so is the interactive responsiveness (a lot).  To
reproduce, run

	dd if=/dev/hde1 of=/dev/null bs=4k

This should not produce paging.  The block size is not important.

/Tobias

