Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUEHA3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUEHA3B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUEHA0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:26:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:28037 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263944AbUEHAZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:25:40 -0400
Date: Fri, 7 May 2004 14:49:03 -0700
From: Greg KH <greg@kroah.com>
To: Sourav Sen <souravs@india.hp.com>
Cc: Matt_Domsch@dell.com, matthew.e.tolentino@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.6 PATCH] Exposing EFI memory map
Message-ID: <20040507214903.GE13511@kroah.com>
References: <20040506164040.GA15371@kroah.com> <006901c43418$095436f0$39624c0f@india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006901c43418$095436f0$39624c0f@india.hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 03:15:30PM +0530, Sourav Sen wrote:
> Here we have "Array of values of same types". And it does not do much
> nifty formatting either. Is that not acceptable?

But they are not of the same time, as you admitted :)

Also, they could be bigger than a single page, right?  That is not
possible right now in sysfs.

> If that is not, how about the following.
> 
> 	1. Create a directory "memmap" under firmware/efi/
> 	2. Create files "map_start", "map_size" and "mapdesc_size" under
>          that exposing ia64_boot_param->efi_memmap,
> ia64_boot_param->efi_memmap_size
> 	   and ia64_boot_param->efi_memdesc_size respectively.
> 
> Userland can make meaning out of them by knowing the values and knowing
> about "efi_memory_desc_t" which is already there in
> /usr/include/asm/efi.h

I think you should address the other issues in this thread before
worrying about the sysfs interface (why have this at all, incorrect
data for hotplug mem, etc.)

> PS: BTW, Your slides on "Dealing with the Linux Kernel Community" at:
> http://www.kroah.com/linux/talks/cgl_talk_2002_10_16/mgp00001.html
> is kind of useful to me. This is my first time :-)

If only more people/companies would heed those rules...

thanks,

greg k-h
