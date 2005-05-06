Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVEFReq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVEFReq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVEFReq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 13:34:46 -0400
Received: from fmr22.intel.com ([143.183.121.14]:2991 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261224AbVEFReo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 13:34:44 -0400
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon
	processors in EM64T mode (x86_64)
From: Len Brown <len.brown@intel.com>
To: Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050505221117.508BB42AE4@linux.site>
References: <20050505221117.508BB42AE4@linux.site>
Content-Type: text/plain
Organization: 
Message-Id: <1115400848.12770.10.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 May 2005 13:34:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-05 at 18:11, Natalie.Protasevich@unisys.com wrote:
> 
> This patch disables unique IO_APIC_ID check for xAPIC systems running
> in EM64T mode. Xeon-based ES7000s panic failing this unnecessary
> check. I added IOAPIC_ID_CHECK config option and turned it off for
> Intel processors. Also added the boot option that overrides default
> and turnes this check on/off in case it is needed for some reason.
> Hope this is acceptable way to fix the problem.
> 
> Signed-off by: Natalie Protasevich  <Natalie.Protasevich@unisys.com>
> 

> +config NO_IOAPIC_CHECK
> +       bool
> +       depends on GENERIC_CPU || MPSC
> +       default y
> +

A run-time solution would be preferable to adding
a config option that only changes the default behaviour.

In general, the more config options, the more kernels
we force distros to build and support.  We really want
to going the other way and simplifying, when possible.

cheers,
-Len

