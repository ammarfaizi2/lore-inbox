Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUHXKFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUHXKFV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267373AbUHXKFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:05:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44955 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267367AbUHXKFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:05:13 -0400
Date: Tue, 24 Aug 2004 12:03:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Karl Vogel <karl.vogel@seagha.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Kernel 2.6.8.1: swap storm of death - CFQ scheduler=culprit
Message-ID: <20040824100342.GI2355@suse.de>
References: <6DED3619289CD311BCEB00508B8E133601A68B13@nt-server2.antwerp.seagha.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6DED3619289CD311BCEB00508B8E133601A68B13@nt-server2.antwerp.seagha.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23 2004, Karl Vogel wrote:
> > > Jens, is this huge amount of bio/biovec's allocations 
> > expected with CFQ? Its really really bad.
> > 
> > Nope, it's not by design :-)
> > 
> > A test case would be nice, then I'll fix it as soon as possible. But
> > please retest with 2.6.8.1 marcelo, 2.6.8-rc4 is missing an important
> > fix to ll_rw_blk that can easily cause this. The first report is for
> > 2.6.8.1, so I'm more puzzled on that.
> 
> I tried with 2.6.8.1 and 2.6.8.1-mm4, both had the problem. If there 
> is anything extra I need to try/record, just shoot!
> 
> Original post with testcase + stats:
>   http://article.gmane.org/gmane.linux.kernel/228156

2.6.8.1-mm4 clean does not reproduce the problem. Marcelo, your
2.6.8-rc4 report is not valid due to the fixed problem related to that
in CFQ already. I'd still like for you to retest with 2.6.8.1.

So I'm trying 2.6.8.1 with voluntary preempt applied now, the bug could
be related to that.

-- 
Jens Axboe

