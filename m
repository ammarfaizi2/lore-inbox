Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268054AbUIKAdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268054AbUIKAdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268055AbUIKAdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:33:42 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:11792 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268054AbUIKAdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:33:41 -0400
Date: Sat, 11 Sep 2004 02:33:38 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
In-Reply-To: <20040911001713.GA902@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58L.0409110220290.20057@blysk.ds.pg.gda.pl>
References: <20040902192820.GA6427@taniwha.stupidest.org>
 <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
 <20040910231052.GA3078@taniwha.stupidest.org> <Pine.LNX.4.58L.0409110156080.20057@blysk.ds.pg.gda.pl>
 <20040911001713.GA902@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Chris Wedgwood wrote:

> > These are just as harmless as single-bit RAM errors with ECC
> > working.
> 
> Hence KERN_DEBUG

 Both are serious hardware failures.  KERN_DEBUG is for stuff that's 
normally out of interest for most system operators.

> > For the former you only really want to rate-limit the report -- some
> > people apparently want or need to run broken hardware and they'd
> > probably appreciate limiting the output.
> 
> A little more than rate-limit as I mentioned.  I don't want the
> occasional surious APIC message waking up consoles that are asleep.
> This was the reason for the change.

 If that's the sole reason, then how about setting console_loglevel
appropriately for the systems you want the console to remain asleep?  
It's there exactly for a purpose like this.  You can eliminate other
messages you consider unimportant this way, too, without tweaking the log
level of all of them.

  Maciej
