Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbVEHQJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbVEHQJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVEHQJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 12:09:59 -0400
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:27997 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262890AbVEHQJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 12:09:53 -0400
Subject: Re: /proc/cpuinfo format - arch dependent!
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Jim Nance <jlnance@sdf.lonestar.org>
Cc: Dave Jones <davej@redhat.com>, Willy Tarreau <willy@w.ods.org>,
       Andrew Morton <akpm@osdl.org>, Ricky Beam <jfbeam@bluetronic.net>,
       nico-kernel@schottelius.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050508012521.GA24268@SDF.LONESTAR.ORG>
References: <20050419121530.GB23282@schottelius.org>
	 <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net>
	 <20050506211455.3d2b3f29.akpm@osdl.org>
	 <20050507075828.GF777@alpha.home.local> <20050507165357.GA19601@redhat.com>
	 <20050507170555.GA19329@alpha.home.local>
	 <20050507172005.GB26088@redhat.com>
	 <20050508012521.GA24268@SDF.LONESTAR.ORG>
Content-Type: text/plain
Message-Id: <1115568673.5536.18.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 08 May 2005 12:11:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-07 at 21:25, Jim Nance wrote:
> On Sat, May 07, 2005 at 01:20:05PM -0400, Dave Jones wrote:
> > On Sat, May 07, 2005 at 07:05:56PM +0200, Willy Tarreau wrote:
> 
> >  > system "hey, I'd like this type of workload, how many process should
> >  > I start, and where should I bind them ?".
> > 
> > I think generalising this and having a method to do this in the kernel
> > is a much better idea than each application parsing this themselves.
> > Things are only getting more and more complex as time goes on,
> > and I don't trust application developers to get it right.
> 
> As a developer of a multiprocess/multithreaded application I can assure
> you that you are right not to trust application developers to get this
> right.  The idea that a programmer understands the behavior of the
> applications they write is largely a myth.  Furthermore, I suspect
> that SMT will evolve in directions that make the idea of a processor
> more and more fuzzy.  I don't think it is wise to construct any
> interface that suggests knowing the hardware details is good, or that
> processes should be bound by userland.  Certainly it is sometimes
> necessary for userland to do this, but we should look at that as a
> bug in the kernel.
> 
> Thanks,
> 
> Jim

Aw c'mon. Don't we believe in the C programming philosphy of trusting
the programmer? You know, give them enough rope to hang themselves?
Personally, I don't care because I can parse cpuid and the like directly
myself, but examples of legitimate uses for this knowledge are
compilers, jvms, and threading libraries, all which although lowlevel,
are technically userland. I don't think it's our job to protect the user
from themselves, it's to give them a reasonable default, and the
interfaces to take advantage of the tricker stuff for special purposes
if they wish.

