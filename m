Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSLPLKK>; Mon, 16 Dec 2002 06:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSLPLKJ>; Mon, 16 Dec 2002 06:10:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48904 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261544AbSLPLKE>; Mon, 16 Dec 2002 06:10:04 -0500
Date: Mon, 16 Dec 2002 12:17:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, terje.eggestad@scali.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021216111759.GA24196@atrey.karlin.mff.cuni.cz>
References: <20021215220132.GB6347@elf.ucw.cz> <200212160733.gBG7XhD67922@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212160733.gBG7XhD67922@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Have apps enter kernel mode via Intel's purposely undefined
> >> instruction, plus a few bytes of padding and identification.
> >> Require that this not cross a page boundry. When it faults,
> >> write the SYSENTER, INT 0x80, or SYSCALL as needed. Leave
> >> the page marked clean so it doesn't need to hit swap; if it
> >> gets paged in again it gets patched again.
> >
> > Thats *very* dirty hack. vsyscalls seem cleaner than that.
> 
> Sure it's dirty. It's also fast, with the only overhead being
> a few NOPs that could get skipped on syscall return anyway.
> Patching overhead is negligible, since it only happens when a
> page is brought in fresh from the disk.

Yes but "read only" code changing under you... Should better be
avoided.

> The vsyscall stuff costs you on every syscall. It's nice for

Well, the cost is basically one call. That's not *that* big cost.

							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
