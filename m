Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277224AbRJDVOy>; Thu, 4 Oct 2001 17:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277226AbRJDVOn>; Thu, 4 Oct 2001 17:14:43 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:55711 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S277224AbRJDVOe>;
	Thu, 4 Oct 2001 17:14:34 -0400
From: arjan@fenrus.demon.nl
To: kravetz@us.ibm.com (Mike Kravetz)
Subject: Re: Context switch times
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011004140417.C1245@w-mikek2.des.beaverton.ibm.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15pFor-0004sC-00@fenrus.demon.nl>
Date: Thu, 04 Oct 2001 22:14:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011004140417.C1245@w-mikek2.des.beaverton.ibm.com> you wrote:
> 2.4.10 on 8 CPUs:  lat_ctx -s 0 -r 2 results
> "size=0k ovr=2.27
> 2 3.86

> 2.2.16-22 on 8 CPUS:  lat_ctx -s 0 -r 2 results
> "size=0k ovr=1.99
> 2 1.44

> As you can see, the context switch times for 2.4.10 are more
> than double what they were for 2.2.16-22 in this example.  

> Comments?

2.4.x supports SSE on pentium III/athlons, so the SSE registers need to be
saved/restored on a taskswitch as well.... that's not exactly free.

