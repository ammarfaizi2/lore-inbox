Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262603AbTCMXak>; Thu, 13 Mar 2003 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTCMXaj>; Thu, 13 Mar 2003 18:30:39 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:912
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S262603AbTCMXaf>; Thu, 13 Mar 2003 18:30:35 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2003 15:41:03 -0800
MIME-Version: 1.0
Subject: Re: VESA FBconsole driver?
Message-ID: <3E70A68F.1935.AF1549@localhost>
In-reply-to: <87adfy7vmk.fsf@bytesex.org>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Gerd Knorr <kraxel@bytesex.org> wrote:

> > at references that will help me figure out how the kernel can make 
> > callbacks into a user land daemon?
> 
> Look how /sbin/{hotplug|modprobe} is called if needed.

Ok thanks.

> > Is there any reason why the vm86() services in the Linux kernel
> > cannot be used by other kernel code?
> 
> Unlikely.  To ugly to live with (says Linus, and lot of people
> agree), and not really needed.  

Why is it ugly? IMHO it is very much needed, as it would provide a 
mechanism for the kernel to be able to properly restore the screen if a 
user land program goes astray.

> Doing it in userspace also has the advantage that you can play alot
> more tricks.  

More tricks like what? All we need is the ability to call the BIOS and 
have it execute the necessary real mode code, just like we do on ia32 
machines in user land.

> XFree86 for example has a x86 emulator to execute vga bios code on
> !x86 platforms. _That_ you really don't want to do in kernel mode
> ... 

Yes, I am aware of the x86 emulator - I revived the project a few years 
back and Egbert Eich integrated it into XFree86 ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

