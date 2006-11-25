Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933985AbWKYIq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933985AbWKYIq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934217AbWKYIq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:46:57 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:32407 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S933985AbWKYIq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:46:56 -0500
Message-ID: <45680308.4040809@drzeus.cx>
Date: Sat, 25 Nov 2006 09:47:04 +0100
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

Anderson Briglia wrote:
> @@ -244,5 +244,13 @@ struct _mmc_csd {
>  #define SD_BUS_WIDTH_1      0
>  #define SD_BUS_WIDTH_4      2
>
> +/*
> + * MMC_LOCK_UNLOCK modes
> + */
> +#define MMC_LOCK_MODE_ERASE    (1<<3)
> +#define MMC_LOCK_MODE_UNLOCK    (0<<2)
> +#define MMC_LOCK_MODE_CLR_PWD    (1<<1)
> +#define MMC_LOCK_MODE_SET_PWD    (1<<0)
> +
>  #endif  /* MMC_MMC_PROTOCOL_H */
>

This definition makes them look like bits, which is not how they are used.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

