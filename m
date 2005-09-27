Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVI0HSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVI0HSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVI0HSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:18:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:14030 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964834AbVI0HSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:18:46 -0400
Date: Mon, 26 Sep 2005 17:03:51 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>, markus.lidel@shadowconnect.com
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>
Subject: Re: [patch 01/28] I2O: remove class interface
Message-ID: <20050927000351.GA1219@suse.de>
References: <20050915070131.813650000.dtor_core@ameritech.net> <20050915070301.943754000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915070301.943754000.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 02:01:32AM -0500, Dmitry Torokhov wrote:
> I2O: remove i2o_device_class_interface misuse
> 
> The intent of class interfaces was to provide different
> 'views' at the same object, not just run some code every
> time a new class device is registered. Kill interface
> structure, make class core register default attributes
> and set up sysfs links right when registering class
> devices.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

I've applied this.  I've also cleaned up the class stuff some more and
converted the drivers/message/i2o/iop.c code to use the easier class and
class_device interfaces, as you should not have 2 refcounted structures
trying to control the same overall structure.  The i2o device structure
is still like this and remains to be fixed up.  If no one does it soon,
I'll clean it up too.

thanks,

greg k-h
