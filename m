Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTBGGC6>; Fri, 7 Feb 2003 01:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBGGC6>; Fri, 7 Feb 2003 01:02:58 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:62867 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267468AbTBGGC5>; Fri, 7 Feb 2003 01:02:57 -0500
Date: Fri, 7 Feb 2003 00:12:04 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: Greg KH <greg@kroah.com>, Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Restore module support.
In-Reply-To: <20030207001006.A19306@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0302070006110.31954-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Russell King wrote:

> On Thu, Feb 06, 2003 at 03:25:15PM -0800, Greg KH wrote:
> > Come on, what Rusty did was the "right thing to do" and has made life
> > easier for all of the arch maintainers (or so says the ones that I've
> > talked to)
> 
> And I'll promptly provide you with the other view.  I'm still trying to
> sort out the best thing to do for ARM.  We have the choice of:
> 
> 1. load modules in the vmalloc region and build two jump tables, one for
>    the init text and one for the core text.
> 
> 2. fix vmalloc and /proc/kcore to be able to cope with a separate module
>    region located below PAGE_OFFSET.  Currently, neither play well with
>    this option.

So you have the choice of either sticking to the solution which was 
previously used (only that it's now done in the kernel, not in modutils), 
or doing something new and more efficient.

Now, what's the reason you're not happy with that? You've got more
flexibility than before, and you can even switch between different ways
without having to teach an external package about it, so you avoid the
compatibility issues when kernel and modutils are not in sync.

--Kai


