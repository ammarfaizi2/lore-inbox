Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUCZAuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUCZAnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:43:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:60352 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263890AbUCZAlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:41:37 -0500
Date: Thu, 25 Mar 2004 16:41:02 -0800
From: Greg KH <greg@kroah.com>
To: James Lamanna <jamesl@appliedminds.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Figuring out USB device locations
Message-ID: <20040326004102.GA32057@kroah.com>
References: <406314EF.7040304@appliedminds.com> <20040325235740.GA30964@kroah.com> <40637A42.4080603@appliedminds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40637A42.4080603@appliedminds.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 04:33:06PM -0800, James Lamanna wrote:
> Greg KH wrote:
> 
> >On Thu, Mar 25, 2004 at 09:20:47AM -0800, James Lamanna wrote:
> >
> >>Is there an easy way to find out what /dev entries usb devices get 
> >>mapped to from userspace?
> >
> >
> >"easy way" on 2.4?  No, sorry.  You need 2.6 to determine this in a
> >simple manner.  But there are some files in the /proc/bus/usb/
> >and /proc/bus/input/ directories that will help you out.
> 
> Hmm...its not obvious to me how i can use /proc/bus/usb/xxx/yyy to get 
> the /dev entry information. I can get the USB device number, but I don't 
> see how to get at a mapping to a major/minor in /dev space (or is this 
> not possible in 2.4)...

Well, for mice you can corrispond the usb position found in
/proc/bus/usb/devices with the input information found in
/proc/bus/usb/input to determine which /dev file that mouse is
(possibly, but you might get a close guess there.)

But remember, under 2.4 this is quite difficult.  I suggest just giving
up and using 2.6 :)

thanks,

greg k-h
