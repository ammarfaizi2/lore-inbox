Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFCFJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFCFJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 01:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFCFJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 01:09:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:57830 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261248AbVFCFIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 01:08:55 -0400
Date: Thu, 2 Jun 2005 22:19:07 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050603051907.GH28055@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3A4@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3A4@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 05:25:46PM -0500, Abhay_Salunke@Dell.com wrote:
> +/sys/firmware/dell_rbu/monolithic/mono_name
> +/sys/firmware/dell_rbu/monolithic/mono_size
> +/sys/firmware/dell_rbu/packetized/packet_name
> +/sys/firmware/dell_rbu/packetized/packet_size
> +
> +Steps to update the BIOS image:
> +
> +1> Copy the image file in to /lib/firmware 
> +2> echo the image name in to /sys/firmware/dell_rbu/xxxx/xxxx_name

No no no.  Just because you are using the firmware interface, does not
mean you need to add this extra round-trip to the whole system.  Just
dump the firmware to the /sys/firmware/whatever... file whenever you
want to, that's all that is needed.  No hotplug stuff, no filename
stuff, just a simple copy.

Also, see the -mm tree for a change in the way the sysfs attributes
work, that will keep you from having to do the .type stuff all over the
place.

thanks,

greg k-h
