Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWHHGEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWHHGEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWHHGEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:04:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:4995 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750906AbWHHGEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:04:14 -0400
Date: Mon, 7 Aug 2006 23:02:11 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Clayton <andrew@digital-domain.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc strange hotplug/udev/uevent problem
Message-ID: <20060808060211.GA3206@kroah.com>
References: <44D79574.8080703@digital-domain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D79574.8080703@digital-domain.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 08:33:08PM +0100, Andrew Clayton wrote:
> Hi,
> 
> Got a weird problem here.
> 
> On x86 Fedora Core 5 with 2.6.17 with GNOME, plugging in a usb stick 
> would result in it being mounted. With 2.6.18-rc this no longer occurs. 
> FC5 got an update to hal to work with 2.6.18 kernels, but it don't work 
> for me. I'm having the same problem on 3 x86 FC5 machines.
> 
> The weird thing is, this all works on my x86-64 FC5 workstation with 
> 2.6.18-rc both before and after the hal update.
> 
> Anyway I submitted a bug report against HAL suspecting it broken
> 
> https://bugs.freedesktop.org/show_bug.cgi?id=7756
> 
> Perhaps not. So I turn my attention more to the kernel.
> 
> 
> 2.6.17 was working fine. You could plug/unplug/plug a USB memory stick 
> and it would get mounted each time.
> 
> 2.6.18-rc[23] works the same as above on my x86-64 FC5 box.
> 
> 2.6.18-rc[23] and 2.6.18-rc3-git7 on x86 built with 
> usb/scsi/sd/vfat/nls_* built as modules will mount on the first plug but 
> not subsequent plugs.
> 
> If you rmmod the sd_mod module and plug in, then it will get mounted.

That's just wierd.  I can't think of anything that has changed recently
to cause this.

Can you use 'git bisect' to try to narrow it down which change caused
the problem?

thansk,

greg k-h
