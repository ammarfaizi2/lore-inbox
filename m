Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbTIFGiF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 02:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTIFGiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 02:38:05 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:55168
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262345AbTIFGiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 02:38:03 -0400
Date: Sat, 6 Sep 2003 02:37:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] idle using PNI monitor/mwait (take 3)
In-Reply-To: <7F740D512C7C1046AB53446D3720017304A72F@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.53.0309060218320.31201@montezuma.fsmlabs.com>
References: <7F740D512C7C1046AB53446D3720017304A72F@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Nakajima, Jun wrote:

> diff -ur /build/orig/linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c
> linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c
> --- /build/orig/linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c
> 2003-09-05 19:16:26.000000000 -0700
> +++ linux-2.6.0-test4-mm6/arch/i386/kernel/cpu/intel.c	2003-09-05
> 19:22:05.000000000 -0700
> @@ -12,6 +12,8 @@
>  
>  #include "cpu.h"
>  
> +extern void select_idle_routine(const struct cpuinfo_x86 *c);

Can't that go in the above included header?

> +		if (!pm_idle) {
> +			pm_idle = mwait_idle;
> +		}
> +		return;
> +	}
> +	pm_idle = default_idle;

You don't have to set that.

Thanks,
	Zwane

