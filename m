Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbVG2PK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbVG2PK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVG2PKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:10:25 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32264 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262609AbVG2PJT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:09:19 -0400
Date: Fri, 29 Jul 2005 16:09:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <Pine.LNX.4.58.0507281017130.3227@g5.osdl.org>
Message-ID: <Pine.LNX.4.61L.0507291556500.21257@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org> <1122565640.29823.242.camel@localhost.localdomain>
 <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0507281017130.3227@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Linus Torvalds wrote:

> >  Since you're considering GCC-generated code for ffs(), ffz() and friends, 
> > how about trying __builtin_ffs(), __builtin_clz() and __builtin_ctz() as 
> > apropriate?
> 
> Please don't. Try again in three years when everybody has them.

 Well, __builtin_ffs() has been there since at least gcc 2.95.  The two 
others are quite recent, indeed -- apparently only since GCC 3.4.  They 
may still be considered to be used conditionally if there is justified 
benefit.

  Maciej
