Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVBHS7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVBHS7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVBHS7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:59:39 -0500
Received: from gprs215-10.eurotel.cz ([160.218.215.10]:54738 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261628AbVBHS5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:57:38 -0500
Date: Tue, 8 Feb 2005 18:43:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation
Message-ID: <20050208174318.GA1060@elf.ucw.cz>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org> <20050207114415.GA22948@elte.hu> <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > boots fine and shrinks the image size quite noticeably:
> > 
> >   [Nr] Name     Type        Addr     Off    Size
> >   [ 1] .text    PROGBITS    c0100000 001000 2771a9   [vmlinux-orig]
> >   [ 1] .text    PROGBITS    c0100000 001000 2742dd   [vmlinux-patched]
> > 
> > that's 11980 bytes off a 2585001 bytes .text, a 0.5% size reduction.
> > This patch we want ...
> 
> Goodie. Here's a slightly more recent version, where I cleaned up the
> assembly code (no need to save %ecx if we just update %ebx instead, which
> makes the code a bit more readable too - and doing it this way should
> hopefully make it easier for an out-of-order CPU to start the memops
> earlier too. Who knows..)
> 
> I'm not going to put this into 2.6.11, since I worry about compiler 
> interactions, but the more people who test it anyway, the better.

Put it in -mm tree :-)))
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
