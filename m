Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWFAPEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWFAPEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWFAPEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:04:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38660 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965074AbWFAPEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:04:32 -0400
Date: Thu, 1 Jun 2006 17:03:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Avi Kivity <avi@argo.co.il>
Cc: Mark Lord <lkml@rtr.ca>, Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com
Subject: Re: NCQ performance (was Re: [rfc][patch] remove racy sync_page?)
Message-ID: <20060601150320.GO4400@suse.de>
References: <20060601131921.GH4400@suse.de> <447F0023.8090206@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447F0023.8090206@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01 2006, Avi Kivity wrote:
> Jens Axboe wrote:
> >
> >Ok, I decided to rerun a simple random read work load (with fio), using
> >depths 1 and 32. The test is simple - it does random reads all over the
> >drive size with 4kb block sizes. The reads are O_DIRECT. The test
> >pattern was set to repeatable, so it's going through the same workload.
> >The test spans the first 32G of the drive and runtime is capped at 20
> >seconds.
> >
> 
> Did you modify the iodepth given to the test program, or to the drive? 
> If the former, then some of the performance increase came from the Linux 
> elevator.
> 
> Ideally exactly the same test would be run with the just the drive 
> parameters changed.

Just from the program. Since the software depth matched the software
depth, I'd be surprised if it made much of a difference here.  I can
rerun the same test tomorrow with the drive depth modified the and
software depth fixed at 32. Then the io scheduler can at least help the
drive without NCQ out somewhat.

-- 
Jens Axboe

