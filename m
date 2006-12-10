Return-Path: <linux-kernel-owner+w=401wt.eu-S1762405AbWLJTq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762405AbWLJTq3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762410AbWLJTq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:46:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:44576 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762381AbWLJTq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:46:29 -0500
Subject: Re: powerpc: "IRQ probe failed (0x0)" on powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Paul Collins <paul@briny.ondioline.org>, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux-kernel@vger.kernel.org
In-Reply-To: <jey7pfvfw8.fsf@sykes.suse.de>
References: <87lklg9rkz.fsf@briny.internal.ondioline.org>
	 <1165737970.1103.171.camel@localhost.localdomain>
	 <jey7pfvfw8.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 06:46:14 +1100
Message-Id: <1165779974.1103.181.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Bisection has identified this patch:
> 
> commit f90bb153b1493719d18b4529a46ebfe43220ea6c
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Sat Nov 11 17:24:51 2006 +1100
> 
>     [POWERPC] Make pci_read_irq_line the default

Thanks Andreas ! I was expecting something around that patch indeed, I
suspect something in Apple device-tree is dodgy and breaking the
new generic PCI irq parsing (for example, at first sight, it's a PCI
device with 2 interrupts, which isn't allowed by the PCI spec).

I'll dig a bit more when I get to the office where my crash box is, and
will do a fix.

Ben.


