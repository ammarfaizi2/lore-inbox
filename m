Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbSJNSBK>; Mon, 14 Oct 2002 14:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSJNSBK>; Mon, 14 Oct 2002 14:01:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48565 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262068AbSJNSBI>;
	Mon, 14 Oct 2002 14:01:08 -0400
Subject: Re: Evolution and 2.5.x
From: Andy Pfiffer <andyp@osdl.org>
To: Robert Love <rml@tech9.net>
Cc: Eric Blade <eblade@m-net.arbornet.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1034535804.6032.4501.camel@phantasy>
References: <200210131854.g9DIs1I0062874@m-net.arbornet.org> 
	<1034535804.6032.4501.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 14 Oct 2002 11:07:01 -0700
Message-Id: <1034618822.1995.47.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-13 at 12:03, Robert Love wrote:
> On Sun, 2002-10-13 at 14:54, Eric Blade wrote:
> 
> >   I'm guessing that not too many of the kernel developers use Evolution as
> > their email program :)   Since I started picking up the 2.5.x series, at around
> > 2.5.34, Evolution does not run anywhere near properly.  I'm not sure if that
> > is a kernel issue, or a problem with Evolution's code..  But it did improve
> > quite a bit with all the low-level process management that was in the 2.5.3x 
> > series.  It still doesn't work right though.  (in 2.5.34, evolution would
> > just plain halt the system ... in 2.5.42, it mostly works right, as long
> > as you don't try to compose a message.. composing a message will leave you
> > with a whole buch of zombie processes). 
> 
> Hey, I use Evolution ;-)
> 
> See this thread:
> http://lists.ximian.com/archives/public/evolution-hackers/2002-June/004841.html
> 
> It is indeed broken in 2.5 and it is not, for once, our fault.  This
> thread and other discussion seem to point out it is a bug in ORBit.
> 
> 	Robert Love

I spent some time trying to track this problem down, but reached a wall
due to the size and nature of the ChangeSet.

The bitkeeper ChangeSet that made Evolution's address book hang when
trying to compose a new message when run on 2.5.x kernels was 1.262.2.2.

According to my notes from June, that ChangeSet comprised modifications
to 116 files, splitting the socket structure from the protocol.  Up to
that ChangeSet, the problem does not exist.  After applying that
ChangeSet, the problem is manifest.

Sorry I couldn't dig deeper...and I hope this helps someone.

Andy


