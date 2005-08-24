Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVHXE3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVHXE3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 00:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVHXE27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 00:28:59 -0400
Received: from fmr20.intel.com ([134.134.136.19]:26786 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751446AbVHXE27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 00:28:59 -0400
Subject: Re: [PATCH] Add MCE resume under ia32
From: Shaohua Li <shaohua.li@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <200508240626.13475.ak@suse.de>
References: <1124762500.3013.3.camel@linux-hp.sh.intel.com.suse.lists.linux.kernel>
	 <200508240559.16931.ak@suse.de>
	 <1124856986.5310.2.camel@linux-hp.sh.intel.com>
	 <200508240626.13475.ak@suse.de>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 12:31:55 +0800
Message-Id: <1124857915.5310.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-24 at 06:26 +0200, Andi Kleen wrote:
> On Wednesday 24 August 2005 06:16, Shaohua Li wrote:
> 
> > The boot code already initialized MCE for APs, it isn't required to
> > initialize again. The MCE entries are cpuhotplug friendly, so for
> > suspend/resume.
> 
> Ok so you're saying the only change needed is to remove
> the on_each_cpu() in the resume method? Fine I can do that.
Yep, only BP needs it. But I'm not sure if we should do the same (add
the sysdev class) in ia32, considering only BP needs it.

Thanks,
Shaohua

