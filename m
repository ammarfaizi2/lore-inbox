Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSJZJT7>; Sat, 26 Oct 2002 05:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSJZJT7>; Sat, 26 Oct 2002 05:19:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34867 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262019AbSJZJT6>; Sat, 26 Oct 2002 05:19:58 -0400
To: Mike Galbraith <efault@gmx.de>
Cc: robert w hall <bobh@n-cantrell.demon.co.uk>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: loadlin with 2.5.?? kernels
References: <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
	<m1bs5in1zh.fsf@frodo.biederman.org>
	<5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
	<5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
	<m18z0os1iz.fsf@frodo.biederman.org>
	<007501c27b37$144cf240$6400a8c0@mikeg>
	<m1bs5in1zh.fsf@frodo.biederman.org>
	<5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
	<5.1.0.14.2.20021026073915.00b55008@pop.gmx.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Oct 2002 03:24:16 -0600
In-Reply-To: <5.1.0.14.2.20021026073915.00b55008@pop.gmx.net>
Message-ID: <m1vg3plfi7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> writes:

> At 11:20 PM 10/25/2002 -0600, Eric W. Biederman wrote:
> >Mike Galbraith <efault@gmx.de> writes:
> >
> > > I went back and double-checked my loadlin version, and it turned out I was
> > > actually using 1.6a due to a fat finger.  Version 1.6c booted fine (only one
> 
> > > kernel tested) without Eric's help.  1.6a definitely needs Eric's help to
> > boot.
> >
> >Darn.  I guess the arguments for my patch may not be quite as good,
> >but I still think it may be worth while.
> 
> Well, cleanup is always a pretty fine argument.  Since there only seem to be two
> 
> of us loadlin users, you probably didn't loose much argument wise ;-) The other
> 
> loadlin user reported failure at .38, so maybe your patch is needed sometimes
> even with loadlin-1.6c.  (other loadlin user listening?)

Robert thanks for your reply.

I just looked at what the loadlin 1.6c code does, and it's heuristic
is just slightly more reliable.  It assumes %ds is %cs+8....  That
happens to work but there is nothing in the kernel keeping that from
being broken.  So in practice it looks to be worthwhile to stabilize 
this interface.  So loadlin, and other bootloaders can work by design
and not by chance.

Eric
