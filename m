Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbRG0PCS>; Fri, 27 Jul 2001 11:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267317AbRG0PCM>; Fri, 27 Jul 2001 11:02:12 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:41484 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S267159AbRG0PCB>; Fri, 27 Jul 2001 11:02:01 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 17:04:48 +0200 (CEST)
To: Hans Reiser <reiser@namesys.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B617F34.FE1EE755@namesys.com>
Message-ID: <Pine.LNX.4.33.0107271653210.12396-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Hans Reiser wrote:

> we all have different usage patterns and different needs.  I find it
> extremely convenient to not be using ext2 when my dell laptop with its
> poor linux power management crashes frequently, or the kernel crashes.
> I have never had any problem with data corruption.  Many users I know
> have also had good experiences with leaving behind ext2 and going to
> reiserfs on their laptops.  For your needs and patterns though, it
> sounds like you need ext3.

The point is, this can happen every time the kernel crashes, and reiserfs
wrote something to it's metadata logs (or so I gather from your and Alan's
explanation). And apart from my source files getting randomly distributed,
reiserfs works like a charm (I have a Dell as well, and it used to crash a
lot, which was the main reason for me to switch to reiserfs in the first
place), is fast, and stable. I like it a lot, but not on a machine where I
do my development on, nor a machine without a UPS. It just doesn't help
not knowing if/when a file gets corrupted/wrongly distributed/written
back/whatever.

It looks to me (with all my ignorance) that reiserfs shuffles it's blocks
a lot when writing back, and that bites when something interrupts it.
I can't back that up with code, put my finger to it or anything else, but
that's my take on my problems.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

