Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUJOXvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUJOXvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUJOXvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:51:33 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:26549 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267375AbUJOXva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:51:30 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Jon Smirl <jonsmirl@gmail.com>
Date: Fri, 15 Oct 2004 16:51:09 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <416FFFFD.28877.2F2B6C9@localhost>
In-reply-to: <9e47339104101516206c8597d3@mail.gmail.com>
References: <200410160551.40635.adaplas@hotpop.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:

> On Sat, 16 Oct 2004 05:51:38 +0800, Antonino A. Daplas
> <adaplas@hotpop.com> wrote:
> > Yes, that is the downside to a userspace solution. How bad will that be?
> > Note that Jon Smirl is proposing a temporary console driver for early
> > boot messages until the primary console driver activates.
> 
> Does anyone know exactly how big the window is from when a
> compiled in console activates until one that relies on initramfs
> loads? I don't think it is very big given that a lot of the early
> printk's are queued before they are displayed. 

I have not used initramfs at all (I am not sure I know what it is 
actually) so I don't know. I know there is quite a long period of time on 
most machines from when the kernel starts booting and when the real file 
system based init process takes over.

> Other than embedded systems, are there machines that have no
> BIOS/PROM display at all and rely entirely on a bootable kernel
> for display? If so, how do machines like this put up a message that
> they can't find the kernel? How do you get hardware diagnostic
> messages from them? 

I am pretty sure most embedded systems use some kind of boot firmware to 
bring up the box. Something like Open BIOS from IBM or U-Boot. U-Boot can 
be set up to POST the card using the BIOS emulator but Open BIOS cannot. 
If you don't POST the card in the boot loader, usually they display 
diagnostics on the serial port until the console comes up (ie: I see the 
'uncompress linux...' message on the serial port and then the framebuffer 
console comes up and the messages switch over to it.

> In the case of something like a Mac you would want to keep the
> display blank until the early user space code initializes the
> display in graphics mode. Only if you get a fatal error before this
> would you dump the info using the Open Firmware display. Same
> strategy would apply to x86. 

True. On the Mac they use the speakers so the user knows that the machine 
is booting. Almost immediately after hitting the power you will hear a 
calming sound coming from the speaker, and it might be another 5 seconds 
or so before the actual video comes up. 

If they didn't do that they would no doubt have lots of users turning the 
machine off again before it had a chance to bring up the video!

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


