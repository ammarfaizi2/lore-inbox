Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbTB1Nds>; Fri, 28 Feb 2003 08:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267880AbTB1Nds>; Fri, 28 Feb 2003 08:33:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1809 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267879AbTB1Ndr>; Fri, 28 Feb 2003 08:33:47 -0500
Date: Fri, 28 Feb 2003 14:44:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030228134406.GA14927@atrey.karlin.mff.cuni.cz>
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228190924.A3034@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Since we've had to work on a solution that can be used 
> > > for accurate non-disruptive dumps as well as crash dumps
> > > (the latter using kexec), I was wondering whether it 
> > > was worth exploring possibilities of commonality with 
> > > swsusp down the line ... I know its not probably not 
> > > something very immediate, but just an indication on 
> > > whether we should keep applicability for swsusp (probably 
> > > reuse and share ideas/code back and forth between the 
> > > two efforts) in mind as we move forward. Because we 
> > > have to support a more restrictive situation when it 
> > > comes to dumping, it just may be usable by swsusp too 
> > > if we can get it right.
> > 
> > Well, less code duplication is always welcome. But notice we need
> > *atomic* snapshots in swsusp, else we might corrupt data.
> 
> Atomic snapshots are what we'd like for dump too, since we desire 
> accurate dumps (minimum drift), so its not a conflicting requirement. 
> The difference is that while you could do i/o (e.g to flush pages 
> to free up memory) before initiating an atomic snapshot, we can't.

OTOH "best-effort-atomic" is probably okay for you, while it is not
acceptable for swsusp. Hopefully the code is not going to get too
complicated by "must be atomic" and "must work with crashed system"
requirements...

							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
