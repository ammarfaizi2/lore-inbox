Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUJOSXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUJOSXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUJOSXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:23:32 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:40104 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268274AbUJOSVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:21:13 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 15 Oct 2004 11:20:58 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: KendallB@scitechsoft.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <416FB29A.11731.1C46848@localhost>
In-reply-to: <1097850784.9857.20.camel@localhost.localdomain>
References: <m3655cjc1r.fsf@averell.firstfloor.org>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Gwe, 2004-10-15 at 15:22, Andi Kleen wrote:
> > > There is exactly that in 2.6 - the hotplug interfaces allow the kernel
> > > to fire off userspace programs. Jon Smirl (who you should definitely
> > > talk to about this stuff) has been hammering out a design for moving
> > > almost all the mode switching into user space for kernel video.
> > 
> > The problem is that this would imply that the console would only
> > work after user space is running. Even with initrd that's quite late.
> 
> It doesn't imply this at all. You set an initial mode with the BIOS
> during boot up. When your initrd runs you gain the ability to flip mode
> and do cool stuff - arguably it doesn't even need to be in initrd.

That works great on x86, but this solution was developed for PowerPC and 
MIPS embedded systems development not x86 desktop systems. For those 
platforms you either need a boot loader that can bring up the system into 
graphics mode (possible with U-Boot) or to init the video right when the 
framebuffer console driver is brought up.

>From the sound of it that might be too early to spawn a user mode 
process?

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


