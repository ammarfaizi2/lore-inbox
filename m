Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277653AbRKVMMU>; Thu, 22 Nov 2001 07:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277713AbRKVMMM>; Thu, 22 Nov 2001 07:12:12 -0500
Received: from ns.caldera.de ([212.34.180.1]:34437 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S277653AbRKVMMC>;
	Thu, 22 Nov 2001 07:12:02 -0500
Date: Thu, 22 Nov 2001 13:11:50 +0100
Message-Id: <200111221211.fAMCBoc15728@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: oliver@neukum.org (Oliver Neukum)
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Rick Lindsley <ricklind@us.ibm.com>,
        "David C. Hansen" <haveblue@us.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <01112211121601.00690@argo>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01112211121601.00690@argo> you wrote:
> At least some of the removals in the input tree are probably wrong. You are 
> introducing a race with deregistering of input devices.

Nope, it's fine to remove it.  Input is racy all over the place and the list
are modified somewhere else without any locking anyways.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
