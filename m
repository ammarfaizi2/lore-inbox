Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUJOShL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUJOShL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUJOShL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:37:11 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:5801 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268295AbUJOSgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:36:50 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: "Antonino A. Daplas" <adaplas@hotpop.com>, linux-kernel@vger.kernel.org
Date: Fri, 15 Oct 2004 11:36:04 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-fbdev-devel@lists.sourceforge.net,
       penguinppc-team@lists.penguinppc.org
Message-ID: <416FB624.17156.1D23C23@localhost>
In-reply-to: <200410150827.38943.adaplas@hotpop.com>
References: <416E6ADC.3007.294DF20D@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@hotpop.com> wrote:

> On Friday 15 October 2004 03:02, Kendall Bennett wrote:
> > So what we would like to find out is how much interest there might be in
> > both an updated VESA framebuffer console driver as well as the code for
> > the Video card BOOT process being contributed to the maintstream kernel.
> > If there is interest, we would start out by first contributing the core
> > emulator and Video BOOT code, and then work on building a better VESA
> > framebuffer console driver.
> >
> > So what do you guys think?
> 
> I'm for it, if you can get the code in the kernel.  If not, what
> are the arguments against doing this in userspace? 

At least for the 2.4 kernels it is not possible to run code from user 
space early enough in the boot sequence to bring up the video card when 
the framebuffer console driver starts. Alan Cox said there is work under 
way for 2.6 that might allow this, but it would have to be done very 
early in the boot sequence.

Remember this project is for non-x86 platforms such as PowerPC and MIPS 
embedded machines where there is no way to set a graphics mode using the 
BIOS before the kernel starts loading (well, you can do something using U-
Boot but a lot of projects don't always use U-Boot).

> If you remember about 2 years ago, there was a thread which you
> started about vesafbd.  From that, I've worked on vm86d which is a
> generic approach to running BIOS code in user space. I stopped
> development on this though, but it should be easy to revive. 

Yes, I am aware of this project. It is a great project for x86 platforms, 
but falls short for non-x86 due to the inability to set a basic display 
mode prior to user space access becoming available.

> There is also vesafb-tng. I think it runs BIOS code in kernel
> space. 

I am not familiar with that. Can you point me to a URL?

> The video BOOT code is also nice, especially for non-primary
> graphics cards. 

Yep.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


