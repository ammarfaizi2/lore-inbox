Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSBCSkN>; Sun, 3 Feb 2002 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287532AbSBCSjy>; Sun, 3 Feb 2002 13:39:54 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:33503 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287518AbSBCSjq>; Sun, 3 Feb 2002 13:39:46 -0500
Message-Id: <200202011342.g11DgBfd001291@tigger.cs.uni-dortmund.de>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Message from Keith Owens <kaos@ocs.com.au> 
   of "Fri, 01 Feb 2002 16:18:03 +1100." <26363.1012540683@kao2.melbourne.sgi.com> 
Date: Fri, 01 Feb 2002 14:42:11 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> said:

[...]

> I know, it makes it even harder to see what the initialization order
> is.  Some are controlled by the Makefile/subdirs order, some by special
> calls in the code.

Just to repeat myself: This is clearly a problem for tsort(1): Give
restrictions of the form "This has to come after that" (perhaps a special
comment at the start of the file containing the init function?), tsort that
and pick the order out of the result. Should be a few lines of script. No
central repository for the dependencies, no messing around with half the
world to fix dependencies. Plus they become explicit, which they aren't
today.
-- 
Horst von Brand			     http://counter.li.org # 22616
