Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267295AbUHST36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267295AbUHST36 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHST1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:27:25 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:64446 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267295AbUHSTYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:24:12 -0400
From: jmerkey@comcast.net
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Date: Thu, 19 Aug 2004 19:24:10 +0000
Message-Id: <081920041924.15410.4124FE5A0007727300003C322200734748970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,

I am looking over the link.  I can get around this (and already have) with 2.6.7 and 2.6.8 by instrumenting a search routine that deals with the out of order conditions.  I appreciate the 
helpful and informative response.

Jeff


> On Thu, Aug 19, 2004 at 06:10:25PM +0000, jmerkey@comcast.net wrote:
> > I've noticed that LKML of late is unresponsive to a lot bug posts and
> > that email is being blocked for a lot of folks.  It smells like partisan
> > politics based on economic motivations and its not really "open" any
> > more when people stoop to this level of behavior.  That aside:
> 
> I attribute this to people being over busy right now.
> 
> > kallsyms in 2.6.8 is presenting module symbol tables with out of order
> > addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> > for Linux 2.6 kernels nighmareish.  Also, the need to kmalloc name strings
> > (like kdb does) from kallsyms in kdbsupport.c while IN THE DEBUGGER makes
> > it impossible to debug large portions of the kernel code with kdb, so I
> > have rewritten large sections of kallsyms.c to handle all these broken,
> > brain-dead cases in mdb and I am not relying much on kdb hooks anymore.
> > Why on earth does Linux need to have shifting tables of test strings
> > for module names requiring all this complexity in the symbol tables
> > and kallsyms.
> 
> It must be useful for people using small memory footprint machines.
> Check with the folks doing embedded stuff.
> 
> I remember a discussion about kallsyms and scaling problems with
> top reading some /proc/<pid> file.
> 
> Look at this:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108758995727517&w=2
> 
> > I don't expect a response so I'll keep coding around the broken Linux
> > 2.6 code but I wanted to post a record of this so perhaps someone will
> > think about over-engineering systems which should be left alone.
> > 
> > Jeff
> 
> Good Luck,
> Robin Holt
