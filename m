Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbTCMVUe>; Thu, 13 Mar 2003 16:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262549AbTCMVUe>; Thu, 13 Mar 2003 16:20:34 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:58510
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S262547AbTCMVUd>; Thu, 13 Mar 2003 16:20:33 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2003 13:31:01 -0800
MIME-Version: 1.0
Subject: Re: VESA FBconsole driver?
Message-ID: <3E708815.23768.38089C@localhost>
In-reply-to: <3E6F14F6.7063.2D30924F@localhost>
References: <20030312110748.A9773@devserv.devel.redhat.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> A long time ago I remember there was a guy working on a VESA
> FBconsole driver for Linux. Then driver he was working on was
> structured as a user land daemon that the kernel console driver
> would call back into once the system was up, allowing the userland
> VESA driver to use the vm86() service to change modes, program the
> palette and other useful things that can't be done by the basic
> driver that uses a mode set previously by LILO or GRUB. 

No-one has responded to this email, so either no-one remembers this is 
people think someone else responded to my email ;-)

Does anyone remember this project. I checked the Linux kernel and it 
presently does not seem to have any support for this. Can anyone point me 

at references that will help me figure out how the kernel can make 
callbacks into a user land daemon?

> My second question is, is it possible to execute vm86() services
> from *within* the kernel as opposed to from user land? I got the
> impression at the time that the userland daemon was used because
> vm86() could only be called from userland code and could not be
> called from within the kernel to execute real mode VESA BIOS
> services. Is that correct? If not, can vm86() services now be
> called from other kernel modules inside the kernel? 

I checked into this some more and it is clear that vm86() is only useable 

from userland code on Linux. However recently the FreeBSD kernels were 
modified to support vm86() from within the kernel, and in fact the latest 

FreeBSD VESA console driver uses the vm86() services so that it can do 
everything using the BIOS where necessary.

Is there any reason why the vm86() services in the Linux kernel cannot be 

used by other kernel code? Has anyone made an attempt to update the 
vm86() services to support this? 

Thanks!

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

