Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVLBCDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVLBCDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLBCDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:03:45 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:10154 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S964780AbVLBCDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:03:44 -0500
Date: Fri, 2 Dec 2005 10:04:07 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202020407.GA4445@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org, christoph@lameter.com,
	riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
	andrea@suse.de, magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201173015.675f4d80.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201173015.675f4d80.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 05:30:15PM -0800, Andrew Morton wrote:
> >  But lines 865-866 together with line 846 make most shrink_zone() invocations
> >  only run one batch of scan. The numbers become:
> 
> True.  Need to go into a huddle with the changelogs, but I have a feeling
> that lines 865 and 866 aren't very important.  What happens if we remove
> them?

Maybe the answer is: can we accept to free 15M memory at one time for a 64G zone?
(Or can we simply increase the DEF_PRIORITY?)

btw, maybe it's time to lower the low_mem_reserve.
There should be no need to keep ~50M free memory with the balancing patch.

Regards,
Wu
