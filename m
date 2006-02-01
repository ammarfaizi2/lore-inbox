Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWBAQCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWBAQCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWBAQCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:02:22 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:62637 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422660AbWBAQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:02:21 -0500
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usbcore: fix compile error with CONFIG_USB_SUSPEND=n
Date: Wed, 1 Feb 2006 08:01:48 -0800
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0602011044270.5635-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0602011044270.5635-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010801.48348.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 7:47 am, Alan Stern wrote:

> This should fix it.

Well, a warning which in this case actually does indicate an
error ... but yes, this looks right.  Thanks.

- Dave

 
> Index: usb-2.6/drivers/usb/core/hub.c
> ===================================================================
> --- usb-2.6.orig/drivers/usb/core/hub.c
> +++ usb-2.6/drivers/usb/core/hub.c
> @@ -1890,8 +1890,8 @@ int usb_resume_device(struct usb_device 
>  			status = hub_port_resume(hdev_to_hub(udev->parent),
>  					udev->portnum, udev);
>  		} else
> -			status = 0;
>  #endif
> +			status = 0;
>  	} else
>  		status = finish_device_resume(udev);
>  	if (status < 0)
> 
