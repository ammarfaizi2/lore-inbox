Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUIJPOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUIJPOG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIJPOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:14:04 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:63387
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267452AbUIJPN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:13:57 -0400
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>
In-Reply-To: <4141BFDF.1050200@inet6.fr>
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
	 <4141BFDF.1050200@inet6.fr>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1094828803.13450.4.camel@thomas.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 17:06:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 16:53, Lionel Bouton wrote:
> Thomas Gleixner wrote the following on 09/10/2004 04:29 PM :
> 
> >Hi,
> >
> >1. If the fake 5513 id bit is not set by the BIOS we must have the 5518
> >id in the device table.
> >
> >2. If the register remapping is not set by the BIOS then the enable bit
> >check in ide_pci_setup_ports will fail. It's safe to switch to the
> >remapping mode here. Keeping the not remapped mode would need quite big
> >changes AFAICS.
>
> I was worried about these when 5518 was introduced but couldn't test on 
> the hardware I had at hand and nobody reported hitting this so it went 
> under the carpet. What hardware did you use to test ?

Compact PCI ICP-P4 from Inova Computers.

They have not set the 5513 fake id bit and the remapping bit isn't set
either. I did thorough testing both on 2.4 and 2.6 and encountered no
problems yet. I suspect there are more boards around with similar
settings.

tglx


