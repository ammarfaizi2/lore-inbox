Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUEOSHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUEOSHl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 14:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEOSHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 14:07:41 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:6924 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261205AbUEOSHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 14:07:40 -0400
Date: Sat, 15 May 2004 19:07:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: axboe@suse.de, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slabify iocontext + request_queue
Message-ID: <20040515190735.A4189@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, axboe@suse.de,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this just went in:

>  From: Jens Axboe <axboe@suse.de>
> 
> Move both request_queue and io_context allocation to a slab cache.
> 
> This is mainly a space-saving exercise.  Some setups have a lot of disks
> and the kmalloc rounding-up can consume significant amounts of memory.

While I agree on the io_context part, slabifying request_queue is a space
waste on most machines out there.  The averange desktop has less than a
handfull of these, and even for smaller servers it doesn't exactly look
like a gain.
