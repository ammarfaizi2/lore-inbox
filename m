Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261750AbTCGTjr>; Fri, 7 Mar 2003 14:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261751AbTCGTjr>; Fri, 7 Mar 2003 14:39:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:43769 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261750AbTCGTjp>;
	Fri, 7 Mar 2003 14:39:45 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 7 Mar 2003 20:50:18 +0100 (MET)
Message-Id: <UTC200303071950.h27JoIW12641.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] register_blkdev
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the prototype changes you did which make absolutely no sense
> to get into 2.5 now when the functions will disappear before 2.6.

Maybe you are right.
But as I said, my goal is to give us a 32-bit dev_t.
It is not necessary to eliminate register_blkdev now,
or before 2.6, in order to reach that goal.
I agree completely that it should go away, and I moved it
in front of the function it is going to be merged with.

In fact I started on the patch to remove it, but the patch
got too large. Many places do register_blkdev early and
blk_register_region later. If the region is taken already
then allocated memory must be freed etc. Trivial work,
but a largish patch. Better to divide the work in steps.

Andries
