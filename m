Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTAMHgc>; Mon, 13 Jan 2003 02:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAMHgc>; Mon, 13 Jan 2003 02:36:32 -0500
Received: from havoc.daloft.com ([64.213.145.173]:31197 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261495AbTAMHga>;
	Mon, 13 Jan 2003 02:36:30 -0500
Date: Mon, 13 Jan 2003 02:45:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, davem@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned_in_smp?
Message-ID: <20030113074516.GA4677@gtf.org>
References: <20030113072521.74B842C104@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113072521.74B842C104@lists.samba.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 06:24:40PM +1100, Rusty Russell wrote:
> Dave: Anton suggested you might have a justification for
> __cacheline_aligned doing something on UP?
> 
> I think I'd prefer __cacheline_aligned to be the same as
> __cacheline_aligned_in_smp, and have a new __cacheline_aligned_always
> for those who REALLY want it (if any).

See the recent thread on tg3 and cacheline_aligned for David's
description...  I and one other did some performance measurements and
____cacheline_aligned proved useful even on UP...

sigh.  I wish I had caught you on IRC.

Don't you think changing the meaning of cacheline_aligned, and adding a
new __cacheline_aligned_always to mean what it used to, is completely
pointless churn??

	Jeff



