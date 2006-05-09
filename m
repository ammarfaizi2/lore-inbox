Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWEIUFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWEIUFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWEIUFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:05:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18606 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751111AbWEIUFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:05:20 -0400
Message-ID: <4460F5FB.5030208@us.ibm.com>
Date: Tue, 09 May 2006 13:05:15 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: christoph <hch@lst.de>
CC: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Benjamin LaHaise <bcrl@kvack.org>, cel@citi.umich.edu
Subject: Re: [PATCH 3/3] Zach's core aio changes to support vectored AIO
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147198119.28388.5.camel@dyn9047017100.beaverton.ibm.com> <20060509185534.GA18808@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



christoph wrote:

>On Tue, May 09, 2006 at 11:08:39AM -0700, Badari Pulavarty wrote:
>
>>This work is initially done by Zach Brown to add support for
>>vectored aio. These are the core changes for AIO to support
>>IOCB_CMD_PREADV/IOCB_CMD_PWRITEV. 
>>
>>I made few extra changes beyond Zach's work. They are
>>	- took out aio_pread/aio_pwrite and made them
>>	  a special case into vectored support
>>	- added single inlined vector to save on kmalloc()
>>	  for a simple aio_read/aio_write
>>	- kiocb->ki_left always indicates the amount of
>>	  IO need to be done. Made sure that this gets
>>	  set in sync case also, so that we don't need
>>	  to loop over iovecs to figure out IO size all
>>	  the time. 
>>
>>Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
>>Signed-off-by: Zach Brown <zach.brown@oracle.com>
>>Acked-by: Benjamin LaHaise <bcrl@kvack.org>
>>
>
>Please add my Signed-off-by somewhere, I did large portions of the
>changes and ACK the final version too.
>
Signed-off-by: Christoph Hellwig <hch@lst.de>

Done.. !! Sorry, Definitely not intentional :(

Thanks,
Badari



