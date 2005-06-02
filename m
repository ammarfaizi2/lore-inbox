Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVFBU0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVFBU0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFBUYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:24:24 -0400
Received: from fsmlabs.com ([168.103.115.128]:1204 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261319AbVFBUVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:21:45 -0400
Date: Thu, 2 Jun 2005 14:25:04 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 0/5] x86_64 CPU hotplug patch series.
In-Reply-To: <20050602125754.993470000@araj-em64t>
Message-ID: <Pine.LNX.4.61.0506021421130.3157@montezuma.fsmlabs.com>
References: <20050602125754.993470000@araj-em64t>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jun 2005, Ashok Raj wrote:

> Andrew: Could you help test staging in -mm so we can get some wider testing
> from those interested.
> 
> *Sore Point*: Andi doesnt agree with one patch that removes ipi-broadcast 
> and uses only online map cpus receive IPI's. This is much simpler approach to 
> handle instead of trying to remove the ill effects of IPI broadcast to CPUs in 
> offline state.
> 
> Initial concern from Andi was IPI performance, but some primitive test with a 
> good number of samples doesnt seem to indicate any degration at all, infact the
> results seem identical. (Barring any operator errors :-( ).
> 
> It would be nice to hear other opinions as well, hopefuly we can close on
> what what the right approach in this case. Link to an earlier discussion
> on the topic.

I don't think it's worth the extra boot time complexity to use the boot 
workaround and i'm not convinced the extra mask against cpu_online_map 
slows down that path enough to show up compared to waiting for remote 
processor IPI handling to commence/complete.

Thanks,
	Zwane
