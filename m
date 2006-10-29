Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWJ2J0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWJ2J0M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWJ2J0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:26:12 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:8851 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932127AbWJ2J0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:26:11 -0500
Message-ID: <454473B0.8040901@drzeus.cx>
Date: Sun, 29 Oct 2006 10:26:08 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
CC: linux-kernel@vger.kernel.org, linux-omap-open-source@linux.omap.com,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, ilias.biris@indt.org.br
Subject: Re: [patch 1/6] [RFC] Add MMC Password Protection (lock/unlock) support
 V5
References: <20061020164914.012378000@localhost.localdomain> <20061020165131.681329000@localhost.localdomain>
In-Reply-To: <20061020165131.681329000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Aguiar wrote:
> When a card is locked, only commands from the "basic" and "lock card" classes
> are accepted. To be able to use the other commands, the card must be unlocked
> first.
>
> This patch prevents the block driver from trying to run privileged class
> commands on locked MMC cards, which will fail anyway.
>   

Incorrect commit message. It stops driver probes (all of them).

> 20 11:41:54.000000000 -0400
> @@ -85,6 +85,7 @@ struct mmc_host {
>  	unsigned long		caps;		/* Host capabilities */
>  
>  #define MMC_CAP_4_BIT_DATA	(1 << 0)	/* Can the host do 4 bit transfers */
> +#define MMC_CAP_LOCK_UNLOCK	(1 << 1)	/* Host password support capability */
>  
>  	/* host specific block data */
>  	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
>
>   

You  need to rebase your patch set on a more recent kernel. This won't
apply cleanly.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

