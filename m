Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUGBIVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUGBIVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUGBIVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 04:21:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12419 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266508AbUGBIVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 04:21:02 -0400
Date: Fri, 2 Jul 2004 10:21:01 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix minor quota race
Message-ID: <20040702082101.GB23730@atrey.karlin.mff.cuni.cz>
References: <20040701200740.GE3540@atrey.karlin.mff.cuni.cz> <20040701150944.19b33862.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701150944.19b33862.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan Kara <jack@suse.cz> wrote:
> >
> > I'm sending one more quota fix - it fixes a possible race between
> > quotaoff and prune_icache. The race could lead to some forgotten
> > pointers to quotas in inodes leading later to BUG when invalidating
> > quota structures. The patch is against 2.6.7.
> 
> It tossed one reject against the lock ranking comment in dquot.c.  I fixed
> that up.
  OK, thanks - that was because this patch was supposed to be applied on
top of the one fixing the i_flags...

> I'll apply the below patch on top of it - please always put extern decls in
> header files so that the implementor and all users of the data/function
> always see the same declaration.
  Will do next time :)

								Bye
									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
