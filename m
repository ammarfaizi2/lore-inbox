Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265084AbRFUST4>; Thu, 21 Jun 2001 14:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbRFUSTq>; Thu, 21 Jun 2001 14:19:46 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:44271 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S265084AbRFUSTb>; Thu, 21 Jun 2001 14:19:31 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200106211819.f5LIJGqP015476@webber.adilger.int>
Subject: Re: Loop encryption module locking bug (linux-2.4.5).
In-Reply-To: <20010621135043.A13107@lxmayr6.informatik.tu-muenchen.de>
 "from Ingo Rohloff at Jun 21, 2001 01:50:43 pm"
To: Ingo Rohloff <rohloff@in.tum.de>
Date: Thu, 21 Jun 2001 12:19:16 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Rohloff writes:
> PS: Because I try to understand the inner workings of the loop
>     device better, I have a question:
>     In lo_send is a loop: "while (len>0)". How can I configure
>     a loop device, so that this loop is executed more than once.
>     It seems this is only possible if "bh->b_size" is greater
>     than PAGE_CACHE_SIZE. Does this mean, you have to work on
>     a filesystem which uses blocks of a size > PAGE_CACHE_SIZE,
>     or is bh->b_size a fixed value (which is always less than
>     PAGE_CACHE_SIZE) ?

Currently, filesystems must have block size <= PAGE_CACHE_SIZE.
This may not be true in the future, so it is likely that the loop
code is "forward looking" to try to still work if the block size
can exceed the PAGE_CACHE_SIZE.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
