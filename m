Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUJOSjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUJOSjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUJOShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:37:34 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:6313 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268298AbUJOSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:36:56 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Gerd Knorr <kraxel@bytesex.org>, linux-fbdev-devel@lists.sourceforge.net
Date: Fri, 15 Oct 2004 11:36:04 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, penguinppc-team@lists.penguinppc.org
Message-ID: <416FB624.27698.1D23BA6@localhost>
In-reply-to: <87d5zkqj8h.fsf@bytesex.org>
References: <416E6ADC.3007.294DF20D@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@bytesex.org> wrote:

> "Kendall Bennett" <KendallB@scitechsoft.com> writes:
> 
> > Note that the SNAPBoot code uses the x86emu BIOS emulator project as the 
> > core CPU emulation technology, and project we have been actively involved 
> > with for many years since the licensing on the project was changed to 
> > MIT/BSD style licensing and incorporated into the XFree86 project.
> 
> > So what we would like to find out is how much interest there might be in 
> > both an updated VESA framebuffer console driver as well as the code for 
> > the Video card BOOT process being contributed to the maintstream kernel. 
> 
> It certainly would be nice to have that.  Not nessesarely in the
> kernel through, people tend not to like such complex stuff like
> cpu emulation in the kernel for good reasons.  

Well think about it as an x86 p-code interpreter then ;-) Kind of like a 
forth interpreter for Open Firmware but we use an x86 image instead.

> The kernel can run userspace apps (modprobe, hotplug), that
> mechanism could be used to invoke a userspace tool which does the
> boot / mode switching. Having it in userspace likely also makes it
> easier to share code with X11. 

I agree entirely, provided we can find a way to get this to run really 
early in the boot sequence. We need this for non-x86 embedded machines 
such as PowerPC and MIPS, not for x86 platforms where the BIOS can be 
called from the boot loader easily.

> Have you talked to the powermanagement guys btw.?  One of the
> major issues with suspend-to-ram is to get the graphics card back
> online, and SNAPBoot might help to fix this too.  I'm not sure a
> userspace solution would work for *that* through. 

That is a good point. Another good reason to have the code in there ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


