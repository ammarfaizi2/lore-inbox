Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132748AbRC2Pfw>; Thu, 29 Mar 2001 10:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132749AbRC2Pfp>; Thu, 29 Mar 2001 10:35:45 -0500
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:41229 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id <S132748AbRC2Pf2>; Thu, 29 Mar 2001 10:35:28 -0500
Message-Id: <200103291534.f2TFYr700338@robert2.mpe-garching.mpg.de>
reply-to: robert@mpe.mpg.de
cc: linux-kernel@vger.kernel.org
To: David Wragg <dpw@doc.ic.ac.uk>
Subject: Solved with MTRR was: ISSUE: very slow (factor 100) 4-way 16GByte server, with 2.4.2 
In-Reply-To: Your message of "29 Mar 2001 00:07:17 -0000."
             <y7rk859780a.fsf@sytry.doc.ic.ac.uk> 
Date: Thu, 29 Mar 2001 17:34:53 +0200
From: Robert Suetterlin <sutter@robert2.mpe-garching.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone,

	especially David, for explaining the MTRR problem to me in detail.

I could get the machine to work nicely by mapping all memory in MTRRs.

There are only two corrections I would like to make to Davids eMail:
> # cat >/proc/mtrr
> disable=2
> disable=3
> disable=4
> disable=5
> disable=6
> disable=7
> base=0 size=0x400000000 type=write-back
> base=0x400000000 size=0x4000000 type=write-back
> base=0x404000000 size=0x1000000 type=write-back
> ^D

1. it is cat >| /proc/mtrr
2. I was not allowed to do `base=0 size=0x400000000 type=write-back`, because of the overlap with the memory range at base=0x0fb000000.  So what I do is only disable 3-7, and then base=0x400000000 size=0x400000000.


Thanks alot,

	Robert S.
