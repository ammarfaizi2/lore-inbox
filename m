Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWEJGRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWEJGRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWEJGRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:17:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30362
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964827AbWEJGRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:17:51 -0400
Date: Tue, 09 May 2006 23:17:44 -0700 (PDT)
Message-Id: <20060509.231744.89497410.davem@davemloft.net>
To: paulus@samba.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Define __raw_get_cpu_var and use it
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
References: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Wed, 10 May 2006 13:30:13 +1000

> There are several instances of per_cpu(foo, raw_smp_processor_id()),
> which is semantically equivalent to __get_cpu_var(foo) but without the
> warning that smp_processor_id() can give if CONFIG_DEBUG_PREEMPT is
> enabled.  For those architectures with optimized per-cpu
> implementations, namely ia64, powerpc, s390, sparc64 and x86_64,
> per_cpu() turns into more and slower code than __get_cpu_var(), so it
> would be preferable to use __get_cpu_var on those platforms.
> 
> This defines a __raw_get_cpu_var(x) macro which turns into
> per_cpu(x, raw_smp_processor_id()) on architectures that use the
> generic per-cpu implementation, and turns into __get_cpu_var(x) on
> the architectures that have an optimized per-cpu implementation.
>     
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Thank you:

Signed-off-by: David S. Miller <davem@davemloft.net>
