Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267494AbUBSTe1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUBSTe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:34:27 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:55738 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S267494AbUBSTeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:34:25 -0500
Date: Thu, 19 Feb 2004 21:34:24 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Tim Hockin <thockin@sun.com>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       akpm@osld.org.sun.com
Subject: Re: PATCH - NGROUPS 2.6.2rc2 + fixups
Message-ID: <20040219193424.GA6735@edu.joroinen.fi>
References: <Pine.LNX.4.58.0401291138390.689@home.osdl.org> <20040130021802.AA5BC2C0BF@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040130021802.AA5BC2C0BF@lists.samba.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 01:09:28PM +1100, Rusty Russell wrote:
> In message <Pine.LNX.4.58.0401291138390.689@home.osdl.org> you write:
> > 
> > 
> > On Thu, 29 Jan 2004, Tim Hockin wrote:
> > > 
> > > What think?
> > 
> > I still don't understand the complexity.
> > 
> > Why the list of pages? Is there really any valid use for this that could 
> > overflow a simple "kmalloc()"? How many groups do people really really 
> > need? 
> 
> I was happy with kmalloc, and no sorting.  Simple patch.  Tim
> complained that he had some wierd-ass users who hit kmalloc limits w/
> fragmentation.  I added about 10 lines of code to fall back to vmalloc
> for that very rare case, and you scotched that.
> 
> ie. Don't blame Tim: you led us here 8(
> 
> Rusty.

So what was the conclusion? It would be nice to get this resolved and merged
in finally.. 

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
