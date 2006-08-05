Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWHEOsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWHEOsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 10:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHEOsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 10:48:36 -0400
Received: from mx2.rowland.org ([192.131.102.7]:22286 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1751094AbWHEOsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 10:48:36 -0400
Date: Sat, 5 Aug 2006 10:48:33 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: Problem: irq 217: nobody cared + backtrace
In-Reply-To: <9a8748490608041540lba0d85x8832334d50b30f49@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.0608051042090.25249-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006, Jesper Juhl wrote:

> > Just as before.
> >
> > I can't tell you what's causing this to happen, except that it appears to
> > be some sort of hardware problem.
> 
> Hmm, the odd thing is that there are no USB devices connected at all.

My guess is that this has nothing to do with the USB controller, other 
than the fact that IRQ 217 is enabled because the controller uses it.  
Probably the real problem, the unhandled interrupt requests, comes from 
some other device entirely.

> >  Since it doesn't seem to cause any harm
> > you could just live with it.
> >
> > Or, if you're not using any full-speed or low-speed USB devices, you could
> > simply prevent uhci-hcd from loading at all.  Then IRQ 217 wouldn't get
> > enabled in the first place.
> >
> True, that just seems like a hack...

It is.  Without knowing the underlying cause of the problem, it's the best 
I can suggest.

If you compare /proc/interrupts with earlier versions of the kernel (where 
the problem doesn't occur), does it look the same?

Alan Stern

