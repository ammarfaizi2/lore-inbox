Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVCRWAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVCRWAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCRWAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:00:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:25264 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261470AbVCRV71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 16:59:27 -0500
Date: Fri, 18 Mar 2005 13:43:36 -0800
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fix-u32-vs-pm_message_t-in-usb
Message-ID: <20050318214335.GA17813@kroah.com>
References: <20050310223353.47601d54.akpm@osdl.org> <20050311130831.GC1379@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311130831.GC1379@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 02:08:31PM +0100, Pavel Machek wrote:
> Hi!
> 
> > This patch has been spitting warnings:
> > 
> > drivers/usb/host/uhci-hcd.c:838: warning: initialization from incompatible pointer type
> > drivers/usb/host/ohci-pci.c:191: warning: initialization from incompatible pointer type
> > 
> > Because hc_driver.suspend() takes a u32 as its second arg.  Changing that
> > to pci_power_t causes build failures and including pci.h in usb.h seems
> > wrong.
> > 
> > Wanna fix it sometime?
> 
> Yep. Here it is.
> 
> This fixes remaining confusion. Part of my old patch was merged, I
> later decided passing pci_power_t down to drivers is bad idea; this
> passes them pm_message_t which contains more info (and actually works
> :-). Please apply,

Argh, this one is already partially in, and another one you just sent me
has half of it in the tree too...

Care to just rediff off of 2.6.12-rc1?  Then we can hopefully get these
changes in :)

thanks,

greg k-h
