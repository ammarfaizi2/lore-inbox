Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUCJMjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUCJMig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:38:36 -0500
Received: from colin2.muc.de ([193.149.48.15]:50437 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262596AbUCJMgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:36:08 -0500
Date: 10 Mar 2004 13:36:05 +0100
Date: Wed, 10 Mar 2004 13:36:05 +0100
From: Andi Kleen <ak@muc.de>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andi Kleen <ak@muc.de>, Tom Rini <trini@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       george@mvista.com, pavel@ucw.cz
Subject: Re: kgdb for mainline kernel: core-lite [patch 1/3]
Message-ID: <20040310123605.GA62228@colin2.muc.de>
References: <1xpyM-2Op-21@gated-at.bofh.it> <1xuS8-83Q-11@gated-at.bofh.it> <m3hdwz9szt.fsf@averell.firstfloor.org> <200403091006.00822.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403091006.00822.amitkale@emsyssoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes. But as things stand, gdb 6.0 doesn't show stack traces correctly with esp 
> and eip got from switch_to and gas 2.14 can't handle i386 dwarf2 CFI. Do we 
> want to enforce getting a CVS version of gdb _and_ gas to build kgdb? 
> Certainly not.

binutils 2.15 should be released soon anyways AFAIK. And for x86-64 this all
works just fine (as demonstrated by Jim's/George's stub), so please get
rid of it at least for x86-64. I really don't want user_schedule there,
because it's completely unnecessary.

-Andi
