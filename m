Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTLVRhQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264453AbTLVRhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:37:16 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:38275 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264451AbTLVRhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:37:12 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 22 Dec 2003 09:37:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCMCIA updates
In-Reply-To: <20031222172102.G18991@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0312220934280.2108-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Dec 2003, Russell King wrote:

> | Patch from David Hinds
> | 
> | This is a forward port of a patch for 2.4.  This changes interrupt
> | allocation for 16-bit cards so that if ISA interrupts are all in
> | use, the bridge's PCI interrupt will be used.


>  #endif
> +    if (ret != 0) {
> +	if (!s->pci_irq)
> +	    return ret;
> +	irq = s->pci_irq;
>      }
> -    if (ret != 0) return ret;

Very nice to push this, since w/out this my orinoco does not come up.



- Davide


