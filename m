Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUIVOwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUIVOwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 10:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUIVOwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 10:52:35 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:55480 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266003AbUIVOwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 10:52:31 -0400
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[3/6]-Mapping lsapic to cpu
From: Alex Williamson <alex.williamson@hp.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, len.brown@intel.com,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	 <20040920093819.E14208@unix-os.sc.intel.com>
	 <20040922221538.650986f2.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 22 Sep 2004 08:52:59 -0600
Message-Id: <1095864779.6105.3.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 22:15 +0900, Keiichiro Tokunaga wrote:
> 
> I would like to suggest introducing a new function 'acpi_get_pxm()'
> since other drivers might need it in the future.  Acutally, ACPI container
> hotplug will be use it soon.
> 
> Here is a patch creating the function.
> 

   Nice, I have a couple I/O locality patches that could be simplified
with this function.

> +#ifdef CONFIG_ACPI_NUMA
> +int acpi_get_pxm(acpi_handle handle);
> +#else
> +static inline int acpi_get_pxm(acpi_handle hanle)
Trivial typo here --->                        ^^^^^ handle


	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

