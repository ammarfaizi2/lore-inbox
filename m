Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbVKHCFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbVKHCFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVKHCFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:05:18 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:4365 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965211AbVKHCFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:05:10 -0500
Date: Mon, 7 Nov 2005 21:04:53 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Jan Niehusmann <jan@gondor.com>
Cc: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       James Ketrenos <jketreno@linux.intel.com>
Subject: Re: [PATCH] Re: IPW Question on menuconfig
Message-ID: <20051108020450.GB25686@tuxdriver.com>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Ketrenos <jketreno@linux.intel.com>
References: <434B2AE2.1070709@linuxwireless.org> <20051023223658.GA5367@knautsch.gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051023223658.GA5367@knautsch.gondor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do we want this patch?  If yes, Jan could you reformat your posting
according to the rules described here:

	http://linux.yyz.us/patch-format.html

Please pay particular attention to formatting your subject and
changelog information.

Thanks,

John

On Mon, Oct 24, 2005 at 12:36:58AM +0200, Jan Niehusmann wrote:
> On Mon, Oct 10, 2005 at 09:00:50PM -0600, Alejandro Bonilla Beeche wrote:
> > Network devices / Wireless, and the IPW2100 wasn't in the list. I went, 
> > then Modularized the IEEE80211 and then IPW2100 was there. I think is 
> > kind of estrange that IPW2100 wouldn't show just because it has a 
> > dependencie, shouldn't IPW2100 show in the list, and if you select it, 
> > then it would also select CONFIG_IEEE80211?
> 
> I think you are right, so the config script should be changed like shown
> below. (But I'm not really familiar with the config language, so I may
> be missing some obvious problems?)
> 
> Signed-off-by: Jan Niehusmann <jan@gondor.com>
> (in case somebody cares for that for such a small change...)
> 
> 
> diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
> --- a/drivers/net/wireless/Kconfig
> +++ b/drivers/net/wireless/Kconfig
> @@ -139,8 +139,9 @@ comment "Wireless 802.11b ISA/PCI cards 
>  
>  config IPW2100
>  	tristate "Intel PRO/Wireless 2100 Network Connection"
> -	depends on NET_RADIO && PCI && IEEE80211
> +	depends on NET_RADIO && PCI
>  	select FW_LOADER
> +	select IEEE80211
>  	---help---
>            A driver for the Intel PRO/Wireless 2100 Network 
>  	  Connection 802.11b wireless network adapter.
> @@ -192,8 +193,9 @@ config IPW_DEBUG
>  
>  config IPW2200
>  	tristate "Intel PRO/Wireless 2200BG and 2915ABG Network Connection"
> -	depends on IEEE80211 && PCI
> +	depends on PCI
>  	select FW_LOADER
> +	select IEEE80211
>  	---help---
>            A driver for the Intel PRO/Wireless 2200BG and 2915ABG Network
>  	  Connection adapters. 
>  
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
John W. Linville
linville@tuxdriver.com
