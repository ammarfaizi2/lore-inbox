Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUA3CRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 21:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266610AbUA3CRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 21:17:49 -0500
Received: from dp.samba.org ([66.70.73.150]:26515 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266609AbUA3CRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 21:17:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tim Hockin <thockin@sun.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       akpm@osld.org.sun.com
Subject: Re: PATCH - NGROUPS 2.6.2rc2 + fixups 
In-reply-to: Your message of "Thu, 29 Jan 2004 11:41:31 -0800."
             <Pine.LNX.4.58.0401291138390.689@home.osdl.org> 
Date: Fri, 30 Jan 2004 13:09:28 +1100
Message-Id: <20040130021802.AA5BC2C0BF@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0401291138390.689@home.osdl.org> you write:
> 
> 
> On Thu, 29 Jan 2004, Tim Hockin wrote:
> > 
> > What think?
> 
> I still don't understand the complexity.
> 
> Why the list of pages? Is there really any valid use for this that could 
> overflow a simple "kmalloc()"? How many groups do people really really 
> need? 

I was happy with kmalloc, and no sorting.  Simple patch.  Tim
complained that he had some wierd-ass users who hit kmalloc limits w/
fragmentation.  I added about 10 lines of code to fall back to vmalloc
for that very rare case, and you scotched that.

ie. Don't blame Tim: you led us here 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
