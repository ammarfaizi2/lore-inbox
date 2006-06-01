Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWFAO4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWFAO4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWFAO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 10:56:46 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:53518 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1750994AbWFAO4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 10:56:45 -0400
Message-ID: <447F0023.8090206@argo.co.il>
Date: Thu, 01 Jun 2006 17:56:35 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mark Lord <lkml@rtr.ca>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com
Subject: Re: NCQ performance (was Re: [rfc][patch] remove racy sync_page?)
References: <20060601131921.GH4400@suse.de>
In-Reply-To: <20060601131921.GH4400@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2006 14:56:43.0608 (UTC) FILETIME=[98BC8D80:01C6858B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
> Ok, I decided to rerun a simple random read work load (with fio), using
> depths 1 and 32. The test is simple - it does random reads all over the
> drive size with 4kb block sizes. The reads are O_DIRECT. The test
> pattern was set to repeatable, so it's going through the same workload.
> The test spans the first 32G of the drive and runtime is capped at 20
> seconds.
>

Did you modify the iodepth given to the test program, or to the drive? 
If the former, then some of the performance increase came from the Linux 
elevator.

Ideally exactly the same test would be run with the just the drive 
parameters changed.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

