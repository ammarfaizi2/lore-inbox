Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSIDRlG>; Wed, 4 Sep 2002 13:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311749AbSIDRlG>; Wed, 4 Sep 2002 13:41:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1620 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311025AbSIDRlF>; Wed, 4 Sep 2002 13:41:05 -0400
Date: Wed, 4 Sep 2002 13:45:33 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
Subject: Re: Linux 2.4.20-pre4-ac2
Message-ID: <20020904134533.A8891@devserv.devel.redhat.com>
References: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com> <200208270201.53750.nahshon@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208270201.53750.nahshon@actcom.co.il>; from nahshon@actcom.co.il on Tue, Aug 27, 2002 at 02:01:53AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Itai Nahshon <nahshon@actcom.co.il>
> Date: Tue, 27 Aug 2002 02:01:53 +0300

> +++ linux-2.4.20-pre4-ac2-i2/drivers/usb/storage/transport.c	Mon Aug 26 
> 23:24:53 2002
> @@ -1164,6 +1164,10 @@
>  				ret = USB_STOR_TRANSPORT_ABORTED;
>  				goto out;
>  			}
> +			if (result == US_BULK_TRANSFER_FAILED) {
> +				ret = USB_STOR_TRANSPORT_FAILED;
> +				goto out;
> +			}
>  		}
>  	}
> 
> There's a check for US_BULK_TRANSFER_FAILED after
> a call to usb_stor_transfer everywhere except here... Is it for 
> a reason?

Itai, submit this to Matt. I saw it too, coming from our Japan
support office. They claim a probem with installs from USB CD-ROM.
The report was very murky and I was unable to get any details
or confirm it, but it seems independent at least.

-- Pete
