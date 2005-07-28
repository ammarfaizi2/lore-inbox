Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVG1Qjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVG1Qjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVG1Qhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:37:39 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:12048 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261588AbVG1QeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:34:13 -0400
Date: Thu, 28 Jul 2005 17:34:18 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <1122565640.29823.242.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org> <1122565640.29823.242.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005, Steven Rostedt wrote:

> I've been playing with different approaches, (still all hot cache
> though), and inspecting the generated code. It's not that the gcc
> generated code is always better for the normal case. But since it sees
> more and everything is not hidden in asm, it can optimise what is being
> used, and how it's used.

 Since you're considering GCC-generated code for ffs(), ffz() and friends, 
how about trying __builtin_ffs(), __builtin_clz() and __builtin_ctz() as 
apropriate?  Reasonably recent GCC may actually be good enough to use the 
fastest code depending on the processor submodel selected.

  Maciej
