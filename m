Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWHDO7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWHDO7O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWHDO7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:59:13 -0400
Received: from mga06.intel.com ([134.134.136.21]:61836 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932489AbWHDO7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:59:13 -0400
X-IronPort-AV: i="4.07,211,1151910000"; 
   d="scan'208"; a="102612298:sNHT26568476046"
Message-ID: <44D35B56.6060500@linux.intel.com>
Date: Fri, 04 Aug 2006 07:36:06 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org,
       jesse.brandeburg@intel.com, john.ronciak@intel.com,
       netdev@vger.kernel.org
Subject: Re: [RFC] irqbalance: Mark in-kernel irqbalance as obsolete, set
 to N by default
References: <44CE3F5E.4010305@intel.com> <20060803194550.9ff31bc1.akpm@osdl.org>
In-Reply-To: <20060803194550.9ff31bc1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 31 Jul 2006 10:35:26 -0700
> Auke Kok <auke-jan.h.kok@intel.com> wrote:
> 
>> We've recently seen a number of user bug reports against e1000 that the 
>> in-kernel irqbalance code is detrimental to network latency. The algorithm 
>> keeps swapping irq's for NICs from cpu to cpu causing extremely high network 
>> latency (>1000ms).
> 
> What kernel versions?  Some IRQ balancer fixes went in shortly after 2.6.17.
> 
> It would be better if poss to fix the balancer rather than deprecating it.

to some degree the in kernel balancer cannot really make the level of decisions that a
userspace balancer can make, at least not without making all kernel developers vomit ;)
(for example the userspace balancer looks in /proc/interrupts and parses that to see
which interrupts are used by networking versus which by storage etc, and has different
balancing policies for those and other classes; the networking policy basically comes down to
"pin the interrupt unless some higher networking interrupt really gets in the way")
