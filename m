Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTEOAsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTEOAsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:48:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4873 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263246AbTEOAr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:47:59 -0400
Date: Wed, 14 May 2003 18:00:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christopher Hoover <ch@murgatroid.com>
cc: "'Andrew Morton'" <akpm@digeo.com>,
       "'Perez-Gonzalez, Inaky'" <inaky.perez-gonzalez@intel.com>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <001c01c31a7c$327cc350$175e040f@bergamot>
Message-ID: <Pine.LNX.4.44.0305141758070.28007-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Christopher Hoover wrote:
> > 
> > (I ran a futex-free ppc64 kernel.  It worked.)
> 
> Yep.  I'm run an ARM kernel as well.  Works fine.

And do you guys actually use a recent glibc snapshot? Do you ever expect 
to? Do you ever expect to run a third-party specialized web-server or 
database library? All things that can use futex'es, and probably will. 

I will strongly argue against making futexes conditional, simply because I 
_want_ people to be able to depend on them in modern kernels. I do not 
want developers to fall back on SysV semaphores just because it's too 
painful for them to use the faster alternatives.

		Linus

