Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131133AbRBVFUX>; Thu, 22 Feb 2001 00:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbRBVFUN>; Thu, 22 Feb 2001 00:20:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26890 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131133AbRBVFT5>; Thu, 22 Feb 2001 00:19:57 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: 21 Feb 2001 21:19:45 -0800
Organization: Transmeta Corporation
Message-ID: <9727hh$1e7$1@penguin.transmeta.com>
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net> <3A947C54.E4750E74@transmeta.com> <3A948ACB.7B55BEAE@innominate.de> <97230a$16k$1@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <97230a$16k$1@penguin.transmeta.com>,
Linus Torvalds <torvalds@transmeta.com> wrote:
>
>Another way of saying this: if you go to the complexity of no longer
>being a purely block-based filesystem, please go the whole way. Make the
>thing be extent-based, and get away from the notion that you have to
>allocate blocks one at a time. Make the blocksize something nice and
>big, not just 4kB or 8kB or something.

Btw, this is also going to be a VM and performance issue some time in
the future.  Tgere are already CPU's that would _love_ to have 64kB
pages etc, and as such a filesystem that doesn't play with the old silly
"everthing is a block" rules would be much appreciated with the kind of
people who have multi-gigabyte files and want to read in big chunks at a
time. 

So either you have a simple block-based filesystem (current ext2, no
extents, no crapola), or you decide to do it over.  Don't do some
half-way thing, please. 

		Linus
