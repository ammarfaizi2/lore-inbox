Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313462AbSC2PsP>; Fri, 29 Mar 2002 10:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313463AbSC2PsG>; Fri, 29 Mar 2002 10:48:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27152 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313462AbSC2Pr6>; Fri, 29 Mar 2002 10:47:58 -0500
Date: Fri, 29 Mar 2002 10:45:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA3B48F.25F9042D@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020329104016.22866B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Andrew Morton wrote:

> BTW, ext3 keeps a kdev_t on-disk for external journals.  The
> external journal support is experimental, added to allow people
> to evaluate the usefulness of external journalling.  If we
> decide to retain the capability we'll be moving it to a UUID
> or mount-based scheme.  So if the kdev_t is being a problem,
> I think we can just break it.

  If experience on JFS is any predictor, the external journal will be
quite useful as a performance issue. It can be put on a faster device to
avoid bottlenecks. With JFS I finally wound up with the journal on a
battery-backed SCSI solid state disk, and got about 30% faster completion
of my daily audit run which deleted ~1000000 (yes one million) files as
fast as it could when done.

  I was also creating the same number of files over the course of a day,
which is still a respectable directory change rate!

  I predict that applications which create/delete a lot of files will run
better with tuning this feature.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

