Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbSIYFFG>; Wed, 25 Sep 2002 01:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbSIYFFF>; Wed, 25 Sep 2002 01:05:05 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:1544 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261877AbSIYFFF>; Wed, 25 Sep 2002 01:05:05 -0400
Date: Wed, 25 Sep 2002 01:09:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Interrupt Sharing
In-Reply-To: <5F0021EEA434D511BE7300D0B7B6AB53050A4C9D@mail2.ggn.hcltech.com>
Message-ID: <Pine.LNX.4.44.0209250105210.14916-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2002, Mohamed Ghouse , Gurgaon wrote:

> But what if two PCI Devices are sharing the same interrupt line?
> Then how does the handler handle this?
> Can you please explain this handling by the Kernel?

have a look at arch/i386/kernel/irq.c:request_irq then go down to do_IRQ 
-> handle_IRQ_event. if you want the guts before that, check out 
arch/i386/kernel/entry.S around common_interrupt.

	Zwane


-- 
function.linuxpower.ca

