Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWAJGqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWAJGqz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWAJGqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:46:55 -0500
Received: from [85.8.13.51] ([85.8.13.51]:32452 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750752AbWAJGqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:46:52 -0500
Message-ID: <43C35850.2020104@drzeus.cx>
Date: Tue, 10 Jan 2006 07:46:40 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 4/5] Add MMC password protection (lock/unlock) support
 V3
References: <43C2E0BD.5040601@indt.org.br>
In-Reply-To: <43C2E0BD.5040601@indt.org.br>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:

>@@ -238,6 +295,11 @@ int mmc_register_card(struct mmc_card *c
> 			if (ret)
> 				device_del(&card->dev);
> 		}
>+#ifdef CONFIG_MMC_PASSWORDS
>+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
>+		if (ret)
>+			device_del(&card->dev);
>+#endif
> 	}
> 	return ret;
> }
>  
>

It might be wise to also check the command classes here. I don't believe
SDIO supports locking.

Rgds
Pierre

