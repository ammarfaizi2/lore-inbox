Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVJFKcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVJFKcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 06:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJFKcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 06:32:15 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61356 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750794AbVJFKcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 06:32:14 -0400
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: kernel performance update - 2.6.14-rc3
References: <200510052115.j95LFgg07836@unix-os.sc.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 06 Oct 2005 12:32:11 +0200
In-Reply-To: <200510052115.j95LFgg07836@unix-os.sc.intel.com>
Message-ID: <p73mzlnylzo.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:

> Even though
> softirq is invoked at the end of dev_queue_xmit() via local_bh_enable(),
> not all execution of softirq will result a __wake_up().  With higher
> HZ rate, timer interrupt is more frequent and thus more softirq
> invocation and leads to more __wake_up(), which then takes us to higher
> throughput because cpu spend less time in idle.  

This sounds like a serious bug somewhere if true.

-Andi

