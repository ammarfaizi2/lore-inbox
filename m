Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUCCPIG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbUCCPIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:08:05 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:52101 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262470AbUCCPID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:08:03 -0500
Date: Wed, 3 Mar 2004 08:08:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, amit@av.mvista.com
Subject: Re: [Kgdb-bugreport] [KGDB][RFC] Send a fuller T packet
Message-ID: <20040303150802.GP20227@smtp.west.cox.net>
References: <20040302220233.GG20227@smtp.west.cox.net> <404518AD.40606@mvista.com> <20040302233635.GM20227@smtp.west.cox.net> <20040303105246.GA342@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303105246.GA342@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 11:52:47AM +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > > I would really like to keep this stuff out of kgdb.h since it may be 
> > > included by the user to pick up the BREAKPOINT() (which, by the way we 
> > > should standardize as I note that here it has () while not on the current 
> > > x86).
> > 
> > It's BREAKPOINT() everywhere:
> > $ grep BREAKPOINT include/asm-*/kgdb.h
> > include/asm-i386/kgdb.h:#define BREAKPOINT() asm("   int $3");
> > include/asm-ppc/kgdb.h:#define BREAKPOINT()             asm(".long 0x7d821008") /* twge r2, r2 */
> > include/asm-x86_64/kgdb.h:#define BREAKPOINT() asm("   int $3");
> 
> Notice how it ends with ';' on everything but ppc. Perhaps it needs do
> { } while (0) wrapping?

... not that PPC works right now :)  But yes, you're right.

-- 
Tom Rini
http://gate.crashing.org/~trini/
