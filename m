Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264827AbRGITp0>; Mon, 9 Jul 2001 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264837AbRGITpQ>; Mon, 9 Jul 2001 15:45:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:52233 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264827AbRGITpD>;
	Mon, 9 Jul 2001 15:45:03 -0400
Date: Mon, 9 Jul 2001 21:44:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io_request_lock patch?
Message-ID: <20010709214453.U16505@suse.de>
In-Reply-To: <20010709123936.E6013@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010709123936.E6013@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09 2001, Jonathan Lahr wrote:
> 
> I have heard that a patch to reduce io_request_lock contention by
> breaking it into per queue locks was released in the past.  Does 
> anyone know where I could find this patch if it exists?

I had a patch about a year ago that did it safely for the block layer
and IDE at least, and also for selected SCSI hba's. Some of the latter
variety are pretty hard and/or tedious to fixup, Eric Y has done some
work automating this process almost completely. Until that is done, the
general patch has no chance of being integrated.

It's also interesting to take a look at _why_ there's contention on the
io_request_lock. And fix those up first.

-- 
Jens Axboe

