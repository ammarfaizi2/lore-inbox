Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVFJQji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVFJQji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVFJQji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:39:38 -0400
Received: from fmr23.intel.com ([143.183.121.15]:29851 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262379AbVFJQjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:39:37 -0400
Date: Fri, 10 Jun 2005 09:34:46 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak <ak@muc.de>
Subject: Re: [PATCH]x86-x86_64 flush cache for CPU hotplug
Message-ID: <20050610093446.A25573@unix-os.sc.intel.com>
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
> 

Good catch. Yes, we need it for IA64 as well. Strange i had put it in my
TBD, and out of 2 items, this is one of them. I need to muck something for
mca apart from this pending flush.

I think i will update the ACPI_FLUSH_CPU_CACHE as well when i push this change.

> 
> Signed-off-by: Shaohua.li<shaohua.li@intel.com>
> ---
> 
>  linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c   |    1 +
>  linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/process.c |    1 +
>  2 files changed, 2 insertions(+)
