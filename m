Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVJ3LAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVJ3LAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 06:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVJ3LAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 06:00:46 -0500
Received: from [85.8.13.51] ([85.8.13.51]:30867 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932128AbVJ3LAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 06:00:46 -0500
Message-ID: <4364A7D6.2060006@drzeus.cx>
Date: Sun, 30 Oct 2005 12:00:38 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ralf@linux-mips.org
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [FIXME] Comments on serial and MMC changes in MIPS merge
References: <20051029220722.GI14039@flint.arm.linux.org.uk>
In-Reply-To: <20051029220722.GI14039@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Some comments on the recent MIPS merge:
> 
> 1. au1xxx mmc driver
> 
>    mmc_remove_host() does a safe shutdown of the MMC host, removing
>    cards and then powering down.  This must be called prior to the
>    driver thinking of tearing anything down.
> 
>    As for those disable_irq()...enable_irq(), are you aware that MMC
>    can start talking to the host as soon as you've called mmc_add_host() ?
> 

I'm also concerned about the ammount of protocol awareness in this
driver. Is there a spec available for this hardware? Perhaps the MMC
layer can export more information so that we can avoid switches on
specific MMC commands?

Rgds
Pierre
