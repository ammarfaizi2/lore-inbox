Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752486AbWCQBUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbWCQBUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbWCQBUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:20:24 -0500
Received: from fmr20.intel.com ([134.134.136.19]:38850 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1752484AbWCQBUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:20:23 -0500
Subject: Re: [PATCH] Check for online cpus before bringing them up
From: Shaohua Li <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       bryce@osdl.org
In-Reply-To: <20060316170814.02fa55a1.akpm@osdl.org>
References: <20060316174447.GA8184@in.ibm.com>
	 <20060316170814.02fa55a1.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 09:16:54 +0800
Message-Id: <1142558214.26706.31.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 17:08 -0800, Andrew Morton wrote:
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> >
> > Bryce reported a bug wherein offlining CPU0 (on x86 box) and then subsequently
> > onlining it resulted in a lockup. 
> > 
> > On x86, CPU0 is never offlined. The subsequent attempt to online CPU0
> > doesn't take that into account. It actually tries to bootup the already
> > booted CPU. Following patch fixes the problem (as acknowledged by
> > Bryce). Please consider for inclusion in 2.6.16.
> > 
> > 
> 
> Is x86 the only architecture which is exposed to this?
I guess i386 is the only architecture exposing to this. i386 uses a
slight different method to do cpu hotadd (prepare cpu, and then up cpu).
This is to workaround some issues like tsc synchronizing.

Thanks,
Shaohua

