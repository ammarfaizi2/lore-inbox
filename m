Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUB0GKo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUB0GKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:10:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:12434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261704AbUB0GKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:10:42 -0500
Date: Thu, 26 Feb 2004 22:16:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add getdents32t syscall
In-Reply-To: <403E9E4D.6090301@redhat.com>
Message-ID: <Pine.LNX.4.58.0402262212340.2563@ppc970.osdl.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
 <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
 <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
 <20040226223212.GA31589@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org> <403E9E4D.6090301@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Ulrich Drepper wrote:
> 
> > In other words, why doesn't glibc ever just make a new major number and
> > make its "struct dirent" be the 64-bit version?
> 
> You can't be serious.  Can you even imagine the pain this would cause?

Do you know how much pain it causes when you make changes and you do _not_ 
change the major number?

At some point you need to clean up. 

This issue has been with us for years and years. I don't understand why
you'd want to add a totally new system call now. Instead, I'd suggest you 
just put this on the long list of things to fix for when a new major 
number is to be used.

And yes, you should use a new major number at some point. It is
_senseless_ to never update the majors. Just make a clean break, go
through every little nagging ugly thing (and there are a _lot_ of them 
that have accumulated over the years), and make ready for "libc-3.0".

No, I'm not suggesting you do it for this one thing, obviously. But 
there's bound to be _thousands_ of these stupid things where glibc has 
compatibility crap that makes no sense.

		Linus
