Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSFOAWH>; Fri, 14 Jun 2002 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSFOAWG>; Fri, 14 Jun 2002 20:22:06 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:15252 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S314783AbSFOAWG>; Fri, 14 Jun 2002 20:22:06 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 14 Jun 2002 17:22:01 -0700
Message-Id: <200206150022.RAA27094@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No, I can't prove it.  But I can't think of a contrary scenario
>either.

	People feel that way about almost every piece of code that
eventually gets an unexpected failure.  Lots of code written to
this sort of feeling leads to sporadic difficult to reproduce
failures that may never be traced to its origin.

	Look at it this way, with bio_chain you don't even have to
write error branches for it.

	Also, if everyone eventually used bio_chain then maybe you
would not have to set aside such large memory reserves, etc., but
that would be in the more distant future.

	Anyhow, I can write bio_chain in a separate file without
touching changing any existing code in the kernel, if I am not going
to implement the merge hint.  I think I will do just that so that
we have something that we can discuss more concretely.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
