Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUANRY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUANRY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:24:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:56781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262126AbUANRYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:24:24 -0500
Date: Wed, 14 Jan 2004 09:15:27 -0800
From: Greg KH <greg@kroah.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
Message-ID: <20040114171527.GB5472@kroah.com>
References: <20040113235213.GA7659@kroah.com> <4004D084.1050106@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4004D084.1050106@vgertech.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 05:15:48AM +0000, Nuno Silva wrote:
> I'm trying udev for the first time and I must say good work!

Thanks.

> A sugestion and a question:
> 
> - Make udev print a /etc/udev/udev.rules line every time a device is 
> found because default behaviour is too silent and "make DEBUG=true" is 
> too noisy. This would make adding our private/static entries easily.
> Something like:
> 
> udev[1234]: found device BUS="scsi", SYSFS_model="CD-Writer cd4f", 
> KERNEL="sr0", SYSFS_serial="AAAAAAAA"
> 
> This way one can easily make entries for a device with copy+paste, 
> remove a few parameters and adding a few *'s

Yeah, but what exactly would udev print out?  All of the sysfs files in
the device it found?  Would it print it out for every device that comes
through?  Or just for ones that no rule applied to?

> - I have a USB cd-writer and udev makes /udev/sr0 but it doesn't create 
> /udev/sg0. In the first run I had the hotplug packege from debian but I 
> just installed hotplug-2004_01_05 and it's the same, no sg0 is created.

There is currently no sg sysfs support that works properly with udev.
The scsi people know about this and are working on fixing it.

thanks,

greg k-h
