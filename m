Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUJ0G1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUJ0G1Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbUJ0G1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:27:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41886 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261672AbUJ0GZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:25:01 -0400
Date: Wed, 27 Oct 2004 08:24:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Strange IO behaviour on wakeup from sleep
Message-ID: <20041027062427.GE15910@suse.de>
References: <1098845804.606.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098845804.606.4.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27 2004, Benjamin Herrenschmidt wrote:
> Hi !
> 
> Not much datas at this point yet, but paulus and I noticed that current
> bk (happened already last saturday or so) has a very strange problem
> when waking up from sleep (suspend to ram) on our laptops.
> 
> This doesn't seem to be directly related to the PM code, at least not
> the arch one, as far as I know. The IDE throughput goes down to less
> than 100k/sec on hdparm. We haven't yet figured out where the time is
> lost, the disk seem to properly be restored to UDMA4 as usual, that code
> didn't change for ages, I don't think it's a problem at that level in
> IDE.
> 
> I'm not sure yet how to track that down, it could be the IO scheduler
> getting messed up on wakeup for some reason. Any clue appreciated.

Just saw the same thing here yesterday. It's not io scheduler related
(happened with even noop, if you switch to it), but apart from that I
have no clues so far either.

-- 
Jens Axboe

