Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966239AbWKTR1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966239AbWKTR1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 12:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966246AbWKTR1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 12:27:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:24268 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S966239AbWKTR1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 12:27:38 -0500
Date: Mon, 20 Nov 2006 09:27:33 -0800
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kobject_add failed with -EEXIST
Message-ID: <20061120172733.GA26713@suse.de>
References: <4561E290.7060100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561E290.7060100@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 06:14:56PM +0100, Jiri Slaby wrote:
> Hi!
> 
> Does anybody have some clue, what's wrong with the attached module?
> Kernel complains when the module is insmoded second time (DRIVER_DEBUG enabled):
> 
> 
> cls_init  				FIRST TIME
> device class 'cls_class': registering
> DEV: registering device: ID = 'cls_device'
> PM: Adding info for No Bus:cls_device
> DEV: Unregistering device. ID = 'cls_device'
> PM: Removing info for No Bus:cls_device
> device_create_release called for cls_device
> device class 'cls_class': unregistering
> class 'cls_class': release.
> class_create_release called for cls_class
> cls_exit

What does sysfs look like at this point in time?  Does
/sys/class/cls_class exist?

Also, which kernel version are you using here?

thanks,

greg k-h
