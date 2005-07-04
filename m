Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVGDIZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVGDIZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 04:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVGDIZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 04:25:39 -0400
Received: from [85.8.12.41] ([85.8.12.41]:22716 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261268AbVGDIZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 04:25:29 -0400
Message-ID: <42C8F26E.3080403@drzeus.cx>
Date: Mon, 04 Jul 2005 10:25:18 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ISA DMA API documentation
References: <42C712C9.7080603@drzeus.cx> <20050703205834.51b43435.rdunlap@xenotime.net>
In-Reply-To: <20050703205834.51b43435.rdunlap@xenotime.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

randy_dunlap wrote:

>+The DMA:able address space is the lowest 16 MB of _physical_ memory.
> The DMA-able
>+Also the transfer block may not cross page boundaries (which are 64k).
> I would write:                                        (which are 64 KB).
>
>if I knew that was correct, but I don't.
>Does Linux limit all ISA-DMA to not crossing 64 KB boundaries?
>I haven't looked at the code yet, just PC-AT Technical Reference,
>which says that DMA controller 1 is limited to 8-bit transfers and
>64 KB blocks and DMA controller 2 is limited to 16-bit data transfers
>and 128 KB boundaries.
>Does i386-compatible and later chipsets or LPC change/affect this?
>(I see that you cover 8/16-bit transfers later in the doc.)
>  
>

Sorry, my bad. 128k is quite correct for 16-bit data transfers. I've
just been using 8-bit transfers so I got a bit too familiar with just
those. :)

>+To translate the virtual address to a physical use the normal DMA
>+API. Do _not_ use isa_virt_to_phys() even though it does the same
>+thing. The reason for this is that you will get a requirement to ISA
>+(instead of only ISA_DMA_API).
>
>I don't understand what you are trying to say in:
>... is that you will get a requirement to ISA....
>Oh, it's Kconfig-related, right?  So maybe:
>"... is that you will get a config requirement for ISA..." ?
>
>  
>

Yes, that's what I'm trying to say. I'll try to make it clearer.


Thanks for the feedback. I'll get your suggestions in and post a new patch.

Rgds
Pierre

