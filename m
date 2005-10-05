Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVJEWFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVJEWFG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbVJEWFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:05:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:49078 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030315AbVJEWFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:05:04 -0400
Date: Wed, 5 Oct 2005 15:03:17 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 08/28] Input: prepare to sysfs integration
Message-ID: <20051005220316.GA2932@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070302.813567000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915070302.813567000.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:01:39AM -0500, Dmitry Torokhov wrote:
> Input: prepare to sysfs integration
> 
> Add struct class_device to input_dev; add input_allocate_dev()
> to dynamically allocate input devices; dynamically allocated
> devices are automatically registered with sysfs.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Ok, I've applied this one, and the other "convert the input drivers to
be dynamic" to my tree, as this is all great work.

I'll work on the last few patches that you have, with regard to how to
tie it into sysfs "properly" now, and get back to you, just wanted to
apply all of these, so we have a common base to work on.

Oh, I did change one thing in this patch:

>  
> +EXPORT_SYMBOL(input_allocate_device);

I made that EXPORT_SYMBOL_GPL().  Let me know if you object to this.

thanks,

greg k-h
