Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133075AbRDRKkT>; Wed, 18 Apr 2001 06:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133076AbRDRKkL>; Wed, 18 Apr 2001 06:40:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35851 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S133075AbRDRKjz>;
	Wed, 18 Apr 2001 06:39:55 -0400
Date: Wed, 18 Apr 2001 12:39:41 +0200
From: Jens Axboe <axboe@suse.de>
To: stefan@jaschke-net.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Toshiba SD-W2002 DVD-RAM drive (IDE)
Message-ID: <20010418123941.H492@suse.de>
In-Reply-To: <01041714250400.01376@antares>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01041714250400.01376@antares>; from s-jaschke@t-online.de on Tue, Apr 17, 2001 at 02:25:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17 2001, Stefan Jaschke wrote:
> Judging from the thread started Jan 1, 2001, by Andre Hedrick, 
> I thought IDE DVD-RAM just works out of the box and got a
> Toshiba SD-W2002. 
> 
> Problem: /dev/hdc cannot be read or written to when the drive contains
>   DVD-RAM media. The behavior is the same for the stock 2.4.3 kernel
>   and the SuSE-2.4.0 kernel.  Strangely enough, the disk can be read,
>   but not written to, with the 2.2.18 kernel.

It should work, note that I recently spotted some quite severe bugs in
the pio write handling for ATAPI which I've almost fixed here now. It
seems you drive is in DMA mode though, so it shouldn't be affecting you.

Please send me strace info when reading/writing to the drive (or at
least attempting to), this looks very queer indeed.

-- 
Jens Axboe

