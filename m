Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUFEXHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUFEXHO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUFEXHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:07:13 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17796 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262256AbUFEXHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:07:12 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 5 Jun 2004 16:07:06 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Robert Love <rml@ximian.com>
cc: Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <1086475663.7940.50.camel@localhost>
Message-ID: <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com>  <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2004, Robert Love wrote:

> On Sat, 2004-06-05 at 14:53 -0700, Chris Wedgwood wrote:
> 
> > glibc caches getpid() ?!?
> > 
> > it's not like it's a slow syscall or used often
> 
> It is almost certainly done to improve the speed of some stupid
> microbenchmark - say, one that just calls getpid() repeatedly (simple
> because it is NOT slow) to measure system call overhead.
> 
> Or maybe libc uses the PID a lot internally.  I don't know.
> 
> But it sure seems wrong.

It is likely used by pthread_self(), that is pretty much performance 
sensitive. I'd agree with Ulrich here.



- Davide

