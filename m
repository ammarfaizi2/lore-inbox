Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbVG2Ol5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbVG2Ol5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 10:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVG2Ol4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 10:41:56 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47111 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262603AbVG2Olu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 10:41:50 -0400
Date: Fri, 29 Jul 2005 15:41:55 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122631385.8317.26.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.61L.0507291540260.21257@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl> 
 <1122569848.29823.248.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org> <1122631385.8317.26.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, David Woodhouse wrote:

> Builtins are more portable and their implementation will improve to
> match developments in the target CPU. Inline assembly, as we have seen,
> remains the same for years while the technology moves on.
> 
> Although it's often the case that inline assembly _is_ better,
> especially in code which is arch-specific in the first place, I wouldn't
> necessarily assume that it's always the case.

 Well, if some inline assembly is found to be better, then perhaps it 
should be contributed (not necessarily as is, but as a concept) to GCC for 
improvement.

  Maciej
