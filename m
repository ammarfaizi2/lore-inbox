Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSFPHs3>; Sun, 16 Jun 2002 03:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315993AbSFPHs2>; Sun, 16 Jun 2002 03:48:28 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44419 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315988AbSFPHs2>;
	Sun, 16 Jun 2002 03:48:28 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 16 Jun 2002 09:47:52 +0200 (MEST)
Message-Id: <UTC200206160747.g5G7lqX28244.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wrong.  That breaks for anything with ->follow_link() that
> can't be expressed as a single lookup on some path.

I don't know what interesting out-of-tree filesystems you
have in mind, but it looks like this would work for all
systems in the current tree.

> For fsck sake, give the folks here some credit

Funny to hear that from you.

Andries


P.S. Now that you exist again, let me repeat a question
from a few weeks ago. Many years ago I constructed kdev_t,
a pointer to a struct containing the things that lived in
the arrays and some useful functions like a function returning
the name. It was passed around as reference to the device.
You are replacing kdev_t by struct block device *, that I
consider as a refcounted reference to the device. Fine.
But kdev_t is created by the driver, at the moment the
device is detected, while struct block device * is created
at open() time. Thus, the question arises where you plan to
store permanent device data like size or sectorsize.
