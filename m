Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbSLSWUX>; Thu, 19 Dec 2002 17:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbSLSWTb>; Thu, 19 Dec 2002 17:19:31 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28683 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267694AbSLSWSN>; Thu, 19 Dec 2002 17:18:13 -0500
Date: Thu, 19 Dec 2002 23:26:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021219222614.GE17941@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org> <20021218235327.GC705@elf.ucw.cz> <3E0245C1.5060902@transmeta.com> <20021219222136.GC17941@atrey.karlin.mff.cuni.cz> <3E0246DE.2010608@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E0246DE.2010608@transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>>don't many of the multi-CPU problems with tsc go away because you've got a
> >>>>per-cpu physical page for the vsyscall?
> >>>>
> >>>>i.e. per-cpu tsc epoch and scaling can be set on that page.
> >>>
> >>>Problem is that cpu's can randomly drift +/- 100 clocks or so... Not
> >>>nice at all.
> >>>
> >>
> >>нн?100 clocks is what... ?50 ns these days?  You can't get that kind of
> >>accuracy for anything outside the CPU core anyway...
> > 
> > 50ns is bad enough when it makes your time go backwards.
> > 
> 
> Backwards??  Clock spreading should make the rate change, but it should
> never decrement.

User on cpu1 reads time, communicates it to cpu2, but cpu2 is drifted
-50ns, so it reads time "before" time reported cpu1. And gets confused.

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
