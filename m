Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264050AbUDBODu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264049AbUDBODu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:03:50 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:47369 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264051AbUDBODs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:03:48 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
Date: Fri, 2 Apr 2004 16:03:05 +0200
User-Agent: KMail/1.6.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       Greg KH <greg@kroah.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk>
In-Reply-To: <20040402144216.A12306@flint.arm.linux.org.uk>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404021603.05688@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 15:42, Russell King wrote:

Hi Russel,

> --- orig/drivers/usb/storage/Kconfig	Sat Mar 20 09:22:45 2004
> +++ linux/drivers/usb/storage/Kconfig	Fri Apr  2 14:41:05 2004
> @@ -4,8 +4,7 @@
>
>  config USB_STORAGE
>  	tristate "USB Mass Storage support"
> -	depends on USB
> -	select SCSI
> +	depends on USB && SCSI
>  	---help---
>  	  Say Y here if you want to connect USB mass storage devices to your
>  	  computer's USB port. This is the driver you need for USB floppy drives,
> @@ -13,6 +12,9 @@ config USB_STORAGE
>  	  similar devices. This driver may also be used for some cameras and
>  	  card readers.
>
> +	  Please select SCSI support before enabling USB Mass Storage
> +	  support.
> +
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called usb-storage.

pretty useless if you do not see "USB Mass Storage support" config options due 
to disabled SCSI ;)

I'd suggest a comment, when SCSI is disabled, that USB Mass Storage is 
disabled unless you select SCSI. I tried to cook up a simple patch but it 
seems I don't know kbuild very well. The menu structure messed up after I did 
it.

ciao, Marc
