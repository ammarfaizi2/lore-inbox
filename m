Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbTLaSmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 13:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTLaSmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 13:42:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:60630 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265225AbTLaSmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 13:42:00 -0500
Date: Wed, 31 Dec 2003 10:37:05 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_set_dac helper
Message-Id: <20031231103705.238ba07d.davem@redhat.com>
In-Reply-To: <3FF2F57A.80801@pobox.com>
References: <3FF2F57A.80801@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Dec 2003 11:12:42 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> It seems to me like a lot of drivers wind up getting their 
> pci_set_dma_mask stuff wrong, occasionally in subtle ways.  So, I 
> created a "give me 64-bit PCI DMA" helper function.
> 
> The attached patch demonstrates its use in tg3, from which the logic 
> originated.  It also fixes a tiny bug in tg3, whereby it might return 
> zero on error (rather than -EFOO) if the pci_set_dma_mask succeeds but 
> pci_set_consistent_dma_mask fails.

I'm fine with the helper.

The tg3 error return bug you noticed is already fixed in the tg3
updates I'm sending to Linus today.
