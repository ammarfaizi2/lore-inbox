Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267394AbSLEU64>; Thu, 5 Dec 2002 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbSLEU5x>; Thu, 5 Dec 2002 15:57:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6660 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267394AbSLEU46>;
	Thu, 5 Dec 2002 15:56:58 -0500
Date: Thu, 5 Dec 2002 11:58:17 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
Message-ID: <20021205105817.GC127@elf.ucw.cz>
References: <p73u1l7qbxs.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com> <asgsir$p18$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asgsir$p18$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The printk warnings should be easy to fix once everybody uses the same
> > types - I think we right now have workarounds exactly for 64-bit machines
> > where w check BITS_PER_LONG and use different formats for them (exactly
> > because they historically have _not_ had the same types as the 32-bit
> > machines).
> > 
> > However, if anybody on the list is hacking gcc, the best option really
> > would be to just allow better control over gcc printf formats. I have
> > wanted that in user space too at times. And it doesn't matter if it only
> > happens in new versions of gcc - we can disable the warning altogether for
> > old gcc's, as long as enough people have the new gcc to catch new
> > offenders..
> > 
> > (I'd _love_ to be able to add printk modifiers for other common types in
> > the kernel, like doing the NIPQUAD thing etc inside printk() instead of
> > having it pollute the callers. All of which has been avoided because of
> > the hardcoded gcc format warning..)
> > 
> 
> While we're talking about printk()... is there any reason *not* to
> rename it printf()?

I believe printf() is good idea. I put printk() into userland programs
too many times now, and used printf() too many times from kernel...

								Pavel 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
