Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbUCTTtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 14:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUCTTtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 14:49:17 -0500
Received: from 194.149.109.108.adsl.nextra.cz ([194.149.109.108]:31901 "EHLO
	gate2.perex.cz") by vger.kernel.org with ESMTP id S263518AbUCTTtN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 14:49:13 -0500
Date: Sat, 20 Mar 2004 20:44:44 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
In-Reply-To: <20040320160911.B6726@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com>
 <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz>
 <20040320160911.B6726@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Russell King wrote:

> It is well known that virt_to_page() is only valid on virtual addresses
> which correspond to kernel direct mapped RAM pages, and undefined on
> everything else.  Unfortunately, ALSA has been using it with
> pci_alloc_consistent() for a long time, and this behaviour is what
> makes ALSA broken.  The fact it works on x86 is merely incidental.

It works on PPC as well (at least we have no error reports).

> If ALSA wants this functionality, the ALSA people should ideally have
> put their requirements forward during the 2.5 development cycle so the
> problem could be addressed.

Yes, I'm sorry about that, but the ->nopage usage was requested by Jeff
Garzik and we're not gurus for the VM stuff. Because we're probably first
starting using of this mapping scheme, it resulted to problems.

> However, luckily in this instance, it is not a big problem to solve.  
> It just requires time to sort through all the abstraction layers upon
> abstraction layers which ALSA has.
> 
> - and I'm doing exactly this, right now.  Be patient. -

Thanks a lot.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
