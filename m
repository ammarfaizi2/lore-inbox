Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVFJQfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVFJQfl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVFJQfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:35:41 -0400
Received: from fmr24.intel.com ([143.183.121.16]:1981 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262606AbVFJQff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:35:35 -0400
Date: Fri, 10 Jun 2005 09:30:51 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak <ak@muc.de>
Subject: Re: [PATCH]x86-x86_64 flush cache for CPU hotplug
Message-ID: <20050610093051.A25536@unix-os.sc.intel.com>
References: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1118374208.7510.6.camel@linux-hp.sh.intel.com>; from shaohua.li@intel.com on Fri, Jun 10, 2005 at 11:30:08AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:30:08AM +0800, Shaohua Li wrote:
> Hi,
> We should flush cache at CPU hotplug. An error has been observed data is
> corrupted after CPU hotplug in CPUs with bigger cache.
> I guess IA64 requires similar change, Ashok?

Yes, we need that for IA64 as well. i did put that in my notes tbd, but 
didnt turn around doing it yet. 

Think we also need to define the same for asm-ia64/acpi.h FLUSH_CPU_CACHE
i will try updating both in next.

If you have a targetted test that causes the corruption that would be great
so we can add to our stress test senarios.

Cheers,
ashok
> 
> Thanks,
> Shaohua
> 
> Signed-off-by: Shaohua.li<shaohua.li@intel.com>
> ---
> 
>  linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c   |    1 +
>  linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/process.c |    1 +
>  2 files changed, 2 insertions(+)
> 
