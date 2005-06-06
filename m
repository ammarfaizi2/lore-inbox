Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVFFUSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVFFUSq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVFFUQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:16:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:50092 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261670AbVFFUMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:12:50 -0400
Date: Mon, 6 Jun 2005 13:12:38 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050606201238.GA13214@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3AD@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3AD@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 03:01:04PM -0500, Abhay_Salunke@Dell.com wrote:
> > Ok, in re-reading the firmware code, you are correct, it will still
> > timeout in 10 seconds and call your callback.
> > 
> > Which, in my opinion, is wrong.  We should have some way to say "wait
> > forever".  Care to change the firmware_class.c code to support this?
> Will give it a try. So far the request_firmware code calls
> kobject_hotplug with action as KOBJ_ADD. It invokes a hotplug script
> form user mode. I guess we need to have some reverse mechanism which is
> invoked when a user writes to the file.

Why?  Your completion function should be called when the file is closed,
right?

> > I was assuming that this would wait forever, and is why I pointed you
> in
> > this direction.  Sorry about the confusion here.
> > 
> I guess the earlier method of request_firmware would work out as is with
> the only disadvantage of the user having to depend on hotplug mechanism
> and echoing firmware name.
> Let me know if that is acceptable till we find a solution to wait for
> ever without using hotplug stuff.

Why not fix the firmware_class.c code now?  :)

thanks,

greg k-h
