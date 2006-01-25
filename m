Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbWAYEjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWAYEjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 23:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWAYEju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 23:39:50 -0500
Received: from fmr20.intel.com ([134.134.136.19]:31935 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751000AbWAYEju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 23:39:50 -0500
Subject: Re: [PATCH] ipw2200: fix ->eeprom[EEPROM_VERSION] check
From: Zhu Yi <yi.zhu@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060125004429.GE3234@mipter.zuzino.mipt.ru>
References: <20060125004429.GE3234@mipter.zuzino.mipt.ru>
Content-Type: text/plain
Organization: Intel Corp.
Date: Wed, 25 Jan 2006 12:34:17 +0800
Message-Id: <1138163657.9042.7.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Acked.

Thanks,
-yi

On Wed, 2006-01-25 at 03:44 +0300, Alexey Dobriyan wrote:
> priv->eeprom is a pointer.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/net/wireless/ipw2200.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/net/wireless/ipw2200.c
> +++ b/drivers/net/wireless/ipw2200.c
> @@ -2456,7 +2456,7 @@ static void ipw_eeprom_init_sram(struct 
>  	   copy.  Otherwise let the firmware know to perform the operation
>  	   on it's own
>  	 */
> -	if ((priv->eeprom + EEPROM_VERSION) != 0) {
> +	if (priv->eeprom[EEPROM_VERSION] != 0) {
>  		IPW_DEBUG_INFO("Writing EEPROM data into SRAM\n");
>  
>  		/* write the eeprom data to sram */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

