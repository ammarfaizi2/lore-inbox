Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271302AbTHMBAv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 21:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTHMBAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 21:00:51 -0400
Received: from [66.212.224.118] ([66.212.224.118]:12296 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271302AbTHMBAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 21:00:50 -0400
Date: Tue, 12 Aug 2003 20:48:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>
Subject: RE: Updated MSI Patches
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AE9A@scsmsx402.sc.intel.com>
Message-ID: <Pine.LNX.4.53.0308122040440.4047@montezuma.mastecende.com>
References: <7F740D512C7C1046AB53446D3720017304AE9A@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Nakajima, Jun wrote:

> static unsigned int startup_edge_ioapic_vector(unsigned int vector)
> {
> 	int was_pending = 0;
> 	unsigned long flags;
> 	int irq = vector_to_irq (vector);
> 
> 	spin_lock_irqsave(&ioapic_lock, flags);
> 	if (irq < 16) {
> 		disable_8259A_irq(irq);
> 		if (i8259A_irq_pending(irq))
> 			was_pending = 1;
> 	}
> 	__unmask_IO_APIC_irq(irq);
> 	spin_unlock_irqrestore(&ioapic_lock, flags);
> 
> 	return was_pending;
> }

Hmm that doesn't look too bad, i like, ok another question, do you think 
this could be made to scale on systems with lots of devices requiring 
vectors?

Thanks,
	Zwane

