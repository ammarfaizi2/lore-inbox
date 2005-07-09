Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263085AbVGICkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbVGICkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 22:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVGICkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 22:40:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:18857 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263085AbVGICkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 22:40:04 -0400
Date: Fri, 8 Jul 2005 19:40:00 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc1] driver core: subclasses
Message-ID: <20050709024000.GA7608@kroah.com>
References: <20050708225448.GA18193@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708225448.GA18193@lists.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 05:54:48PM -0500, Matt Domsch wrote:
> Greg,
> 
> The below patch is a first pass at implementing subclasses, for review
> and comment.
> 
> As a test, I modified drivers/input/input.c to allocate a new class,
> and register it as a subclass.
> 
> Before:
> 
> /sys/class/input/
> /sys/class/input_device/
> 
> After:
> /sys/class/input/input_device/

Oops, when you mentioned this on irc, I thought you were referring to
class_devices not classes.  I don't want classes to be able to be
nested, only class devices.

I don't see a need for nested classes, as I thought the input thread had
resolved itself so that it didn't need it (but I stopped paying
attention, sorry, so I might be wrong here...)

Why can't you just use class_device's that can have children?  That way
the /sys/block stuff could be converted to also use this.

thanks,

greg k-h
