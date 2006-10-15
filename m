Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWJOSQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWJOSQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 14:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWJOSQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 14:16:30 -0400
Received: from brick.kernel.dk ([62.242.22.158]:44095 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030199AbWJOSQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 14:16:29 -0400
Date: Sun, 15 Oct 2006 20:16:55 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Peter Osterlund <petero2@telia.com>
Cc: balagi@justmail.de,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>
Subject: Re: [PATCH 2/2] 2.6.19-rc1-mm1 pktcdvd: bio write congestion
Message-ID: <20061015181655.GF14399@kernel.dk>
References: <op.thfa4wnqiudtyh@master> <m3u026g223.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u026g223.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14 2006, Peter Osterlund wrote:
> "Thomas Maier" <balagi@justmail.de> writes:
> 
> > Hello,
> > 
> > this adds a bio write queue congestion control
> > to the pktcdvd driver with fixed on/off marks.
> > It prevents that the driver consumes a unlimited
> > amount of write requests.
> 
> Thanks, this looks good in principle, but I think it can be
> implemented in a simpler way.
> 
> Jens, can I please ask your opinion. Would it make sense to export the
> clear_queue_congested() and set_queue_congested() functions in
> ll_rw_blk.c so that the pktcdvd driver can use them? Something like
> this patch from a few years ago:
> 
>         http://marc.theaimsgroup.com/?l=linux-kernel&m=109378210610508&w=2

It definitely would. Did you test, and did it work well for you? I think
it's the right approach.

-- 
Jens Axboe

