Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUE1WNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUE1WNA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUE1WMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:12:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:14530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264160AbUE1WLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:11:04 -0400
Date: Fri, 28 May 2004 15:10:06 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-ID: <20040528221006.GB13851@kroah.com>
References: <20040529012030.795ad27e.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529012030.795ad27e.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 01:20:30AM +0400, Andrew Zabolotny wrote:
> Hello!
> 
> I'm going to submit the class_find_device() patch (attached for your
> convenience) as a pre-requisite for the backlight/lcd device class patch
> (also included so that you can take at it as well) via Russel King (the
> backlight/lcd patch is needed for our ARM-based handhelds framebuffer
> devices). Any comments/objections are welcome.
> 
> The LCD and backlight device classes were implemented with the following in
> mind:

Becides the comments that Todd had about the power management stuff, I
have the following comments:
	- please inline your patches, I can't quote them :(
	- you create the DEVICE_ATTR macro, why not use the one already
	  created for you (CLASS_DEVICE_ATTR will work I think.)
	- Don't do a unregister function by passing a string to it.
	  Explicitly pass the pointer of the object that you want to
	  unregister, like all other kernel interfaces do.  With that
	  change you no longer need the class_find_device() patch,
	  right?
	- How about some drivers that actually use this interface?
	  Again, you are creating interfaces with no examples of users
	  of the interface, which isn't acceptable.

thanks,

greg k-h
