Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274813AbTHRUU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHRUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:20:29 -0400
Received: from [66.212.224.118] ([66.212.224.118]:40968 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S274813AbTHRUUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:20:25 -0400
Date: Mon, 18 Aug 2003 16:20:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: tom.l.nguyen@intel.com, Greg Kroah-Hartmann <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Update MSI Patches
In-Reply-To: <200308181728.h7IHSolh016169@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.53.0308181615381.2009@montezuma.mastecende.com>
References: <200308181728.h7IHSolh016169@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, long wrote:

> I make minor modification to the last patch to reduce some duplicate functions,
> as shown as below. I think this perhaps looks better. What do you think?

The patch looks fine.

> +#ifdef CONFIG_PCI_USE_VECTOR
> +static unsigned int startup_edge_ioapic_vector(unsigned int vector)
> +{
> +	int irq = vector_to_irq(vector);
> +
> +	return (startup_edge_ioapic_irq(irq));
> +}

Tiny nit, Linux coding style is;

return startup_edge_ioapic_irq(irq);

But you can queue that change for later.
