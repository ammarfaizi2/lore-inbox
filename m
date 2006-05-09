Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWEISz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWEISz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWEISz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:55:56 -0400
Received: from verein.lst.de ([213.95.11.210]:27619 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750914AbWEISzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:55:55 -0400
Date: Tue, 9 May 2006 20:55:34 +0200
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org, christoph <hch@lst.de>,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu
Subject: Re: [PATCH 3/3] Zach's core aio changes to support vectored AIO
Message-ID: <20060509185534.GA18808@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147198119.28388.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147198119.28388.5.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 11:08:39AM -0700, Badari Pulavarty wrote:
> This work is initially done by Zach Brown to add support for
> vectored aio. These are the core changes for AIO to support
> IOCB_CMD_PREADV/IOCB_CMD_PWRITEV. 
> 
> I made few extra changes beyond Zach's work. They are
> 	- took out aio_pread/aio_pwrite and made them
> 	  a special case into vectored support
> 	- added single inlined vector to save on kmalloc()
> 	  for a simple aio_read/aio_write
> 	- kiocb->ki_left always indicates the amount of
> 	  IO need to be done. Made sure that this gets
> 	  set in sync case also, so that we don't need
> 	  to loop over iovecs to figure out IO size all
> 	  the time. 
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> Signed-off-by: Zach Brown <zach.brown@oracle.com>
> Acked-by: Benjamin LaHaise <bcrl@kvack.org>

Please add my Signed-off-by somewhere, I did large portions of the
changes and ACK the final version too.

