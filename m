Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267853AbTB1Mz3>; Fri, 28 Feb 2003 07:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbTB1Mz3>; Fri, 28 Feb 2003 07:55:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40201 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267853AbTB1Mz2>; Fri, 28 Feb 2003 07:55:28 -0500
Date: Fri, 28 Feb 2003 14:05:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030228130548.GA8498@atrey.karlin.mff.cuni.cz>
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030228121725.B2241@in.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since we've had to work on a solution that can be used 
> for accurate non-disruptive dumps as well as crash dumps
> (the latter using kexec), I was wondering whether it 
> was worth exploring possibilities of commonality with 
> swsusp down the line ... I know its not probably not 
> something very immediate, but just an indication on 
> whether we should keep applicability for swsusp (probably 
> reuse and share ideas/code back and forth between the 
> two efforts) in mind as we move forward. Because we 
> have to support a more restrictive situation when it 
> comes to dumping, it just may be usable by swsusp too 
> if we can get it right.

Well, less code duplication is always welcome. But notice we need
*atomic* snapshots in swsusp, else we might corrupt data.
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
