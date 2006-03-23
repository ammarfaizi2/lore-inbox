Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWCWQvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWCWQvZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWCWQvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:51:25 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7123 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751132AbWCWQvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:51:24 -0500
Date: Thu, 23 Mar 2006 08:51:08 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-git6: build failure: ksysfs.c (h7201_defconfig)
Message-ID: <20060323165108.GA16474@kroah.com>
References: <20060323163852.GC25849@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323163852.GC25849@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 04:38:52PM +0000, Russell King wrote:
> Building h7201_defconfig on ARM provokes these build errors:
> 
>   LD      .tmp_vmlinux1
> kernel/built-in.o: In function `uevent_seqnum_show':
> ksysfs.c:(.text+0x1f258): undefined reference to `uevent_seqnum'
> kernel/built-in.o: In function `uevent_helper_show':
> ksysfs.c:(.text+0x1f280): undefined reference to `uevent_helper'
> kernel/built-in.o: In function `uevent_helper_store':
> ksysfs.c:(.text+0x1f2e0): undefined reference to `uevent_helper'
> kernel/built-in.o:(.data+0xd1c): undefined reference to `uevent_helper'
> make: *** [.tmp_vmlinux1] Error 1
> make: Leaving directory `/var/tmp/kernel-orig'

Ugh, CONFIG_NET is not set, yet CONFIG_HOTPLUG is.  I was wrong with my
assumption that no one would ever need that :)

I have a patch in my queue from Andrew that fixes it up, I'll send it on
to Linus later today to fix this.  Thanks for letting me know.

greg k-h
