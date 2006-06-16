Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWFPXOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWFPXOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWFPXNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:13:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:32408 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932287AbWFPXMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:36 -0400
Date: Fri, 16 Jun 2006 16:09:29 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, aviro@www.linux.org.uk, axboe@suse.de,
       nigel@suspend2.net
Subject: Re: Sparse minor space in ub
Message-ID: <20060616230929.GB31626@kroah.com>
References: <20060614235404.31b70e00.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614235404.31b70e00.zaitcev@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 11:54:04PM -0700, Pete Zaitcev wrote:
> --- linux-2.6.17-rc5/Documentation/devices.txt	2006-05-25 14:02:59.000000000 -0700
> +++ linux-2.6.17-rc5-lem/Documentation/devices.txt	2006-05-25 15:45:34.000000000 -0700
> @@ -2552,10 +2552,10 @@ Your cooperation is appreciated.
>  		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
>  
>  180 block	USB block devices
> -		0 = /dev/uba		First USB block device
> -		8 = /dev/ubb		Second USB block device
> -		16 = /dev/ubc		Thrid USB block device
> -		...
> +		  0 = /dev/uba		First USB block device
> +		 16 = /dev/ubb		Second USB block device
> +		 32 = /dev/ubc		Third USB block device
> +		    ...

I don't think that distros that have a static /dev will like this change
at all :(

Anyway to put the extra partitions some where else in the minor range?

thanks,

greg k-h
