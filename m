Return-Path: <linux-kernel-owner+w=401wt.eu-S1751207AbXAIJS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbXAIJS1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbXAIJS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:18:27 -0500
Received: from brick.kernel.dk ([62.242.22.158]:23236 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207AbXAIJS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:18:26 -0500
Date: Tue, 9 Jan 2007 10:19:00 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Torsten Kaiser <kernel@bardioc.dyndns.org>
Cc: Andrew Morton <akpm@osdl.org>, Fengguang Wu <fengguang.wu@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-ID: <20070109091858.GI11203@kernel.dk>
References: <368051775.16914@ustc.edu.cn> <200701061130.07467.kernel@bardioc.dyndns.org> <20070108085245.GR11203@kernel.dk> <200701081911.46495.kernel@bardioc.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701081911.46495.kernel@bardioc.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08 2007, Torsten Kaiser wrote:
> On Monday 08 January 2007 09:52, Jens Axboe wrote:
> > --- a/block/ll_rw_blk.c
> > +++ b/block/ll_rw_blk.c
> > @@ -1542,7 +1542,7 @@ static inline void
> > -	blk_unplug_current();
> > +	blk_replug_current_nested();
> 
> Does not help. Dmesg follows:

[snip]

Strange, it works perfectly for me now. Not using -mm though, but the
plug branch. And it did hang before. Fengguang, any change for you?

-- 
Jens Axboe

