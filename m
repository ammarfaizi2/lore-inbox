Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287231AbSAGV4m>; Mon, 7 Jan 2002 16:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287205AbSAGV4c>; Mon, 7 Jan 2002 16:56:32 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:14531 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S287215AbSAGV4P>; Mon, 7 Jan 2002 16:56:15 -0500
Date: Mon, 7 Jan 2002 16:56:15 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems? 
In-Reply-To: <Pine.LNX.4.10.10201031901320.31717-100000@xarch.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.33.0201071633460.20179-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Alex wrote:
[snippage]
> This stupid Win2k or even *brrr* XP ^H^H^H detects all the hardware
> fine when installing. Even ISA. So should Linux.

It does it  v e r y  s l o w l y  however.  I've been following this
thread primarily to see why it isn't faster.  They seem to still use the
old "throw all drivers at the box and see which ones stick" approach for
everything, when one ought to at least be able to ask decent buses what's
there and skip 70% of the stuff not needed in milliseconds.  But non-PNP
ISA gear is of course going to need the old probing or manual
configuration.

Apparently the BIOS can't be relied on to figure things out properly in
quite a number of cases.  Is it, in fact, ridiculous to think of just
asking the bridge chip "do you see anything" (in cases where there *is* a
bridge chip)?  IOW how hard is it to just talk to the decent portion of
the hardware and get useful answers?

The most interesting question (for IBM-PC type boxes) is "is there any
non-PNP ISA gear other than the standard serial, parallel, keyboard,
mouse, etc. ports?"  A reliable answer to that question eliminates
probing in the "no" case:  you can just ask the hardware what it is.
These constraints bound a large and growing portion of the set of machines
to be configured, and it might be useful to optimize for them if it isn't
too costly.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Our lives are forever changed.  But *that* is exactly as it always was.

