Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUC3SAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbUC3SAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:00:41 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:51973 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263424AbUC3SAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:00:39 -0500
Message-ID: <4069BA3B.5050004@techsource.com>
Date: Tue, 30 Mar 2004 13:19:39 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de> <4069B6F8.1020506@techsource.com> <4069B376.9010104@pobox.com>
In-Reply-To: <4069B376.9010104@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:
> 
>
> 
> If you are taking your samples over time, that shouldn't matter...  if 
> the system workload is such that you are hitting the drive cache the 
> majority of the time, you're not being "fooled" by cache hits, the patch 
> would be taking those cache hits into account.
> 
> If the system isn't hitting the drive cache the majority of the time, 
> statistical sampling will automatically notice that too...
> 


I completely agree, although Jens' patch seems to try to learn the 
drive's maximum speed and go based on that.  Maybe I misread the code. 
Anyhow, it's certainly excellent for a starting point... it's this sort 
of proof-of-concept that gets the ball rolling.  Plus, it's already 
better than Jens says it is.  :)


