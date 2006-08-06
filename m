Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWHFU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWHFU5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWHFU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:57:31 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:390 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750700AbWHFU5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:57:31 -0400
Message-ID: <44D657BF.6070004@drzeus.cx>
Date: Sun, 06 Aug 2006 22:57:35 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx> <20060806204842.GE16816@flint.arm.linux.org.uk>
In-Reply-To: <20060806204842.GE16816@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sun, Aug 06, 2006 at 10:22:23PM +0200, Pierre Ossman wrote:
>> There were some confusion about base I/O variables in the wbsd driver.
>> Seems like things have been working on shear luck so far. The global 'io'
>> variable (used when manually configuring the resources) was used instead of
>> the local 'base' variable.
> 
> Applied, thanks.
> 
> Shouldn't "base" be something other than "int" (eg, unsigned long) ?

unsigned short would probably be the right<tm> thing as the resource is
16 bits. I haven't seen it as big enough issue to warrant a patch.

> Also, wbsd_init() takes base, irq, dma but passes wbsd_request_resources
> io, irq and dma?  I suspect more fixes are on their way... 8)

*sigh*

And I thought this brown paper bag was just temporary...

Rgds
Pierre
