Return-Path: <linux-kernel-owner+w=401wt.eu-S1030443AbXAKOO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbXAKOO5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 09:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbXAKOO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 09:14:57 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25056 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030443AbXAKOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 09:14:56 -0500
Date: Thu, 11 Jan 2007 15:15:38 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       torvalds@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-ID: <20070111141537.GD2277@kernel.dk>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701110724040.19233@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11 2007, linux-os (Dick Johnson) wrote:
> 
> On Wed, 10 Jan 2007, Aubrey wrote:
> 
> > Hi all,
> >
> > Opening file with O_DIRECT flag can do the un-buffered read/write access.
> > So if I need un-buffered access, I have to change all of my
> > applications to add this flag. What's more, Some scripts like "cp
> > oldfile newfile" still use pagecache and buffer.
> > Now, my question is, is there a existing way to mount a filesystem
> > with O_DIRECT flag? so that I don't need to change anything in my
> > system. If there is no option so far, What is the right way to achieve
> > my purpose?
> >
> > Thanks a lot.
> > -Aubrey
> > -
> 
> I don't think O_DIRECT ever did what a lot of folks expect, i.e.,
> write this buffer of data to the physical device _now_. All I/O
> ends up being buffered. The `man` page states that the I/O will
> be synchronous, that at the conclusion of the call, data will have
> been transferred. However, the data written probably will not be
> in the physical device, perhaps only in a DMA-able buffer with
> a promise to get it to the SCSI device, soon.

Thanks for your guessing, but O_DIRECT is with the physical drive once
the call returns. Whether it's in drive cache or on drive platters is a
different story, but from the OS point of view, it's definitely with the
drive.

-- 
Jens Axboe

