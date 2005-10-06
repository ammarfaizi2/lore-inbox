Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVJFA00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVJFA00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 20:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVJFA0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 20:26:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:18829 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030459AbVJFA0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 20:26:25 -0400
Date: Wed, 5 Oct 2005 17:26:05 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
Subject: Re: [PATCH] nesting class_device in sysfs to solve world peace
Message-ID: <20051006002605.GA4694@suse.de>
References: <20050928233114.GA27227@suse.de> <200509300032.50408.dtor_core@ameritech.net> <20051006000951.GA4411@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006000951.GA4411@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 05:09:51PM -0700, Greg KH wrote:
> -	class_device_create(input_class, NULL,
> +	class_device_create(&input_dev_class, &dev->cdev,
>  			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
> -			dev->dev, "mouse%d", minor);
> +			dev->cdev.dev, "mouse%d", minor);

Yeah, I know mixing this call with the input_dev_class is a ripe for
badness, I'll fix it up properly soon, this was just a "proof of
concept".

thanks,

greg k-h
