Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbUDLXsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 19:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUDLXsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 19:48:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:3257 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263172AbUDLXsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 19:48:02 -0400
Date: Mon, 12 Apr 2004 16:45:11 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Karsten Keil <kkeil@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ISDN Mailing List <isdn4linux@listserv.isdn4linux.de>
Subject: Re: [PATCH] Add sysfs class support for CAPI
Message-ID: <20040412234511.GB27334@kroah.com>
References: <1081516925.13202.8.camel@pegasus> <20040409183220.GA16842@kroah.com> <1081628187.5398.36.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081628187.5398.36.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 10:16:27PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> this patch fixes a bug in the CAPI TTY support, because the ->name value
> of the TTY driver shouldn't contain a "/". After changing this there are
> now a "capi20" TTY device and a "capi20" control device and so I renamed
> the control device to "capi". The userspace visible part must be done by
> udev and I added these two rules to restore the old namespace:
> 
> 	# CAPI devices
> 	KERNEL="capi",          NAME="capi20", SYMLINK="isdn/capi20"
> 	KERNEL="capi*",         NAME="capi/%n"

Looks good.  I've applied your patch, and modified the udev main rules
file to add these rules.

thanks again,

greg k-h
