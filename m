Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVHLRue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVHLRue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVHLRue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:50:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23783 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750761AbVHLRue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:50:34 -0400
Date: Fri, 12 Aug 2005 18:50:30 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
cc: Jim Ramsay <jim.ramsay@gmail.com>, alex.kern@gmx.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
Message-ID: <Pine.LNX.4.56.0508121848040.30829@pentafluge.infradead.org>
References: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have the following issue.  I am trying to get an ATI Rage XL chip
> > working on a MIPS-based processor, with a 2.6.11-based kernel from
> > linux-mips.org.  Now, I know that this was working with a 2.4.25-based
> > kernel previously.
> 
> Okay, the 2.4 driver is more intrusive, it programs the chip from start as
> much as possible, while the 2.6 driver tries to depend on Bios settings. I
> haven't checked out the 2.6 driver enough to see if it is still possible
> to program from scratch.

The code is there to program the chip from scratch. Just select 

"Rage XL No-BIOS Init support"

The last time I tried it it didn't work. If we could get it working that 
would be great.
 
> Yes, according to my register data sheet a 7 means the memory clock
> frequency is derived from DLLCLK. Unfortunately I don't know what this
> DLLCLK is. I think it means the chip isn't properly initialized yet and it
> clocks the memory from a safe clock source to allow the computer to start.
> 
> However, we most likely have no way to find out the speed of this DLLCLK.
> 
> The memory clock frequency is important for the driver to be able to set a
> display mode; it needs to program a memory reload frequency into the chip
> which depends on the memory frequency.

Their is code in xlint.c that should properly set this. Have to debug that 
code.

