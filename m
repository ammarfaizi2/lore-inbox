Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263573AbUECCxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUECCxu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUECCxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:53:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:61603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263573AbUECCxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:53:49 -0400
Date: Sun, 2 May 2004 19:51:49 -0700
From: Greg KH <greg@kroah.com>
To: Ian Stirling <linux-kernel@mauve.plus.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage unplanned unplugging. (2.6.5)
Message-ID: <20040503025149.GB21614@kroah.com>
References: <409573CC.1000700@mauve.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409573CC.1000700@mauve.plus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 11:18:52PM +0100, Ian Stirling wrote:
> What should happen when I unplug a USB-storage device with mounted 
> filesystems that are in use?

Not good things :)

But all should be well once you unmount those mounted filesystems.  Did
you try that?

> At the moment, it simply kills the USB port that it's on, it won't
> recognise anything plugged into it later.  Sort-of understandably, the
> scsi-module won't now unload, nor will the usb-storage or USB ones.

That's not good at all.  Can you try 2.6.6-rc3 and see if it does the
same thing?  If so, can you send us the kernel debug messages that
happen when you yank out the device, and then unmount the filesystems?

thanks,

greg k-h
