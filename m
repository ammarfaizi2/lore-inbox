Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVJNDff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVJNDff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 23:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVJNDff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 23:35:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:24983 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751081AbVJNDfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 23:35:34 -0400
Date: Thu, 13 Oct 2005 20:31:19 -0700
From: Greg KH <greg@kroah.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Christian Krause <chkr@plauener.de>, linux-kernel@vger.kernel.org
Subject: Re: bug in handling of highspeed usb HID devices
Message-ID: <20051014033118.GA7956@kroah.com>
References: <101420050210.18923.434F13890004C6F8000049EB220076106400009A9B9CD3040A029D0A05@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101420050210.18923.434F13890004C6F8000049EB220076106400009A9B9CD3040A029D0A05@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 02:10:17AM +0000, Parag Warudkar wrote:
> > 
> > Also, what device needs this patch?  Is it a device that I can buy
> > today?
> > 
> > thanks,
> > 
> > greg k-h
> 
> The patch is for hid-core.c - I don't think it is device specific -
> original problem should affect all High Speed USB HID devices. 

I realize that, my point is are there any such devices out in the wild
that people can buy and use?  I do not know of any.

> To summarize -
> 
> Current code just looks plain wrong since the same logic is repeated
> twice - endpoint->bInterval is operated upon twice if the device is
> HIGH SPEED one.

I agree.  That's wrong and should be fixed.  A patch would be nice...

thanks,

greg k-h
