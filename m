Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282860AbRLGQOq>; Fri, 7 Dec 2001 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282873AbRLGQOg>; Fri, 7 Dec 2001 11:14:36 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:32651 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282872AbRLGQOa>; Fri, 7 Dec 2001 11:14:30 -0500
Date: Fri, 7 Dec 2001 09:14:26 -0700
Message-Id: <200112071614.fB7GEQ514356@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
In-Reply-To: <p73r8q86lpn.fsf@amdsim2.suse.de.suse.lists.linux.kernel>
	<Pine.LNX.4.33.0112070710120.747-100000@mikeg.weiden.de.suse.lists.linux.kernel>
	<9upmqm$7p4$1@penguin.transmeta.com.suse.lists.linux.kernel>
	<p73n10v6spi.fsf@amdsim2.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> torvalds@transmeta.com (Linus Torvalds) writes:
> > 
> > "putc()" is a standard function.  If it sucks, let's get it fixed.  And
> > instead of changing bonnie, how about pinging the _real_ people who
> > write sucky code?
> 
> It is easy to fix. Just do #define putc putc_unlocked
> There is just a slight problem: it'll fail if your application is threaded
> and wants to use the same FILE from multiple threads.
> 
> It is a common problem on all OS that eventually got threadsafe stdio. 
> I bet putc sucks on Solaris too.

This kind of thing should be covered by _REENTRANT. If you don't
compile with _REENTRANT (the default), then putc() should be the
unlocked version.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
