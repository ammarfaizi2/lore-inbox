Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934284AbWKYIxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934284AbWKYIxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934357AbWKYIxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:53:23 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:34455 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S934284AbWKYIxW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:53:22 -0500
Message-ID: <45680488.8030508@drzeus.cx>
Date: Sat, 25 Nov 2006 09:53:28 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_lock_unlock.diff
References: <4564640B.1070004@indt.org.br>
In-Reply-To: <4564640B.1070004@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems I missed this...

Anderson Briglia wrote:
> +
> +    err = mmc_card_claim_host(card);
> +    if (err != MMC_ERR_NONE)
> +        goto out;
> +

As I said before, no locking in the command abstractions. The host
should be claimed somewhere further up the chain (in
mmc_lockable_store() right now).

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

