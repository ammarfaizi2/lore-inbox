Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVEWPnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVEWPnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 11:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVEWPnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 11:43:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:15580 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261892AbVEWPnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 11:43:31 -0400
Date: Mon, 23 May 2005 08:50:23 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050523155023.GA10909@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED389@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED389@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 10:36:37AM -0500, Abhay_Salunke@Dell.com wrote:
> > > > Also, what's wrong with using the existing firmware interface in the
> > > > kernel?
> > > request_firmware requires the $FIRMWARE env to be populated with the
> > > firmware image name or the firmware image name needs to be hardcoded
> > > within  the call to request_firmware.
> > 
> > the latter one. Don't mess with the $FIRMWARE env, because this comes
> > from the kernel hotplug call.
> > 
> > > Since the user is free to change
> > > the BIOS update image at will, it may not be possible if we use
> > > $FIRMWARE also I am not sure if this env variable might be conflicting
> > > to some other driver.
> > 
> > I am not quite sure what's the problem here. Tell the kernel what
> > firmware image to request. Something like
> > 
> > 	echo "firmware-filename" > /sys/firmware/dell_rbu/download
> > 
> Looks like request_firmware is causing lots of changes in my code. For
> now I would just focus on getting the size parameters in normal sysfs
> attribute and do request_firmware some time later as a separate patch.

Well, as they will be the "correct" type of changes, I recommend you do
them too :)

thanks,

greg k-h
