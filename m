Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbUCCKxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 05:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUCCKxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 05:53:40 -0500
Received: from gprs40-155.eurotel.cz ([160.218.40.155]:1750 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262432AbUCCKxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 05:53:39 -0500
Date: Wed, 3 Mar 2004 11:52:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net, amit@av.mvista.com
Subject: Re: [Kgdb-bugreport] [KGDB][RFC] Send a fuller T packet
Message-ID: <20040303105246.GA342@elf.ucw.cz>
References: <20040302220233.GG20227@smtp.west.cox.net> <404518AD.40606@mvista.com> <20040302233635.GM20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302233635.GM20227@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > I would really like to keep this stuff out of kgdb.h since it may be 
> > included by the user to pick up the BREAKPOINT() (which, by the way we 
> > should standardize as I note that here it has () while not on the current 
> > x86).
> 
> It's BREAKPOINT() everywhere:
> $ grep BREAKPOINT include/asm-*/kgdb.h
> include/asm-i386/kgdb.h:#define BREAKPOINT() asm("   int $3");
> include/asm-ppc/kgdb.h:#define BREAKPOINT()             asm(".long 0x7d821008") /* twge r2, r2 */
> include/asm-x86_64/kgdb.h:#define BREAKPOINT() asm("   int $3");

Notice how it ends with ';' on everything but ppc. Perhaps it needs do
{ } while (0) wrapping?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
