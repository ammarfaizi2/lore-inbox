Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbRBXJmW>; Sat, 24 Feb 2001 04:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbRBXJmC>; Sat, 24 Feb 2001 04:42:02 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:23047 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S129555AbRBXJlw>;
	Sat, 24 Feb 2001 04:41:52 -0500
Message-Id: <200102240941.CAA09708@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: Your message of Fri, 23 Feb 2001 09:48:04 PST.
In-Reply-To: <Pine.LNX.4.10.10102230938360.20762-100000@penguin.transmeta.com> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Sat, 24 Feb 2001 02:41:51 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Fri, 23 Feb 2001 09:48:04 PST, you write:
>The much more likely cause is the "magic registers" for the Texas
>Instruments PCI1225, namely
>
>		works		broken
>
>	81:	b0		90
>	a8:	11		10
>
>Although it worries me a bit that your second controller also seems to
>have differences in the BridgeCtl thing (16bInt).
>
>Can you try if a broken setup is fixed by doing a
>
>	setpci -s 00.04.0 81.b=b0
>	setpci -s 00.04.0 a8.b=11
>	setpci -s 00.04.1 81.b=b0
>	setpci -s 00.04.1 81.b=11

I ran setpci -s 00:04.0 81.b=b0, etc., but it didn't make any
difference.  Checking with lspci -vvxxx after running setpci it
appears that register 81 and a8 have stayed at 90 and 10 despite
setpci running without an error, using -G and -v setpci claims to be
running through /proc/bus/pci and adjusting the appropriate location.
Either I am making a fundamental error (yes, I am running it as root)
or the changes simply don't matter.

>Also, how much memory does this machine have? That "13ff0000" does worry
>me a bit..

The comptuer has 320MB.  At this point I am ready to conclude that the
computer is broken in some way, because nobody else with an Inspiron
5000e that I have heard from has anything like this problem.

I really appreciate the help everybody is providing with what is
really only an annoyance, and I wouldn't have even brought it to the
attention of linux-kernel, except that something that changed between
2.2.17 and 2.4.x has produced a regression in functionality.  If
anybody thinks it would be useful, I would be willing to do a binary
search between 2.2.17 and 2.4.2 to find out at which release things
stopped being setup correctly.

--
Jeff Lessem.
