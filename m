Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbTCUVTk>; Fri, 21 Mar 2003 16:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263744AbTCUSiP>; Fri, 21 Mar 2003 13:38:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62727 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263754AbTCUSiE>;
	Fri, 21 Mar 2003 13:38:04 -0500
Date: Fri, 21 Mar 2003 10:49:10 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: fix whiteheat always returning -EFAULT
Message-ID: <20030321184910.GA15561@kroah.com>
References: <200303211950.h2LJo40o026043@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303211950.h2LJo40o026043@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:50:04PM +0000, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/usb/serial/whiteheat.c linux-2.5.65-ac2/drivers/usb/serial/whiteheat.c
> --- linux-2.5.65/drivers/usb/serial/whiteheat.c	2003-02-10 18:38:18.000000000 +0000
> +++ linux-2.5.65-ac2/drivers/usb/serial/whiteheat.c	2003-03-06 22:00:28.000000000 +0000
> @@ -783,7 +783,7 @@
>  			if (info->mcr & UART_MCR_RTS)
>  				modem_signals |= TIOCM_RTS;
>  			
> -			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)));
> +			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)))

Already in Linus's latest -bk tree :)

thanks,

greg k-h
