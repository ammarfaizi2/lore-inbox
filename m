Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbVBEM7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbVBEM7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 07:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267412AbVBEM7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 07:59:13 -0500
Received: from mail.linicks.net ([217.204.244.146]:59274 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S267380AbVBEM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 07:59:05 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Post install 2.4.29 causes many apps to seg fault.
Date: Sat, 5 Feb 2005 12:59:03 +0000
User-Agent: KMail/1.7.2
References: <200502042040.46367.nick@linicks.net> <1107568892.420428fc548c2@www.adndrealm.net>
In-Reply-To: <1107568892.420428fc548c2@www.adndrealm.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051259.03400.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 February 2005 02:01, Gary Smith wrote:
> Quoting Nick Warne <nick@linicks.net>:
> > Here is the link that explains it... what to do with many processes
> > segfaulting, I don't know.  RHEL support is _very_ good - give them a
> > ring.
> >
> > http://people.redhat.com/drepper/assumekernel.html
> >
> > Nick
>
> Nick,
>
> The article seems to make sense about the versioning.  I was wondering what
> your resolution was.

I run two boxes in the UK with RHEL 3 for DNS/DHCP running Lucent's QIP/QMS 
services (Montreal admins run that).  All I am is local SysAdmin on all the 
other stuff.

When I up2dated GLIBC the only thing that went wonky at first was 
smartmontools (built from src), everything else appeared OK.  About 4 days 
later, I was asked to check why one of the QIP monitoring tools wasn't 
running (it's a JVM thing, precompiled binaries).  I then called the Montreal 
Linux guy, and he sussed it and told me it was the assume_kernel problem.

As it is their area, I never asked what he done exactly to fix it, but he did 
say that although the GLIBC upgrade broke the tool, once he fixed the 
problem, it was now working correctly using pthreads (or something) that it 
wouldn't use before the upgrade.  I will ask for more info Monday when back 
at work.

I think Barry K. Nathan reason/problem/solution looks more likely though, re 
futex in this thread.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
