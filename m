Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967119AbWK2K6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967119AbWK2K6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967122AbWK2K6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:58:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50919 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967119AbWK2K6o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:58:44 -0500
Date: Wed, 29 Nov 2006 11:03:36 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: rbrito@ime.usp.br, rbrito@gmail.com
Cc: rbrito@ime.usp.br, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rbrito@gmail.com
Subject: Re: The return of the dreaded "nobody cared" message with a Promise
 Card
Message-ID: <20061129110336.22e2ca18@localhost.localdomain>
In-Reply-To: <20061129060130.GA2913@ime.usp.br>
References: <20061129060130.GA2913@ime.usp.br>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 04:01:30 -0200
Rogério Brito <rbrito@ime.usp.br> wrote:

>> The problem is that whenever I plug the Quantum drive, I get stack
> traces like this one (with a bit of context, so that you can get sense of
> what I am talking about):

Ok IRQ routing problem on what seems to be an external IRQ.
 
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
> PCI: setting IRQ 10 as level-triggered
> ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10

Do your working kernels also have ACPI enabled and what do they say here ?

> I am willing to do a git bisect to see which may be a problematic patch
> or not, but the "irq 10: nobody cared (try booting with the "irqpoll"
> option)" is one that I reported to Andrew quite some time ago (I thought
> that it had gone away), and it didn't manifest itself until I had to
> reuse this extra drive, since I am doing a work that is producing a lot
> of data.

Ok I have a guess here - what does 2.6.19-rc6-mm2 do ? I've been working
on fixing up the VIA IRQ routing bugs as it happens. full dmesg of the
work/fail cases and an lspci -vxxx would be useful so I can see how the
hardware thinks it is configured.
