Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264318AbTCXS4A>; Mon, 24 Mar 2003 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264319AbTCXS4A>; Mon, 24 Mar 2003 13:56:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57233 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264318AbTCXSz7>;
	Mon, 24 Mar 2003 13:55:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 24 Mar 2003 20:07:05 +0100 (MET)
Message-Id: <UTC200303241907.h2OJ75619479.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you look at Roman's patches they don't hinder your dev_t enlargement

Not very much. A little.
And in some ways they are a step back.

> I'm personally not yet completly happy with his interface either
> because he still uses the major/minor split

Yes, it is more elegant to register one or more ranges.
(But ranges of what? Ranges in dev_t space? Or in kdev_t space?
Here you see one reason to wait a little until dev_t/kdev_t
stuff has settled.)
Also, you'll notice that the current simple hash scheme is insufficient
if we want to have subranges that override larger ranges.
But life is easier if we postpone that discussion a bit.

# It would help a lot if you would explain what the next stages are.

- Polish the kernel until a change of the size of dev_t is possible.
- Agree on a new size for dev_t, major, minor.  Make the change.
- Ask Ulrich to update glibc.

On the last part: Ulrich already said that the changes are trivial
and that he is waiting for kernel people to make up their minds on
what dev_t and major and minor are supposed to be.

On the first part: Earlier today I sent a patch on stat.h for a
number of architectures. There are a few more such steps.

Andries
