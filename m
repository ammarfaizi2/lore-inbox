Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbULVFGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbULVFGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbULVFGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:06:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:20160 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261303AbULVFGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:06:42 -0500
Date: Tue, 21 Dec 2004 21:06:24 -0800
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041222050624.GC31076@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <20041222005726.GA13317@kroah.com> <20041221172906.3b9cbbbd@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041221172906.3b9cbbbd@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 05:29:06PM -0800, Pete Zaitcev wrote:
> On Tue, 21 Dec 2004 16:57:26 -0800, Greg KH <greg@kroah.com> wrote:
> 
> > It looks great, thanks for doing this work.  Let me know when you want
> > it added to the kernel tree.
> 
> Thanks, Greg. There's a little tidbit in usbmon about which I wish you to
> make a pronouncement explicitly:
> 
> +	/* XXX Is this how I pin struct bus? Ask linux-usb-devel */
> +	kobject_get(&ubus->class_dev.kobj);
> +	mbus->u_bus = ubus;
> +	ubus->mon_bus = mbus;

Use usb_bus_get() instead.  Ick, that function's implementation sucks,
I'll go clean it up and export it for you to be able to use from your
code.

thanks,

greg k-h
