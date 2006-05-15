Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWEOW4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWEOW4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWEOW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:56:35 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40590 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750719AbWEOW4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:56:34 -0400
Subject: Re: Segfault on the i386 enter instruction
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Stas Sergeev <stsp@aknet.ru>, Andi Kleen <ak@muc.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200605160049.49384.ioe-lkml@rameria.de>
References: <44676F42.7080907@aknet.ru> <4468D8CA.6070702@aknet.ru>
	 <1147722991.13948.19.camel@mindpipe>
	 <200605160049.49384.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Mon, 15 May 2006 18:56:31 -0400
Message-Id: <1147733792.13948.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 00:49 +0200, Ingo Oeser wrote:
> Hi Lee,
> 
> On Monday, 15. May 2006 21:56, Lee Revell wrote:
> > Just FYI, this does actually have an important effect on multithreaded
> > programs - glibc will allocate RLIMIT_STACK for each thread stack.  If
> > mlockall() is used this can eat quite a bit of memory.  It's a real
> > world problem for some pro audio apps.
> 
> If it is: pthread_attr_setstacksize() is your friend.
> If you like to use the big hammer: just lower RLIMIT_STACK.
> 
> So no unsolvable real world problem here :-)
> 

Yep, that's exactly what we do in JACK.  POSIX makes it quite explicit
that one should not assume the default thread stack size is sane...

Lee



