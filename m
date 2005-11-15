Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbVKOTwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVKOTwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVKOTwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:52:23 -0500
Received: from silver.veritas.com ([143.127.12.111]:34852 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964941AbVKOTwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:52:23 -0500
Date: Tue, 15 Nov 2005 19:51:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
In-Reply-To: <20051115104916.353e7ade.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0511151947010.7872@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
 <20051109181022.71c347d4.akpm@osdl.org> <20051115104916.353e7ade.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Nov 2005 19:52:22.0552 (UTC) FILETIME=[182E1980:01C5EA1E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Andrew Morton wrote:
> 
> It occurs to me that we can do the above if (__GNUC__ > 2), or whatever.
> 
> That way, the only people who have a 4-byte-larger pageframe are those who
> use CONFIG_PREEMPT, NR_CPUS>=4 and gcc-2.x.y.  An acceptably small
> community, I suspect.

I can't really think of this at the moment (though the PageReserved
fixups going smoother this evening).  Acceptably small community, yes.
But wouldn't it plunge us into the very mess of wrappers we were trying
to avoid with anony structunions, to handle the __GNUC__ differences?

Hugh
