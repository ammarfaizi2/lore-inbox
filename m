Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbTI1T2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTI1T2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:28:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20752 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262678AbTI1T2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:28:54 -0400
Date: Sun, 28 Sep 2003 20:28:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928202850.E1428@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>; from torvalds@osdl.org on Sun, Sep 28, 2003 at 10:37:36AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 10:37:36AM -0700, Linus Torvalds wrote:
> On Sun, 28 Sep 2003, Geert Uytterhoeven wrote:
> > On Sat, 27 Sep 2003, Linus Torvalds wrote:
> > > Bernardo Innocenti:
> > >   o GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h
> > 
> > This change breaks 2.95 for some source files, because <linux/init.h> doesn't
> > include <linux/compiler.h>. Do you want to have the missing include added to
> > <linux/init.h>, or to the individual source files that need it?
> 
> Interesting. I'm pretty sure I did a "make allyesconfig" just before the
> test6 release, so apparently x86 includes it indirectly through some path, 
> and so it only shows up on m68k and arm?
> 
> This, btw, is a pretty common thing. I wonder what we could do to make 
> sure that different architectures wouldn't have so different include file 
> structures. It's happened _way_ too often.
> 
> Any ideas?

The two files that it showed up in on ARM are fairly simple in nature and
don't include may headers.  Making the ARM include structure identical to
x86 wouldn't have removed the problem from ARM.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
