Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUFZTPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUFZTPg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267207AbUFZTPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:15:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:28297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267194AbUFZTPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:15:20 -0400
Date: Sat, 26 Jun 2004 12:13:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <1088276531.1750.113.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0406261212190.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <1088268405.1942.25.camel@mulgrave> <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
 <1088270298.1942.40.camel@mulgrave> <Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
 <20040626182820.GA3723@ucw.cz>  <Pine.LNX.4.58.0406261140360.16079@ppc970.osdl.org>
 <1088276531.1750.113.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, James Bottomley wrote:
> 
> Our test bit implementation would then become:
> 
> static __inline__ int test_bit(int nr, const volatile void *address)
> {
> 	return __test_bit(nr, (const void *)address);
> }
> 
> That would keep our implementation happy.

You just _want_ to be screwed over whenever your gcc bugs are fixed, don't 
you?

Are you going to complain to the gcc people when they fix their bugs? Or 
are you going to spend months to debug problems that only happen for other 
people, because they happen to have fixed compilers?

There's a real reason why there is a "volatile" there on other 
architectures. 

		Linus
