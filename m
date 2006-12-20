Return-Path: <linux-kernel-owner+w=401wt.eu-S1030273AbWLTSt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWLTSt5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 13:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWLTSt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 13:49:56 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27484 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030273AbWLTSt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 13:49:56 -0500
Date: Wed, 20 Dec 2006 19:51:43 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Cc: agk@redhat.com, mchristi@redhat.com, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, j-nomura@ce.jp.nec.com
Subject: Re: [RFC PATCH 0/8] rqbased-dm: request-based device-mapper
Message-ID: <20061220185143.GK10535@kernel.dk>
References: <20061219.171026.115904158.k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219.171026.115904158.k-ueda@ct.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19 2006, Kiyoshi Ueda wrote:
> For block layer maintainer and developers:
>   This patch set has 2 block layer changes below.
>     - Changed blk_get_request() to allow calls from interrupt context
>       so that queue's request_fn can use it.  (PATCH 1/8)
>       (*) The behaviour of CFQ (or other scheduler which depends on
>           "current") may be affected when blk_get_request() is called
>           in interrupt context, because "current" is not the process
>           which issue the original request.

This we already covered.

>     - Added new "end_io_first" hook to __end_that_request_first()
>       and struct request.  (PATCH 2/8)

This I still need an explanation for.

>   And I'm thinking about:
>     - Moving blk_clone_rq() to ll_rw_blk.c from dm.c. (PATCH 7/8)

That definitely should be core code. I see no problem in that.

-- 
Jens Axboe

