Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUJOSUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUJOSUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUJOSUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:20:55 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:36520 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S268268AbUJOSUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:20:44 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 15 Oct 2004 11:20:21 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <416FB275.6425.1C3D985@localhost>
In-reply-to: <1097843969.9863.8.camel@localhost.localdomain>
References: <416E8322.25700.29ACC2F1@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Iau, 2004-10-14 at 21:46, Kendall Bennett wrote:
> > a way to spawn a user mode process that early in the boot sequence (it 
> > would have to come from the initrd image I expect) then the only option 
> > is to compile it into the kernel.
> 
> There is exactly that in 2.6 - the hotplug interfaces allow the
> kernel to fire off userspace programs. Jon Smirl (who you should
> definitely talk to about this stuff) has been hammering out a
> design for moving almost all the mode switching into user space for
> kernel video. 

That is awesome! I am all for moving this outside of the kernel, as it 
would allow the use of ream vm86() services for VGA/VESA BIOS access on 
x86 and the user of the emulator for non-x86 platforms. 

The only catch would be making sure this stuff is available really early 
in the boot sequence. As it stands right now the solution we have brings 
up the video almost imediately after you see the 'uncompressing kernel 
image' message on the serial port. The other solution of course is to get 
this into the boot loader which is what the AmigaOne folks did for their 
machines (U-Boot brings up the video). We are working with those guys to 
update their BIOS emulator to the latest version as the one they have 
doesn't work that reliably.

Anyway how do I find out more about this in 2.6?

Also I assume the code would need to end up in the initrg image, correct? 
Can you point me at some resources to learn more about how to get custom 
code into the initrd image?

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


