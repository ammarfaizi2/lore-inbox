Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRBIKvL>; Fri, 9 Feb 2001 05:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130102AbRBIKvA>; Fri, 9 Feb 2001 05:51:00 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:43063 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129847AbRBIKu5>; Fri, 9 Feb 2001 05:50:57 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102091049.f19Anjk06651@devserv.devel.redhat.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
To: becker@scyld.com (Donald Becker)
Date: Fri, 9 Feb 2001 05:49:45 -0500 (EST)
Cc: ionut@cs.columbia.edu (Ion Badulescu),
        jgarzik@mandrakesoft.com (Jeff Garzik), alan@redhat.com (Alan Cox),
        linux-kernel@vger.kernel.org, jes@linuxcare.com
In-Reply-To: <Pine.LNX.4.10.10102081924330.7141-100000@vaio.greennet> from "Donald Becker" at Feb 08, 2001 07:44:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's amusing that a full receive copy is added without any concern, in
> the same discussion where zero-copy transmit is treated as a holy grail!

For non routing paths its virtually free because the DMA forced the lines
from cache anyway. Basically its a deficiency in the chipset. We don't support
chipsets with alignment rules well on cpus with alignment rules that clash

That shouldnt be a suprise

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
