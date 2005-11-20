Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVKTWfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVKTWfs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKTWfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:35:48 -0500
Received: from [81.2.110.250] ([81.2.110.250]:45711 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750723AbVKTWfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:35:47 -0500
Subject: Re: 2.6.14.2: repeated oops in i810 init
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4380EB33.2060305@eyal.emu.id.au>
References: <4380EB33.2060305@eyal.emu.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Nov 2005 23:05:34 +0000
Message-Id: <1132527934.459.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-21 at 08:31 +1100, Eyal Lebedinsky wrote:
> I boot with 'irqpoll' which actually does not prevent the SATA
> failures.

irqpoll tries. 

The trace is interesting.

> EIP is at i810_interrupt+0x27/0xa0 [i810_audio]

i810_interrupt was called by misrouted_irq (trying to find an owner for
an IRQ that occurred and nobody claimed), then blew up.

Can you see if the parameters to the i810_interrupt look correct when it
dies (eg printk them)


