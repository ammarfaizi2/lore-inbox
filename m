Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129099AbQKIQDn>; Thu, 9 Nov 2000 11:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKIQDd>; Thu, 9 Nov 2000 11:03:33 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:62809 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129099AbQKIQDX>; Thu, 9 Nov 2000 11:03:23 -0500
Date: Thu, 9 Nov 2000 10:03:21 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200011091603.KAA347653@tomcat.admin.navo.hpc.mil>
To: 1997s112@educ.disi.unige.it, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.17 bug found
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2000 at 05:20:22PM +0200, Andrea Pintori wrote:
> I've a Debian dist, Kernel 2.2.17, no patches, all packages are stable.
> 
> here what I found:
> 
> [/tmp] mkdir old
> [/tmp] chdir old
> [/tmp/old] mv . ../new
> [/tmp/old]                    (should be /tmp/new !!)
> [/tmp/old] mkdir fff
> error: cannot write...
> [tmp/old] ls > fff
> error: cannot write...
> [/tmp/old] ls -la
> total 0                         (?)
> [/tmp/old] cd ..
> [/tmp] ls -la
> *****************       ./
> *****************       ../
> *****************       new/
> 
> Does anybody knew this bug?

Not a bug... possibly a typo though. The "[/tmp/old] mv . ../new" line
destroys the definition of "current directory". The "mkdir fff" can't work
since the current directory is no longer there, and is indicated by
the lines:
     [/tmp/old] ls -la
     total 0                         (?)

There is nothing to take a directory of.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
