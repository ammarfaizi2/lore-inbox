Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276928AbRJHPRF>; Mon, 8 Oct 2001 11:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276919AbRJHPQo>; Mon, 8 Oct 2001 11:16:44 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51213 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276336AbRJHPQh>; Mon, 8 Oct 2001 11:16:37 -0400
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: hadi@cyberus.ca (jamal)
Date: Mon, 8 Oct 2001 16:22:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        andrea@suse.de (Andrea Arcangeli), mingo@elte.hu (Ingo Molnar),
        linux-kernel@vger.kernel.org (Linux-Kernel), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.GSO.4.30.0110081106500.5473-100000@shell.cyberus.ca> from "jamal" at Oct 08, 2001 11:09:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qcES-0000rh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 8 Oct 2001, Alan Cox wrote:
> 
> > NAPI is important - the irq disable tactic is a last resort. If the right
> > hardware is irq flood aware it should only ever trigger to save us from
> > irq routing errors (eg cardbus hangs)
> 
> Agreed. As long as the IRQ flood protector can do proper isolation.
> Here's hat i see on my dell latitude laptop with a built in ethernet (not
> cardbus related ;->)

It doesnt save you from horrible performance. NAPI is there to do that, it
saves you from a dead box. You can at least rmmod the cardbus controller
with protection in place (or go looking for the problem with a debugger)
