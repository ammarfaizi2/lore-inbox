Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWAWOYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWAWOYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 09:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAWOYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 09:24:00 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:33623 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751421AbWAWOX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 09:23:59 -0500
From: David Brownell <david-b@pacbell.net>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] spi: Get rid of SPI_BUTTERFLY duplication.
Date: Mon, 23 Jan 2006 06:23:57 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060123134739.GA4172@linux-sh.org>
In-Reply-To: <20060123134739.GA4172@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601230623.57691.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2006 5:47 am, Paul Mundt wrote:
> CONFIG_SPI_BUTTERFLY is listed twice in drivers/spi/Kconfig, one will do
> fine..

Patch already sent to Linus, but thanks.  (Basically, a patch got
dropped, and this was one of the more visible symptoms.)

- dave


> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> ---
> 
>  drivers/spi/Kconfig |   10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index b77dbd6..7a75fae 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -75,16 +75,6 @@ config SPI_BUTTERFLY
>  	  inexpensive battery powered microcontroller evaluation board.
>  	  This same cable can be used to flash new firmware.
>  
> -config SPI_BUTTERFLY
> -	tristate "Parallel port adapter for AVR Butterfly (DEVELOPMENT)"
> -	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
> -	select SPI_BITBANG
> -	help
> -	  This uses a custom parallel port cable to connect to an AVR
> -	  Butterfly <http://www.atmel.com/products/avr/butterfly>, an
> -	  inexpensive battery powered microcontroller evaluation board.
> -	  This same cable can be used to flash new firmware.
> -
>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #
> 
