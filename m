Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbXAVGIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbXAVGIO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 01:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbXAVGIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 01:08:14 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:53698 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750804AbXAVGIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 01:08:13 -0500
Message-ID: <45B4547A.3020105@panasas.com>
Date: Mon, 22 Jan 2007 08:06:50 +0200
From: Benny Halevy <bhalevy@panasas.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: dougg@torque.net
CC: Boaz Harrosh <bharrosh@panasas.com>, Jens Axboe <jens.axboe@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
       Daniel.E.Messinger@seagate.com, Liran Schour <LIRANS@il.ibm.com>
Subject: Re: [RFC 1/6] bidi support: request dma_data_direction
References: <45B3F578.7090109@panasas.com> <45B40458.9010107@torque.net>
In-Reply-To: <45B40458.9010107@torque.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2007 06:06:28.0641 (UTC) FILETIME=[749D1910:01C73DEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> Boaz Harrosh wrote:
>> - Introduce a new enum dma_data_direction data_dir member in struct request.
>>   and remove the RW bit from request->cmd_flag
>> - Add new API to query request direction.
>> - Adjust existing API and implementation.
>> - Cleanup wrong use of DMA_BIDIRECTIONAL
>> - Introduce new blk_rq_init_unqueued_req() and use it in places ad-hoc
>>   requests were used and bzero'ed.
> 
> With a bi-directional transfer is it always unambiguous
> which transfer occurs first (or could they occur at
> the same time)?

The bidi transfers can occur in any order and in parallel.

> 
> Doug Gilbert
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

