Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266133AbUHSTAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbUHSTAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUHSTAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:00:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37794 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266133AbUHSTAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:00:33 -0400
Date: Thu, 19 Aug 2004 14:00:29 -0500
From: Robin Holt <holt@sgi.com>
To: jmerkey@comcast.net
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Message-ID: <20040819190029.GC1313@lnx-holt.americas.sgi.com>
References: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <081920041810.18883.4124ED110002BABC000049C32200748184970A059D0A0306@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 06:10:25PM +0000, jmerkey@comcast.net wrote:
> I've noticed that LKML of late is unresponsive to a lot bug posts and
> that email is being blocked for a lot of folks.  It smells like partisan
> politics based on economic motivations and its not really "open" any
> more when people stoop to this level of behavior.  That aside:

I attribute this to people being over busy right now.

> kallsyms in 2.6.8 is presenting module symbol tables with out of order
> addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> for Linux 2.6 kernels nighmareish.  Also, the need to kmalloc name strings
> (like kdb does) from kallsyms in kdbsupport.c while IN THE DEBUGGER makes
> it impossible to debug large portions of the kernel code with kdb, so I
> have rewritten large sections of kallsyms.c to handle all these broken,
> brain-dead cases in mdb and I am not relying much on kdb hooks anymore.
> Why on earth does Linux need to have shifting tables of test strings
> for module names requiring all this complexity in the symbol tables
> and kallsyms.

It must be useful for people using small memory footprint machines.
Check with the folks doing embedded stuff.

I remember a discussion about kallsyms and scaling problems with
top reading some /proc/<pid> file.

Look at this:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108758995727517&w=2

> I don't expect a response so I'll keep coding around the broken Linux
> 2.6 code but I wanted to post a record of this so perhaps someone will
> think about over-engineering systems which should be left alone.
> 
> Jeff

Good Luck,
Robin Holt
