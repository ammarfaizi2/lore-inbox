Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTF2Vgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTF2Vgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:36:46 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7040 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264271AbTF2Vgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:36:45 -0400
Date: Sun, 29 Jun 2003 22:59:34 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306292159.h5TLxYRY000376@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Both filesystems are the full size of the partition, and so is the
> >> datasystem.  The only difference is that before you start you have
> >> to make sure that the datasystem's gonna fit in with the free space
> >> on the first filesystem, and still have space to start the second
> >> filesystem, and then have space for its atoms.
> >
> >Just thought - that's going to be a problem in read-write mode :-/.
> >
> >If the disk fills up, we'd need to be able to maintain a consistant
> >filesystem structure, (at least good enough so that a separate
> >fsck-like utility could repair it - if the disk filled up, then the
> >conversion couldn't be done on-the-fly).
> >
>
>
> mmm.. hadn't thought of that.
>
> 1 second answer:  Lock down some of the freespace.  Do NOT let it
> get full.  You know how ext2 reserves 5% for the superuser?  Do that.
> Reserve enough freespace to keep working and finish the conversion.
> Predict from the beginning how much free space is going to be needed,
> and how much is going to be left over at the very final stages of the
> conversion.

That should work fine in most cases - it's not a problem to reserve
too much for the duration of the converstion, as it all gets freed
afterwards.  In most cases, we'd probably only need a relatively small
amount of space to allow writes whilst the conversion is in progress.

John.
