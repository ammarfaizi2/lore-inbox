Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267761AbTB1NXq>; Fri, 28 Feb 2003 08:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbTB1NXq>; Fri, 28 Feb 2003 08:23:46 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:2970 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267761AbTB1NXp>;
	Fri, 28 Feb 2003 08:23:45 -0500
Date: Fri, 28 Feb 2003 19:09:24 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030228190924.A3034@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030228130548.GA8498@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Fri, Feb 28, 2003 at 02:05:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 02:05:48PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Since we've had to work on a solution that can be used 
> > for accurate non-disruptive dumps as well as crash dumps
> > (the latter using kexec), I was wondering whether it 
> > was worth exploring possibilities of commonality with 
> > swsusp down the line ... I know its not probably not 
> > something very immediate, but just an indication on 
> > whether we should keep applicability for swsusp (probably 
> > reuse and share ideas/code back and forth between the 
> > two efforts) in mind as we move forward. Because we 
> > have to support a more restrictive situation when it 
> > comes to dumping, it just may be usable by swsusp too 
> > if we can get it right.
> 
> Well, less code duplication is always welcome. But notice we need
> *atomic* snapshots in swsusp, else we might corrupt data.

Atomic snapshots are what we'd like for dump too, since we desire 
accurate dumps (minimum drift), so its not a conflicting requirement. 
The difference is that while you could do i/o (e.g to flush pages 
to free up memory) before initiating an atomic snapshot, we can't.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

