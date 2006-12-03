Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936772AbWLCPWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936772AbWLCPWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936773AbWLCPWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:22:08 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:7321 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S936771AbWLCPWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:22:07 -0500
Date: Sun, 3 Dec 2006 16:21:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Pavel Machek <pavel@ucw.cz>, Al Viro <viro@ftp.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
In-Reply-To: <20061203112706.GA12722@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612031602570.1867@scrub.home>
References: <20061201172149.GC3078@ftp.linux.org.uk>
 <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk>
 <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk>
 <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk>
 <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz>
 <20061203112706.GA12722@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Dec 2006, Russell King wrote:

> I agree with Al, Matthew and Pavel.  The current timer stuff is a pita
> and needs fixing, and it seems Al has come up with a good way to do it
> without adding additional crap into every single user of timers.

What exactly is the pita here? Al only came up with some rather 
theoretical problems with no practical relevance.

> There *are* times when having the additional space for storing a pointer
> is cheaper (in terms of number of bytes) than code to calculate an offset,
> and those who have read the assembly code probably know this all too well.

In simple cases gcc can optimize this away, additionally it's offset by 
one less memory reference in the timer code, so the code executed per 
timer would be equal or often even less. Additionally less code is needed 
to initialize the timer.

> Al - I look forward to your changes.

I don't. The current API is maybe not perfect, but changing the API for no 
practical benefit would be an even bigger pita. I'd rather keep it as is.

bye, Roman
