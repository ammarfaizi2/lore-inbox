Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWAKNbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWAKNbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWAKNbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:31:47 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:26336 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751571AbWAKNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:31:46 -0500
Message-ID: <43C508E1.4080007@indt.org.br>
Date: Wed, 11 Jan 2006 09:32:17 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: linux-kernel@vger.kernel.org,
       "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       linux@arm.linux.org.uk, ext David Brownell <david-b@pacbell.net>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>
Subject: Re: [patch 4/5] Add MMC password protection (lock/unlock) support
 V3
References: <43C2E0BD.5040601@indt.org.br> <43C35850.2020104@drzeus.cx>
In-Reply-To: <43C35850.2020104@drzeus.cx>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2006 13:30:35.0094 (UTC) FILETIME=[33D12760:01C616B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Anderson Briglia wrote:
> 
> 
>>@@ -238,6 +295,11 @@ int mmc_register_card(struct mmc_card *c
>>			if (ret)
>>				device_del(&card->dev);
>>		}
>>+#ifdef CONFIG_MMC_PASSWORDS
>>+		ret = device_create_file(&card->dev, &mmc_dev_attr_lockable);
>>+		if (ret)
>>+			device_del(&card->dev);
>>+#endif
>>	}
>>	return ret;
>>}
>> 
>>
> 
> 
> It might be wise to also check the command classes here. I don't believe
> SDIO supports locking.

In this case, the lockable attribute will show "unlockable", which is the expected
behavior. The lockable attribute will always be present, the card being lockable or not.

Regards,

Anderson Briglia
INdT - Manaus


