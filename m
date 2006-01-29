Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWA2VH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWA2VH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWA2VH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:07:56 -0500
Received: from xenotime.net ([66.160.160.81]:12735 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751083AbWA2VHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:07:55 -0500
Date: Sun, 29 Jan 2006 13:08:12 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1 kernel init oops
Message-Id: <20060129130812.011d8bf3.rdunlap@xenotime.net>
In-Reply-To: <20060129201923.GB6972@kroah.com>
References: <20060128171841.6f989958.rdunlap@xenotime.net>
	<20060128175511.35e39233.rdunlap@xenotime.net>
	<20060129190029.GB7168@kroah.com>
	<20060129111934.53710b03.rdunlap@xenotime.net>
	<20060129201923.GB6972@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2006 12:19:23 -0800 Greg KH wrote:

> On Sun, Jan 29, 2006 at 11:19:34AM -0800, Randy.Dunlap wrote:
> > On Sun, 29 Jan 2006 11:00:29 -0800 Greg KH wrote:
> > 
> > > On Sat, Jan 28, 2006 at 05:55:11PM -0800, Randy.Dunlap wrote:
> > > > On Sat, 28 Jan 2006 17:18:41 -0800 Randy.Dunlap wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > I'm trying to boot 2.6.16-rc1 on a T42 Thinkpad notebook.
> > > > > No serial port for serial console.  I don't think that networking
> > > > > is alive yet (for network console ?).
> > > > > 
> > > > > Anyone recognize this?  got patch?
> > > > > 
> > > > > This is just typed in, so could contain a few errors.
> > > > > 
> > > > > Unable to handle kernel NULL pointer dereference at virtual address 00000001
> > > > > printing eip:
> > > > > 00000001
> > > > > *pde = 00000000
> > > > > Oops: 0000 [#1]
> > > > > SMP DEBUG_PAGEALLOC
> > > > > Modules linked in:
> > > > > CPU:	0
> > > > > EIP:	0060:[<00000001>]   Not tainted VLI
> > > > > EFLAGS: 00010202   (2.6.16-rc1)
> > > > > EIP is at 0x1
> > > > > <skip reg. dump>
> > > > > <skip stack dump>
> > > > > Call trace:
> > > > > 	show_stack_log_lvl+0xa5/0xad
> > > > > 	show_registers+0xf9/0x162
> > > > > 	die+0xfe/0x179
> > > > > 	do_page_fault+0x399/0x4d8
> > > > > 	error_code+0x4f/0x54
> > > > > 	device_register+0x13/0x18
> > > > > 	platform_bus_init+0xd/0x19
> > > > > 	driver_init+0x1c/0x2d
> > > > > 	do_basic_setup+0x12/0x1e
> > > > > 	init+0x95/0x195
> > > > > 	kernel_thread_helper+0x5/0xb
> > > > > Code:  Bad EIP value.
> > > > 
> > > > Both 2.6.15 and 2.6.15.1 boot OK for me.
> > > > .config for 2.6.16-rc1 is at
> > > >   http://www.xenotime.net/linux/doc/config-2616rc1
> > > 
> > > If you disable CONFIG_PNP and CONFIG_ISAPNP options does that help?
> > 
> > Nope, no change.  Any other suggestions?
> > 
> > I just booted with a KOBJECT_DEBUG
> > built kernel and it's failing after:
> > 
> > kobject platform: registering, parent: <NULL>, set: devices
> 
> Can you enable CONFIG_DEBUG_DRIVER and see if that helps?

Yes.  Transcribing that:

kobject platform: registering, parent: <NULL>, set: devices
DEV: registering device: ID = 'platform'
kobject_uevent
PM: Adding info for No Bus:platform
<Oops happens>


---
~Randy
