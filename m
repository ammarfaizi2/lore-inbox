Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbSK1VcP>; Thu, 28 Nov 2002 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbSK1VcP>; Thu, 28 Nov 2002 16:32:15 -0500
Received: from talus.maths.usyd.edu.au ([129.78.68.1]:5393 "EHLO
	talus.maths.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S266761AbSK1VcO>; Thu, 28 Nov 2002 16:32:14 -0500
Date: Fri, 29 Nov 2002 08:37:00 +1100 (EST)
From: psz@maths.usyd.edu.au (Paul Szabo)
Message-Id: <200211282137.gASLb0L362393@milan.maths.usyd.edu.au>
To: solar@openwall.com
Subject: Re: d_path() truncating excessive long path name vulnerability
Cc: bugtraq@securityfocus.com, cliph@isec.pl, jikos@jikos.cz,
       linux-kernel@vger.kernel.org, security@debian.org, security@isec.pl,
       vulnwatch@vulnwatch.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solar Designer wrote:

> FWIW, I've included a workaround for this (covering the getcwd(2) case
> only, not other uses of d_path() by the kernel or modules) in 2.2.21-ow1
> patch and it went into 2.2.22 release in September.

Another reply shows that a patch has been submitted, but not acted upon:

> From jikos@jikos.cz Wed Nov 27 21:39:07 2002
> Date: Wed, 27 Nov 2002 11:38:25 +0100 (CET)
> From: Jirka Kosina <jikos@jikos.cz>
> To: Paul Szabo <psz@maths.usyd.edu.au>
> Subject: Re: d_path() truncating excessive long path name vulnerability
> 
> On Wed, 27 Nov 2002, Paul Szabo wrote:
> 
> > > In case of excessively long path names d_path kernel internal function
> > > returns truncated trailing components of a path name instead of an error
> > > value. As this function is called by getcwd(2) system call and
> > > do_proc_readlink() function, false information may be returned to
> > > user-space processes.
> > The problem is still present in Debian 2.4.19 kernel. I have not tried 2.5,
> > but see nothing relevant in the Changelogs at http://www.kernel.org/ .
> 
> I've sent patch to linux-kernel, but noone seemed interested 
> (http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0054.html)
> 
> -- 
> JiKos.

Cheers,

Paul Szabo - psz@maths.usyd.edu.au  http://www.maths.usyd.edu.au:8000/u/psz/
School of Mathematics and Statistics  University of Sydney   2006  Australia
