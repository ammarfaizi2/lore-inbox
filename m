Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750977AbWFELPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWFELPX (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWFELPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:15:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41861 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750975AbWFELPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:15:23 -0400
Subject: Re: move zd1201 where it belongs
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jirka Lenost Benc <jbenc@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060605103952.GA1670@elf.ucw.cz>
References: <20060605103952.GA1670@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 13:15:20 +0200
Message-Id: <1149506120.3111.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 12:39 +0200, Pavel Machek wrote:
> zd1201 is wifi adapter, yet it is hiding in drivers/usb/net where
> noone can find it. This moves Kconfig/Makefile to right place; you
> still need to manually move .c and .h files.
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
> index e0874cb..313cfad 100644
> --- a/drivers/net/wireless/Kconfig
> +++ b/drivers/net/wireless/Kconfig
> @@ -503,6 +503,23 @@ config PRISM54
>  	  say M here and read <file:Documentation/modules.txt>.  The module
>  	  will be called prism54.ko.
>  
> +config USB_ZD1201
> +	tristate "USB ZD1201 based Wireless device support"
> +	depends on NET_RADIO
> +	select FW_LOADER

do you think it should at least depend in some form or another on
CONFIG_USB ?

