Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbUCJP1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCJP1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:27:52 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:43975 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262259AbUCJP1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:27:51 -0500
Date: Wed, 10 Mar 2004 08:27:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040310152750.GE5169@smtp.west.cox.net>
References: <1xpyM-2Op-21@gated-at.bofh.it> <1xuS8-83Q-11@gated-at.bofh.it> <m3hdwz9szt.fsf@averell.firstfloor.org> <200403091006.00822.amitkale@emsyssoft.com> <20040310123605.GA62228@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310123605.GA62228@colin2.muc.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 01:36:05PM +0100, Andi Kleen wrote:
> > Yes. But as things stand, gdb 6.0 doesn't show stack traces correctly with esp 
> > and eip got from switch_to and gas 2.14 can't handle i386 dwarf2 CFI. Do we 
> > want to enforce getting a CVS version of gdb _and_ gas to build kgdb? 
> > Certainly not.
> 
> binutils 2.15 should be released soon anyways AFAIK. And for x86-64 this all
> works just fine (as demonstrated by Jim's/George's stub), so please get
> rid of it at least for x86-64. I really don't want user_schedule there,
> because it's completely unnecessary.

I think more importantly, it's probably going to be one of those ugly
things that will make it so much harder to get it into Linus' tree.  So
lets just say it'll require gdb 6.1 / binutils 2.15 for KGDB to work
best.

-- 
Tom Rini
http://gate.crashing.org/~trini/
