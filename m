Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWBXBcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWBXBcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWBXBcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:32:45 -0500
Received: from fmr17.intel.com ([134.134.136.16]:64450 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751811AbWBXBco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:32:44 -0500
Subject: Re: [PATCH] softlockup detection vs. cpu hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060224003146.GJ3293@localhost.localdomain>
References: <20060224003146.GJ3293@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 09:31:53 +0800
Message-Id: <1140744713.16880.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 08:31 +0800, Nathan Lynch wrote:
> 
> In the watchdog thread, do touch_softlockup_watchdog in a 
> non-preemptible section so that it won't touch another cpu's 
> timestamp.  This can happen in the window between the watchdog thread 
> getting forcefully migrated during a cpu offline operation and 
> kthread_should_stop.
Could we stop the thread in CPU_DOWN_PREPARE case, so it will not be
migrated to other CPUs? I suppose it's better the per-cpu thread only
runs on the specific cpu.

Thanks,
Shaohua

