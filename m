Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbREYTCe>; Fri, 25 May 2001 15:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbREYTCY>; Fri, 25 May 2001 15:02:24 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:21637 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S261692AbREYTCL>;
	Fri, 25 May 2001 15:02:11 -0400
Message-Id: <m153BuC-000OiPC@amadeus.home.nl>
Date: Fri, 25 May 2001 08:21:04 +0100 (BST)
From: arjan@fenrus.demon.nl
To: engler@csl.Stanford.EDU (Dawson Engler)
Subject: Re: [CHECKER] error path memory leaks in 2.4.4 and 2.4.4-ac8
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105250238.TAA00788@csl.Stanford.EDU>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200105250238.TAA00788@csl.Stanford.EDU> you wrote:
>> I believe we can make that a short. Arjan?

> Is the general way to fix these too-large stack vars to heap allocate
> them?  Or is it preferable to put a "static" in front of them, if the
> routine is non-reentrant?

You're not always allowed to allocate memory. Esp in filesystems it can be
tricky as writes can be triggered by low-memory situations and allocating
memory their is suboptimal.
