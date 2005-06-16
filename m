Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVFPG4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVFPG4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 02:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVFPG4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 02:56:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15811 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261162AbVFPGzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 02:55:52 -0400
Date: Thu, 16 Jun 2005 08:56:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.12-rc6-mm1] blk: elevator unplug thresh hanlding fix
Message-ID: <20050616065654.GA1483@suse.de>
References: <20050616034705.GA29048@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616034705.GA29048@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16 2005, Tejun Heo wrote:
>  Hello, Jens.
>  Hello, Andrew.
> 
>  This patch fixes q->unplug_thresh condition check in
> __elv_add_request().  rq.count[READ] + rq.count[WRITE] can increase
> more than one if another thread has allocated a request after the
> current request is allocated or in_flight could have changed resulting
> in larger-than-one change of nrq, thus breaking the threshold
> mechanism.

Looks good, thanks!

-- 
Jens Axboe

