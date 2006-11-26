Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967306AbWKZGZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967306AbWKZGZI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 01:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967307AbWKZGZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 01:25:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:62943 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S967306AbWKZGZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 01:25:06 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc6-mm1 -- sched-improve-migration-accuracy.patch slows
	boot
From: Mike Galbraith <efault@gmx.de>
To: Don Mullis <dwm@meer.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <1164484124.2894.50.camel@localhost.localdomain>
References: <20061123021703.8550e37e.akpm@osdl.org>
	 <1164484124.2894.50.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 26 Nov 2006 07:24:23 +0100
Message-Id: <1164522263.5808.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-25 at 11:48 -0800, Don Mullis wrote:
> > +sched-improve-migration-accuracy.patch
> > +sched-improve-migration-accuracy-tidy.patch
> 
> Bisection shows that this pair of patches raises the boot time;
> specifically, the delay from logging of
> 
>         "INIT: version 2.86 booting"
>         
> to
>         "                Welcome to Fedora Core"
>  
> goes from 4s to 4m40s.  From there to

Wow.

>  
> 
>     "Setting clock  (utc): Sat Nov 25 10:18:11 PST 2006 [  OK  ]"
> 
> takes an additional 30s.

This must be a bisection false positive.  The patch in question is
essentially a no-op for a UP kernel.
        
	-Mike

