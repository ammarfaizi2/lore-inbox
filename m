Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130542AbRBSBrr>; Sun, 18 Feb 2001 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130622AbRBSBrj>; Sun, 18 Feb 2001 20:47:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65286 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130542AbRBSBrW>;
	Sun, 18 Feb 2001 20:47:22 -0500
Date: Mon, 19 Feb 2001 02:47:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, zzed@cyberdude.com
Subject: Re: [PROBLEM] 2.4.1 can't mount ext2 CD-ROM
Message-ID: <20010219024704.C8227@suse.de>
In-Reply-To: <20010218201639.A6593@suse.de> <E14UfJK-00026X-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14UfJK-00026X-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 19, 2001 at 01:40:16AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19 2001, Alan Cox wrote:
> > So put 0 and sure anyone can submit I/O on the size that they want.
> > Now the driver has to support padding reads, or gathering data to do
> > a complete block write. This is silly. Sr should support 512b transfers
> > just fine, but only because I added the necessary _hacks_ to support
> > it. sd doesn't right now for instance.
> 
> It is silly to be in the block layer, it is silly to be in each file system.
> Perhaps it belongs in the block queueing/handling code or the caches
> 
> But it has to go somewhere, and 2.4 right now is unusable on two of my boxes
> with M/O drives.

Reads can be pretty easily padded, but writes are a bit harder. Maybe
push it to some helper before the device queue sees it? For 2.4 the
best sd solution is probably to just make it able to handle these
requests.

-- 
Jens Axboe

