Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbTCMXap>; Thu, 13 Mar 2003 18:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbTCMXap>; Thu, 13 Mar 2003 18:30:45 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:1424
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S262605AbTCMXah>; Thu, 13 Mar 2003 18:30:37 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2003 15:41:03 -0800
MIME-Version: 1.0
Subject: Re: VESA FBconsole driver?
CC: Petr Vandrovec <vandrove@vc.cvut.cz>
Message-ID: <3E70A68F.9422.AF1599@localhost>
In-reply-to: <20030313221124.GA23719@vana.vc.cvut.cz>
References: <3E708815.23768.38089C@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:

> It was some guy from Finland and I'm under impression that this
> project is dead, because BIOSes were proven to be completely
> unstable in Linux environment. 

We have been using the VESA BIOS successfully in user land under Linux 
for a long time now, and I would say that the BIOS'es are just as stable 
under Linux as under any other platform (you just need to know how to 
code around all the screwed up versions out there ;-).

> Try searching linux-fbdev-devel@lists.sourceforge.net archives,
> maybe you'll find something. 

Ok, I will look. I tried searching the kernel lists but did not get 
anywhere. Don't suppose you recall the name of this project?

> Maybe FreeBSD is too ia32 centric?

Perhaps, but vm86() but it's nature is ia32 specific anyway ;-)

> > Is there any reason why the vm86() services in the Linux kernel cannot be 
> > used by other kernel code? Has anyone made an attempt to update the 
> > vm86() services to support this? 
> 
> Why you need it? To run some parts of VGA BIOS? Why you cannot run
> them from userspace task? I think that it is much easier,
> especially now when initramfs is here. 

The reason why it would nice is so that the VESA FBconsole driver (and in 
fact all the FBconsole drivers that use the real mode BIOS to set an 
initial display mode) can restore that mode correctly when an application 
exists and restores the console. Right now it is up to the application 
program to restore the console, as the kernel has absolutely no way to do 
it. If that program has not way to restore it (old SVGALib code for 
instance) or the application crashes, you are stuck with a black screen 
if you are using a framebuffer console. If the kernel knew how to call 
the BIOS to restore the mode, this problem could be completely eliminated 
and services could be provided to properly restore the system state when 
console graphics programs crash (or the X server for that matter if it 
crashes and does not properly clean up).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

