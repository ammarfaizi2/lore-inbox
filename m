Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbVKEBUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVKEBUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVKEBUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:20:43 -0500
Received: from kauri.itee.uq.edu.au ([130.102.66.24]:41172 "EHLO
	kauri.itee.uq.edu.au") by vger.kernel.org with ESMTP
	id S1751424AbVKEBUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:20:42 -0500
Date: Sat, 5 Nov 2005 11:15:56 +1000 (EST)
From: cplk@itee.uq.edu.au
X-X-Sender: chrisp@mango.itee.uq.edu.au
To: Andrew Morton <akpm@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, aherrman@de.ibm.com, dm-devel@redhat.com
Subject: Re: [PATCH resubmit] do_mount: reduce stack consumption
In-Reply-To: <20051104160851.3a7463ff.akpm@osdl.org>
Message-ID: <Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
 <20051104084829.714c5dbb.akpm@osdl.org> <20051104212742.GC9222@osiris.ibm.com>
 <20051104235500.GE5368@stusta.de> <20051104160851.3a7463ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: This message probably not SPAM
X-Spam-Score: 0.585
X-Spam-Tests: J_CHICKENPOX_23,NO_REAL_NAME
X-Spam-Report: 0.6 points, 8.0 required;
	 0.3 NO_REAL_NAME           From: does not include a real name
	 0.3 J_CHICKENPOX_23        BODY: 2alpha-pock-3alpha
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This part of the call trace is actually good for >1500 bytes of stack
> > > usage and is what kills us and should be fixed.
> > > I'm surprised that there are no other bug reports regarding DM and
> > > stack overflow with 4k stacks.
> > >...
> > 
> > There were some reports of dm+xfs overflows with 4k stacks on i386.
> > 
> > The xfs side was sorted out, but I son't know the state of the dm part.
> > 
> 
> The state is Very Bad, IMO.  At the very least, DM should struggle to the
> utmost to reduce the stack utilisation around that recursion point.

Neil Brown suggested a change to generic_make_request to convert recursion 
through it into iteration (see http://lkml.org/lkml/2005/9/2/34 ), but 
there was no discussion at the time.  Would this help with this case?

Chris
