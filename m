Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUIYLPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUIYLPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 07:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUIYLPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 07:15:35 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:23301 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S269310AbUIYLPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 07:15:33 -0400
Date: Sat, 25 Sep 2004 14:14:25 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
In-Reply-To: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige wrote:

>     - Changed acpi_pci_irq_disable() to leave 'dev->irq' as it
>       is. Clearing 'dev->irq' by some magic constant
>       (e.g. PCI_UNDEFINED_IRQ) is TBD.

This may not be safe with CONFIG_PCI_MSI, you may want to verify against 
that if you already haven't.

> +acpi_unregister_gsi (unsigned int irq)
> +{
> +}
> +EXPORT_SYMBOL(acpi_unregister_gsi);

Why not just make these static inlines in header files? Since you're on 
this, how about making irq_desc and friends dynamic too?

Thanks,
	Zwane
