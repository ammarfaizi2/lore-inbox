Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVKWSSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVKWSSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVKWSSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:18:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42967 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932132AbVKWSSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:18:31 -0500
Date: Wed, 23 Nov 2005 13:18:30 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Bob Copeland <me@bobcopeland.com>
cc: linux-kernel@vger.kernel.org, <usb-storage@lists.one-eyed-alien.net>
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Add support for Rio Karma
In-Reply-To: <20051123113342.GA5815@hash.localnet>
Message-ID: <Pine.LNX.4.44L0.0511231316410.12957-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Bob Copeland wrote:

> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -145,6 +145,13 @@ UNUSUAL_DEV(  0x0451, 0x5416, 0x0100, 0x
>  		US_SC_DEVICE, US_PR_BULK, NULL,
>  		US_FL_NEED_OVERRIDE ),
>  
> +#ifdef CONFIG_USB_STORAGE_KARMA
> +UNUSUAL_DEV(  0x045a, 0x5210, 0x0101, 0x0101,
> +		"Rio",
> +		"Rio Karma",
> +		US_SC_SCSI, US_PR_BULK, rio_karma_init, US_FL_FIX_INQUIRY),

Are you sure you need US_SC_SCSI and US_PR_BULK?  Wouldn't US_SC_DEVICE 
and US_PR_DEVICE be sufficient?

And do you really need US_FL_FIX_INQUIRY?  Hardly any devices do (maybe 
none).

Alan Stern

