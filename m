Return-Path: <linux-kernel-owner+w=401wt.eu-S1751823AbXAVAZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbXAVAZO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbXAVAZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 19:25:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42338 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbXAVAZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 19:25:12 -0500
Message-ID: <45B40458.9010107@torque.net>
Date: Sun, 21 Jan 2007 19:24:56 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Boaz Harrosh <bharrosh@panasas.com>
CC: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
       Daniel.E.Messinger@seagate.com, Liran Schour <LIRANS@il.ibm.com>,
       Benny Halevy <bhalevy@panasas.com>
Subject: Re: [RFC 1/6] bidi support: request dma_data_direction
References: <45B3F578.7090109@panasas.com>
In-Reply-To: <45B3F578.7090109@panasas.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boaz Harrosh wrote:
> - Introduce a new enum dma_data_direction data_dir member in struct request.
>   and remove the RW bit from request->cmd_flag
> - Add new API to query request direction.
> - Adjust existing API and implementation.
> - Cleanup wrong use of DMA_BIDIRECTIONAL
> - Introduce new blk_rq_init_unqueued_req() and use it in places ad-hoc
>   requests were used and bzero'ed.

With a bi-directional transfer is it always unambiguous
which transfer occurs first (or could they occur at
the same time)?

Doug Gilbert
