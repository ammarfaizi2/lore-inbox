Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVCRQxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVCRQxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVCRQwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:52:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:62358 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261699AbVCRQvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:51:42 -0500
Date: Fri, 18 Mar 2005 08:51:24 -0800
From: Greg KH <gregkh@suse.de>
To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
Message-ID: <20050318165124.GC14952@kroah.com>
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 10:57:14AM +0200, Jacques Goldberg wrote:
> 
>  Not subscribing because this is a one time question.
>  Please Cc: to the reply address above , Jacques.Goldberg@cern.ch
> 
>  Several winmodem devices come with a hardware burnt-in identification
> misleading the system to load the serial driver.
>  As a result, it is not possible to load the special driver because the
> PCI device is grabbed by the serial driver.
> 
>  Question: is there a way, as of kernels 2.6.10 and above, to release the
> device from the serial driver, without having to recompile the kernel?

I have a patch around somewhere that provides a way to do this from
userspace and sysfs, but it's racy and not really acceptable in it's
current form.  Search the lkml archives for details and the patch if you
are interested.

But that would require you to rebuild your kernel :)

And yes, we are working on adding this support for mainline, still
working on it...

thanks,

greg k-h
