Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVG1RVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVG1RVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVG1RTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:19:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261756AbVG1RSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:18:15 -0400
Date: Thu, 28 Jul 2005 10:17:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0507281017130.3227@g5.osdl.org>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org> <1122565640.29823.242.camel@localhost.localdomain>
 <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Jul 2005, Maciej W. Rozycki wrote:
> 
>  Since you're considering GCC-generated code for ffs(), ffz() and friends, 
> how about trying __builtin_ffs(), __builtin_clz() and __builtin_ctz() as 
> apropriate?

Please don't. Try again in three years when everybody has them.

		Linus
