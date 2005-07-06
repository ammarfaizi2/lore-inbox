Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVGFFdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVGFFdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVGFFbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:31:43 -0400
Received: from fsmlabs.com ([168.103.115.128]:34975 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261190AbVGFDiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:38:15 -0400
Date: Tue, 5 Jul 2005 21:42:42 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nigel Cunningham <nigel@suspend2.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [24/48] Suspend2 2.1.9.8 for 2.6.12:
 601-kernel_power_power-header.patch
In-Reply-To: <11206164422542@foobar.com>
Message-ID: <Pine.LNX.4.61.0507052141490.2149@montezuma.fsmlabs.com>
References: <11206164422542@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Nigel Cunningham wrote:

> diff -ruNp 602-smp.patch-old/kernel/power/suspend2_core/smp.c 602-smp.patch-new/kernel/power/suspend2_core/smp.c
> --- 602-smp.patch-old/kernel/power/suspend2_core/smp.c	1970-01-01 10:00:00.000000000 +1000
> +++ 602-smp.patch-new/kernel/power/suspend2_core/smp.c	2005-07-04 23:14:19.000000000 +1000
> @@ -0,0 +1,12 @@
> +#include <linux/sched.h>
> +
> +void ensure_on_processor_zero(void)
> +{
> +	set_cpus_allowed(current, cpumask_of_cpu(0));
> +	BUG_ON(smp_processor_id() != 0);
> +}
> +
> +void return_to_all_processors(void)
> +{
> +	set_cpus_allowed(current, CPU_MASK_ALL);
> +}

Do we really need to wrap these?

