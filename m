Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUK1PQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUK1PQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUK1PQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:16:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33684 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261491AbUK1PQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:16:49 -0500
Date: Sun, 28 Nov 2004 20:49:25 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
Message-ID: <20041128151925.GA20894@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <41A9E98C.2C1D07EF@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9E98C.2C1D07EF@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 06:06:52PM +0300, Oleg Nesterov wrote:
> Hello.
> 
> rcu_check_quiescent_state:
> 	/*
> 	 * Races with local timer interrupt - in the worst case
> 	 * we may miss one quiescent state of that CPU. That is
> 	 * tolerable. So no need to disable interrupts.
> 	 */
> 	if (rdp->qsctr == rdp->last_qsctr)
> 		return;
> 
> Afaics, this comment is misleading. rcu_check_quiescent_state()
> is executed in softirq context, while rcu_check_callbacks() checks
> in_softirq() before ++qsctr.
> 
> Also, replace (1 << HARDIRQ_SHIFT) by HARDIRQ_OFFSET.
> 

Looks good to me. IIRC, that comment has been around since very
early prototypes, so it is probably leftover trash.

Thanks
Dipankar
