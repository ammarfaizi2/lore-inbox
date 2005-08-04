Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVHDAyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVHDAyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVHDAwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:52:47 -0400
Received: from fmr19.intel.com ([134.134.136.18]:48834 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261687AbVHDAvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:51:06 -0400
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI
	resources [resend]
From: Shaohua Li <shaohua.li@intel.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, acpi-devel@lists.sourceforge.net,
       Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <42F1343B.70707@free.fr>
References: <200508020955.54844.bjorn.helgaas@hp.com>
	 <1123030861.2937.4.camel@linux-hp.sh.intel.com>
	 <200508030920.13450.bjorn.helgaas@hp.com>  <42F1343B.70707@free.fr>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 08:51:52 +0800
Message-Id: <1123116712.2929.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 23:16 +0200, matthieu castet wrote:
> 
> There are drivers/acpi/motherboard.c that done some stuff already handle 
> by pnp/system.c.
Yes, it should be disabled if pnpacpi is enabled. The only concern is
motherboard.c also request some ACPI resources, which might not declaim
in ACPI motherboard device, but it's completely BIOS dependent. We might
could try remove it at -mm tree to see if it breaks any system later.

> 
> PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
> will be removed to register again the pnp device in acpi layer. Do you 
> plan to add more check and for example add only device that have a CRS 
> in pnp layer ?
For detecting PNP device? it's worthy trying.

Thanks,
Shaohua

