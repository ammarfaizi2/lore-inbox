Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWB0Kqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWB0Kqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 05:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWB0Kqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 05:46:38 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:19882 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751081AbWB0Kqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 05:46:37 -0500
Date: Mon, 27 Feb 2006 16:16:34 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 2/7] Add sysctl for schedstats
Message-ID: <20060227104634.GB22492@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1141026996.5785.38.camel@elinux04.optonline.net> <1141027367.5785.42.camel@elinux04.optonline.net> <1141027923.5785.50.camel@elinux04.optonline.net> <20060227085203.GB3241@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227085203.GB3241@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> why not just introduce a schedstats_lock mutex, and acquire it for both 
> the 'if (schedstats_sysctl)' line and the schedstats_set() line. That 
> will make the locking meaningful: two parallel sysctl ops will be atomic 
> to each other. [right now they wont be and they can clear schedstat data 
> in parallel -> not a big problem but it makes schedstats_lock rather 
> meaningless]
>

Ingo,

Can sysctl's run in parallel? sys_sysctl() is protects the call
to do_sysctl() with BKL (lock_kernel/unlock_kernel).

Am I missing something?

Balbir
