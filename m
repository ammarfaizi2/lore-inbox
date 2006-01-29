Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWA2TAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWA2TAU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 14:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWA2TAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 14:00:20 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:11479
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751108AbWA2TAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 14:00:19 -0500
Date: Sun, 29 Jan 2006 11:00:29 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 kernel init oops
Message-ID: <20060129190029.GB7168@kroah.com>
References: <20060128171841.6f989958.rdunlap@xenotime.net> <20060128175511.35e39233.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128175511.35e39233.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 05:55:11PM -0800, Randy.Dunlap wrote:
> On Sat, 28 Jan 2006 17:18:41 -0800 Randy.Dunlap wrote:
> 
> > Hi,
> > 
> > I'm trying to boot 2.6.16-rc1 on a T42 Thinkpad notebook.
> > No serial port for serial console.  I don't think that networking
> > is alive yet (for network console ?).
> > 
> > Anyone recognize this?  got patch?
> > 
> > This is just typed in, so could contain a few errors.
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000001
> > printing eip:
> > 00000001
> > *pde = 00000000
> > Oops: 0000 [#1]
> > SMP DEBUG_PAGEALLOC
> > Modules linked in:
> > CPU:	0
> > EIP:	0060:[<00000001>]   Not tainted VLI
> > EFLAGS: 00010202   (2.6.16-rc1)
> > EIP is at 0x1
> > <skip reg. dump>
> > <skip stack dump>
> > Call trace:
> > 	show_stack_log_lvl+0xa5/0xad
> > 	show_registers+0xf9/0x162
> > 	die+0xfe/0x179
> > 	do_page_fault+0x399/0x4d8
> > 	error_code+0x4f/0x54
> > 	device_register+0x13/0x18
> > 	platform_bus_init+0xd/0x19
> > 	driver_init+0x1c/0x2d
> > 	do_basic_setup+0x12/0x1e
> > 	init+0x95/0x195
> > 	kernel_thread_helper+0x5/0xb
> > Code:  Bad EIP value.
> 
> Both 2.6.15 and 2.6.15.1 boot OK for me.
> .config for 2.6.16-rc1 is at
>   http://www.xenotime.net/linux/doc/config-2616rc1

If you disable CONFIG_PNP and CONFIG_ISAPNP options does that help?

thanks,

greg k-h
