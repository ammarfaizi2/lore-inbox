Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVLBCwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVLBCwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbVLBCwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:52:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57863
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964817AbVLBCwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:52:42 -0500
Date: Fri, 2 Dec 2005 03:52:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
       npiggin@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced zone aging
Message-ID: <20051202025240.GE28539@opteron.random>
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201173015.675f4d80.akpm@osdl.org> <20051202020407.GA4445@mail.ustc.edu.cn> <20051202021811.GB28539@opteron.random> <20051202023727.GA4874@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202023727.GA4874@mail.ustc.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 10:37:27AM +0800, Wu Fengguang wrote:
> Thanks for the clarification, I was concerning too much ;)

You're welcome. I'm also not concerned because the cost is linear with
the amount of memory (and the cost has an high bound, that is the size
of the lower zones, so it's not like the struct page that is a
percentage of ram guaranteed to be lost) so it's generally not
noticeable at runtime, and it's most important in the big systems (where
in turn the cost is higher).
