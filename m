Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144660AbRBWUlp>; Fri, 23 Feb 2001 15:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBWULy>; Fri, 23 Feb 2001 15:11:54 -0500
Received: from mail.valinux.com ([198.186.202.175]:42765 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129379AbRBWULs>;
	Fri, 23 Feb 2001 15:11:48 -0500
To: phillips@innominate.de
CC: adilger@turbolinux.com, Linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
In-Reply-To: <3A959AE2.6BAFF36E@innominate.de> (message from Daniel Phillips
	on Fri, 23 Feb 2001 00:04:02 +0100)
Subject: Re: [Ext2-devel] [rfc] Near-constant time directory index for Ext2
From: tytso@valinux.com
Phone: (781) 391-3464
In-Reply-To: <E14VvfG-00035D-00@beefcake.hdqt.valinux.com> <200102221816.f1MIGWt04170@webber.adilger.net> <3A959AE2.6BAFF36E@innominate.de>
Message-Id: <E14WOZ2-0006sK-00@beefcake.hdqt.valinux.com>
Date: Fri, 23 Feb 2001 12:11:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@innominate.de>
   Date: Fri, 23 Feb 2001 00:04:02 +0100

   I resolve not to take a position on this subject, and I will carry
   forward both a 'squeaky clean' backward-compatible version that sets an
   INCOMPAT flag, and a 'slightly tarnished' but very clever version that
   is both forward and backward-compatible, along the lines suggested by
   Ted.  Both flavors have the desireable property that old versions of
   fsck with no knowledge of the new index structure can remove the indices
   automatically, with fsck -y.

Note that in the long run, the fully comatible version should probably
have a COMPAT feature flag set so that you're forced to use a new enough
version of e2fsck.  Otherwise an old e2fsck may end up not noticing
corruptions in an index block which might cause a new kernel to have
serious heartburn.

						- Ted
