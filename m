Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVLSECA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVLSECA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVLSECA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:02:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:28593 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751333AbVLSEB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:01:59 -0500
Date: Sun, 18 Dec 2005 20:01:30 -0800
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: kay.sievers@vrfy.org, linux-kernel@vger.kernel.org
Subject: Re: net: swich device attribute creation to default attrs
Message-ID: <20051219040130.GA29145@kroah.com>
References: <20051219004256.GA29285@vrfy.org> <20051218.175938.54428509.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051218.175938.54428509.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 05:59:38PM -0800, David S. Miller wrote:
> From: Kay Sievers <kay.sievers@vrfy.org>
> Date: Mon, 19 Dec 2005 01:42:56 +0100
> 
> > Recent udev versions don't longer cover bad sysfs timing with built-in
> > logic. Explicit rules are required to do that. For net devices, the
> > following is needed:
> >   ACTION=="add", SUBSYSTEM=="net", WAIT_FOR_SYSFS="address"
> > to handle access to net device properties from an event handler without
> > races.
> > 
> > This patch changes the main net attributes to be created by the driver
> > core, which is done _before_ the event is sent out and will not require
> > the stat() loop of the WAIT_FOR_SYSFS key.
> 
> Kay/Greg, this looks fine, feel free to merge it in.

Will do, I'll add it to my tree, thanks for looking at it.

greg k-h
