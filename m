Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVBCSA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVBCSA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVBCR7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:59:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:22442 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263164AbVBCRpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:45:43 -0500
Date: Thu, 3 Feb 2005 09:45:16 -0800
From: Greg KH <greg@kroah.com>
To: Jack Howarth <howarth@bromo.msbb.uc.edu>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: usb hotplug problems with 2.6.10
Message-ID: <20050203174516.GA24272@kroah.com>
References: <20050203150310.65CB71DC09A@bromo.msbb.uc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203150310.65CB71DC09A@bromo.msbb.uc.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 10:03:10AM -0500, Jack Howarth wrote:
> Alan,
>    I had mentioned a couple weeks back that with kernel 2.6.10, 
> the ability to hotplug usb keys in Fedora Core 2 and 3 has been broken.
> There is actually a bugzilla report on this with some useful information
> on manifestation of the problem....
> 
> https://bugzilla.redhat.com/beta/show_bug.cgi?id=119140
> 
> The problem can be hacked around for the moment in hotplug by
> repeatedly calling updfstab until the device appears in both
> /proc/scsi/scsi and /sys/bus/usb/drivers/usb-storage but it 
> would be nice is this could be fixed in the kernel.

How do you propose "fixing" this in the kernel?  Userspace needs to be
changed to go off of the /dev node showing up, not the usb hotplug event
(which can happen much sooner, as you have found out.)

I would recommend bringing this up with the Fedora developers.

thanks,

greg k-h
