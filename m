Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTCOJi1>; Sat, 15 Mar 2003 04:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbTCOJi1>; Sat, 15 Mar 2003 04:38:27 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:12693 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261368AbTCOJiZ>;
	Sat, 15 Mar 2003 04:38:25 -0500
Date: Sat, 15 Mar 2003 10:49:01 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.64
Message-ID: <20030315104901.A3923@ucw.cz>
References: <10476033263399@kroah.com> <10476033262095@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10476033262095@kroah.com>; from greg@kroah.com on Thu, Mar 13, 2003 at 04:55:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 04:55:00PM -0800, Greg KH wrote:

> diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
> --- a/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 13 16:56:52 2003
> +++ b/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 13 16:56:52 2003
 		goto out_release_region;
> @@ -389,7 +392,7 @@
>  }
>  
>  static struct pci_driver amd8111_driver = {
> -	.name		= "amd8111 smbus 2.0",
> +	.name		= "amd8111 smbus",
>  	.id_table	= amd8111_ids,
>  	.probe		= amd8111_probe,
>  	.remove		= __devexit_p(amd8111_remove),

The 2.0 was quite intentional in the .name, because the 8111 has *two*
SMBus busses, one SMBus 1.1 and one SMBus 2.0. This driver is only for
the 2.0 SMBus controller.

-- 
Vojtech Pavlik
SuSE Labs
