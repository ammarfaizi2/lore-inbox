Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262564AbTCMWA5>; Thu, 13 Mar 2003 17:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbTCMWA5>; Thu, 13 Mar 2003 17:00:57 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:1671 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262564AbTCMWAy>;
	Thu, 13 Mar 2003 17:00:54 -0500
Date: Thu, 13 Mar 2003 23:11:24 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VESA FBconsole driver?
Message-ID: <20030313221124.GA23719@vana.vc.cvut.cz>
References: <20030312110748.A9773@devserv.devel.redhat.com> <3E708815.23768.38089C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E708815.23768.38089C@localhost>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 01:31:01PM -0800, Kendall Bennett wrote:
> Kendall Bennett wrote:
> 
> > A long time ago I remember there was a guy working on a VESA
> > FBconsole driver for Linux. Then driver he was working on was
> > structured as a user land daemon that the kernel console driver
> > would call back into once the system was up, allowing the userland
> > VESA driver to use the vm86() service to change modes, program the
> > palette and other useful things that can't be done by the basic
> > driver that uses a mode set previously by LILO or GRUB. 
> 
> No-one has responded to this email, so either no-one remembers this is 
> people think someone else responded to my email ;-)
> 
> Does anyone remember this project. I checked the Linux kernel and it 
> presently does not seem to have any support for this. Can anyone point me 
> 
> at references that will help me figure out how the kernel can make 
> callbacks into a user land daemon?

It was some guy from Finland and I'm under impression that this project
is dead, because BIOSes were proven to be completely unstable in Linux 
environment. Try searching linux-fbdev-devel@lists.sourceforge.net 
archives, maybe you'll find something.
 
> > My second question is, is it possible to execute vm86() services
> > from *within* the kernel as opposed to from user land? I got the
> > impression at the time that the userland daemon was used because
> > vm86() could only be called from userland code and could not be
> > called from within the kernel to execute real mode VESA BIOS
> > services. Is that correct? If not, can vm86() services now be
> > called from other kernel modules inside the kernel? 
> 
> I checked into this some more and it is clear that vm86() is only useable 
> 
> from userland code on Linux. However recently the FreeBSD kernels were 
> modified to support vm86() from within the kernel, and in fact the latest 
> FreeBSD VESA console driver uses the vm86() services so that it can do 
> everything using the BIOS where necessary.

Maybe FreeBSD is too ia32 centric?
 
> Is there any reason why the vm86() services in the Linux kernel cannot be 
> used by other kernel code? Has anyone made an attempt to update the 
> vm86() services to support this? 

Why you need it? To run some parts of VGA BIOS? Why you cannot run them
from userspace task? I think that it is much easier, especially now when
initramfs is here.

On ia32 people get binary drivers from vendors, and on non-ia32 VGA BIOS
is unusable without ia32 emulator (and no, I do not see any difference between
using binary-only driver for Linux and using binary-only BIOS).
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

