Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTF2TCR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTF2TCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:02:16 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21128 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261825AbTF2TCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:02:15 -0400
Date: Sun, 29 Jun 2003 20:16:27 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, mlmoser@comcast.net
Subject: Re: File System conversion -- ideas
Message-ID: <20030629191627.GA26258@mail.jlokier.co.uk>
References: <200306291613.h5TGDerX001001@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291613.h5TGDerX001001@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> > which is awfully difficult if you have, say, a 60GB filesystem, a 60GB
> > disk, and nothing else.
> 
> Well, I don't partition all of the space on every new disk I buy
> straight away, I partition off what I think I'll need, and leave the
> rest unallocated.

I used to do something like that.  It became awfully inconvenient, so I...

> > > that the only reason to do it would be if you
> > > could do it on a read-write filesystem without unmounting it.
> >
> > IMHO even if it requires the filesystem to be unmounted, it would
> > still be useful.  More challenging to use - you'd have to boot and run
> > from ramdisk, but much more useful than not being able to convert at all.
> 
> Only if it is the root filesystem, the filesystem of which generally
> isn't going to affect overall performance that much.

...now use a single "/" filesystem on most systems, with a tiny
"/boot" one to ensure booting.  With journalling, this risk of losing
data this way is much lower than it used to be, and the old reason for
using multiple partitions - to avoid having to fsck /usr - no longer applies.

> > But useless unless you have a second disk lying around that you don't
> > use for anything but filesystem conversions.
> 
> Not at all.  You can just use unpartitioned space on your existing
> disk.

So you have as much space unpartitioned on your disks as you are
actually using to store data?  I generally don't.

-- Jamie
