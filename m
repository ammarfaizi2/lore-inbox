Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWIOH4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWIOH4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWIOH4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:56:32 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:50172 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750696AbWIOH4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:56:31 -0400
Date: Fri, 15 Sep 2006 09:56:29 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch 3/4] AVR32 MTD: Mapping driver for the
 ATSTK1000board
Message-ID: <20060915095629.22cf01f4@cad-250-152.norway.atmel.com>
In-Reply-To: <1158264688.4312.82.camel@pmac.infradead.org>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
	<20060914163026.49766346@cad-250-152.norway.atmel.com>
	<20060914163121.241dec3e@cad-250-152.norway.atmel.com>
	<20060914163259.068abe6d@cad-250-152.norway.atmel.com>
	<1158264688.4312.82.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006 21:11:28 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Thu, 2006-09-14 at 16:32 +0200, Haavard Skinnemoen wrote:
> > Add mapping driver for the AT49BV6416 NOR flash chip on the
> > ATSTK1000 development board. 
> 
> Hm, can't you set it up in advance and just register a platform_device
> for physmap to drive?

Probably. I'll give it a try.

I have to find a way to unlock the flash at some point, though. Is it
okay if I add code to physmap to iterate over the partitions and unlock
the writable ones if info->mtd->unlock is non-null? Or is there a
better way to do it?

Andrew, please don't merge any of the patches in this series. I just
noticed that the SMC patch should be cleaned up a bit, so I'm
probably going to rework all the patches.

(btw, I got an "awaiting moderator approval" message from the linux-mtd
mailer because "Message has a suspicious header". Can someone tell me
more about this so I can fix my mailer?)

Thanks,

Haavard
