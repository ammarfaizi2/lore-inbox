Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132039AbRDFQ6z>; Fri, 6 Apr 2001 12:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDFQ6o>; Fri, 6 Apr 2001 12:58:44 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:33152
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S132039AbRDFQ6a>; Fri, 6 Apr 2001 12:58:30 -0400
Date: Fri, 6 Apr 2001 09:57:32 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200104061657.f36GvWn01002@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: majer@endeca.com, linux-kernel@vger.kernel.org
Subject: Re: memory allocation problems
In-Reply-To: <Pine.LNX.4.21.0104061001280.9562-300000@caffeine.ops.endeca.com>
In-Reply-To: <Pine.LNX.4.21.0104061001280.9562-300000@caffeine.ops.endeca.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

>  Essentially, the problem can be summarized to be that on a machine
>  with ample ram (2G, 4G, etc), I am unable to malloc a gig if I ask 
>  for the memory in small ( <= 128k) chunks. 

Take a look at this message by Szabolcs Szakacsits:

http://marc.theaimsgroup.com/?l=linux-kernel&m=97898653909227&w=2

There are other messages that may be of interest to you in that
thread, although they are spread out in a large thread.

Briefly, malloc in glibc will use brk() for "small" chunks and mmap()
for "large" chunks.  On a usual i386 linux kernel, the 4GB address
space is set up so that brk() can get at most 870MB or so and mmap()
can get at most 2GB.  Newer glibc's allow you to tune the definition
of "small" via an environment variable.

Cheers,
Wayne
