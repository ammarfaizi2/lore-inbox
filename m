Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbTAQQwG>; Fri, 17 Jan 2003 11:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTAQQwG>; Fri, 17 Jan 2003 11:52:06 -0500
Received: from [132.69.253.254] ([132.69.253.254]:41677 "HELO
	vipe.technion.ac.il") by vger.kernel.org with SMTP
	id <S267610AbTAQQwE>; Fri, 17 Jan 2003 11:52:04 -0500
Date: Fri, 17 Jan 2003 19:00:58 +0200 (IST)
From: Shlomi Fish <shlomif@vipe.technion.ac.il>
To: David Woodhouse <dwmw2@infradead.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16 
In-Reply-To: <25160.1042809144@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wow! My first patch suggestion! Thanks.

On Fri, 17 Jan 2003, David Woodhouse wrote:

>
> >   print MAKEFILE "CFLAGS = -I/usr/src/linux/include -O2 -Wall -DMODULE -D__KERNEL__ -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2\n\n";
>
> That's broken. you need to get the proper kernel CFLAGS, and you shouldn't
> assume there's anything useful in /usr/src/linux.
>

Ahah. What do you suggest me to do instead? The LKMB package needs to
compile on every system it was intended to. It's still a source package
that has to compile on any GNU system that has the Linux kernel headers.

> Use "/lib/modules/`uname -r`/build" as a default kernel directory, but
> allow it to be overridden somehow from the command line. Then do something
> like...
>
> 	make -C $(LINUXDIR) SUBDIRS=`pwd` modules
>
> ... to build your module. That way, all the kernel build stuff will be
> correct; it'll be just as if you were in a normal subdirectory of the
> kernel tree during a 'make modules' run.
>

Do you mean I'll need a live Linux kernel to build the kernel module
package?

I'm not a big kbuild expert and it show.

Regards,

	Shlomi Fish

> --
> dwmw2
>
>



----------------------------------------------------------------------
Shlomi Fish        shlomif@vipe.technion.ac.il
Home Page:         http://t2.technion.ac.il/~shlomif/

He who re-invents the wheel, understands much better how a wheel works.

