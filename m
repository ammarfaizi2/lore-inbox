Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTKYQXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKYQXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:23:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26631 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261780AbTKYQXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:23:02 -0500
Date: Tue, 25 Nov 2003 11:11:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
In-Reply-To: <20031124163553.B16684@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1031125110239.4037A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Chris Wright wrote:

> * bill davidsen (davidsen@tmr.com) wrote:
> > 
> > While I think you're overblowing the problem, it is an issue which might
> > be addressed in SE Linux or somewhere. I have an idea on that, but I
> > want to look before I suggest anything.
> 
> SELinux controls hard link creation by checking, among other things,
> the security context of the process attempting the link, and the security
> context of the target (oldpath).  Other MAC systems do similar, and some
> patches such as grsec and owl simply disable linking to files the user
> can't read/write to for example.
> 
> > Bear in mind it isn't a "problem" it's 'expected behaviour" for the o/s,
> > and might even be mentioned in SuS somehow. Interesting topic, but not a
> > bug, since the behaviour is as intended.
> 
> SuS states:
> 	
> 	The implementation may require that the calling process has
> 	permission to access the existing file.
> 
> Note the use of *may*.

I note the "permission to access" as well, that's not exactly definitive,
either. Could mean anything from rwx on the file to execute on the file
and all directories in the path. And a conforming o/s could demand that
the process doing the link have the same EUID as the UID of the file. I
would expect that to break things, however, although the things which
break may not be desirable!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

