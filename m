Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbTF2PvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 11:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265692AbTF2PvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 11:51:04 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:10370 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265690AbTF2PvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 11:51:02 -0400
Date: Sun, 29 Jun 2003 17:13:40 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306291613.h5TGDerX001001@81-2-122-30.bradfords.org.uk>
To: jamie@shareable.org, john@grabjohn.com
Subject: Re: File System conversion -- ideas
Cc: linux-kernel@vger.kernel.org, mlmoser@comcast.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think
> > the performance of an on-the-fly filesystem conversion utility is
> > going to be so much worse than just creating a new partition and
> > copying the data across,
>
> which is awfully difficult if you have, say, a 60GB filesystem, a 60GB
> disk, and nothing else.

Well, I don't partition all of the space on every new disk I buy
straight away, I partition off what I think I'll need, and leave the
rest unallocated.

> > that the only reason to do it would be if you
> > could do it on a read-write filesystem without unmounting it.
>
> IMHO even if it requires the filesystem to be unmounted, it would
> still be useful.  More challenging to use - you'd have to boot and run
> from ramdisk, but much more useful than not being able to convert at all.

Only if it is the root filesystem, the filesystem of which generally
isn't going to affect overall performance that much.

> > What I'd like to see is union mounts which allowed you to mount a new
> > filesystem of a different type over the original one, and have all new
> > writes go to the new fileystem.  I.E. as files were modified, they
> > would be re-written to the new FS.  That would be one way of avoiding
> > the performance hit on a busy server.
>
> But useless unless you have a second disk lying around that you don't
> use for anything but filesystem conversions.

Not at all.  You can just use unpartitioned space on your existing
disk.

John.
