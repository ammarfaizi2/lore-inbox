Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbVKGH7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbVKGH7K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKGH7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:59:09 -0500
Received: from mailserv.intranet.GR ([146.124.14.106]:32995 "EHLO
	mailserv.intranet.gr") by vger.kernel.org with ESMTP
	id S1751297AbVKGH7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:59:08 -0500
Message-ID: <436F07F5.1030206@intracom.gr>
Date: Mon, 07 Nov 2005 09:53:25 +0200
From: Pantelis Antoniou <panto@intracom.gr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051101)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.14] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
References: <20051106025701.GA9698@tuxdriver.com>
In-Reply-To: <20051106025701.GA9698@tuxdriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> Make CONFIG_FEC_8XX depend on CONFIG_8xx.  This keeps allmodconfig from
> breaking on non-8xx (PPC) platforms.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> 
>  drivers/net/fec_8xx/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fec_8xx/Kconfig b/drivers/net/fec_8xx/Kconfig
> index 4560026..a84c232 100644
> --- a/drivers/net/fec_8xx/Kconfig
> +++ b/drivers/net/fec_8xx/Kconfig
> @@ -1,6 +1,6 @@
>  config FEC_8XX
>  	tristate "Motorola 8xx FEC driver"
> -	depends on NET_ETHERNET
> +	depends on NET_ETHERNET && 8xx
>  	select MII
>  
>  config FEC_8XX_GENERIC_PHY

Yes, this is the correct approach. Please disregard the other
patches floating about.

Regards

Pantelis

