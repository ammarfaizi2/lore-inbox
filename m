Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUIVQ7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUIVQ7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUIVQ7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:59:44 -0400
Received: from fmr03.intel.com ([143.183.121.5]:63620 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266249AbUIVQ7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:59:41 -0400
Date: Wed, 22 Sep 2004 09:59:29 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Message-ID: <20040922095929.A2631@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920093532.D14208@unix-os.sc.intel.com> <20040922131757.509ba88d.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040922131757.509ba88d.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Wed, Sep 22, 2004 at 01:17:57PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In acpi_eject_store(), eject_operation() is called regardless of the
> result of acpi_bus_trim().  I think that eject_operation() should be
> called only when acpi_bus_trim() returns success.  Otherwise, a
> device stil being online will be ejected forcibly.
> 
> Two steps might be needed to do this.
> 
>     1. Modify acpi_bus_trim() to return success only when all the
>         acpi_bus_remove() are done successfully.
>     2. Modify acpi_eject_store() to see the result and call eject_operation()
>         only when the result is success.
Hi Kei-san,
Your idea and the patch both looks good to me. 
Thanks for eye balling the code and detecting the corner cases like this.
> 
> Here is a patch just to show what I have in mind.  It is still based on
> the recursion, so please fix it as appropriate ;)

I will merge this with my non-recursion version of the patch and post it ASAP.

thanks,
Anil
