Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUIRP6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUIRP6E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269580AbUIRP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:58:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:49115 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268750AbUIRP6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:58:01 -0400
Date: Sat, 18 Sep 2004 08:57:31 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: bus_type->dev_attrs not properly thought out
Message-ID: <20040918155731.GA24022@kroah.com>
References: <20040918155659.B17085@flint.arm.linux.org.uk> <200409181043.42268.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409181043.42268.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 10:43:41AM -0500, Dmitry Torokhov wrote:
> What's wrong with the following (drivers/input/serio/serio.c):
> 
> static struct device_attribute serio_device_attrs[] = {
>         __ATTR(description, S_IRUGO, serio_show_description, NULL),

You should use __ATTR_RO() for that one :)

>         __ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver),
>         __ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
>         __ATTR_NULL
> };
> 
> Pretty compact and expressive IMHO.

Yes, that's the way to currently do it.  Russell, is that acceptable?

thanks,

greg k-h
