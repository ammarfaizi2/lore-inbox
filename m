Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVGHCJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVGHCJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 22:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGHCJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 22:09:27 -0400
Received: from fmr21.intel.com ([143.183.121.13]:6284 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261400AbVGHCJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 22:09:25 -0400
Date: Thu, 7 Jul 2005 19:06:45 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>,
       "David S. Miller" <davem@davemloft.net>, systemtap@sources.redhat.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com
Subject: Re: [5/6 PATCH] Kprobes : Prevent possible race conditions ia64 changes
Message-ID: <20050707190645.A29253@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050707101833.GI12106@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050707101833.GI12106@in.ibm.com>; from prasanna@in.ibm.com on Thu, Jul 07, 2005 at 03:18:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:18:33AM -0700, Prasanna S Panchamukhi wrote:
> 
>    This patch contains the ia64 architecture specific changes to
>    prevent the possible race conditions.
> 
>    Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
> 
>    ---
> 
>     linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/kprobes.c      |    57
>    ++++++-----
>     linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/traps.c       |    5
>     linux-2.6.13-rc1-mm1-prasanna/arch/ia64/kernel/vmlinux.lds.S |    1
>     linux-2.6.13-rc1-mm1-prasanna/arch/ia64/lib/flush.S          |    1
>     linux-2.6.13-rc1-mm1-prasanna/arch/ia64/mm/fault.c           |    3
>     5 files changed, 40 insertions(+), 27 deletions(-)

Prasanna,
	You have missed one jprobe specific file
i.e arch/ia64/kernel/jprobe.S. I guess you need to patch this
file in the same way as you have done for flush.S, i,e by adding
.section .kprobes.text

Thanks,
Anil

