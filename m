Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWBJHXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWBJHXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 02:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWBJHXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 02:23:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60223 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751173AbWBJHXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 02:23:01 -0500
Date: Fri, 10 Feb 2006 08:25:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: kill not-so-popular simple flag testing macros
Message-ID: <20060210072523.GH24124@suse.de>
References: <20060208085728.GA21065@htj.dyndns.org> <43EB8D2C.6020708@pobox.com> <43EBDC70.6050302@gmail.com> <43EBEA26.8000709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EBEA26.8000709@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09 2006, Jeff Garzik wrote:
> Tejun Heo wrote:
> >The code he was talking about looks like.
> >
> >if (rq->flags & (REQ_SOFTBARRIER | REQ_HARDBARRIER) {
> 
> 
> Yes, I certainly agree you don't want to test the same variable multiple 
> times, if you are just testing bits in the same variable.

Very few of the flags are usually tested together, so we could just fix
this particular instance. So blk_softbarrier_rq() and
blk_hardbarrier_rq(), combined tested with blk_barrier_rq().

-- 
Jens Axboe

