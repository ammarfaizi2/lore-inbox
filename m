Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTFGGwy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTFGGwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:52:54 -0400
Received: from mail010.syd.optusnet.com.au ([210.49.20.138]:63201 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262593AbTFGGwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:52:07 -0400
Date: Sat, 7 Jun 2003 17:04:03 +1000
To: Robert White <rwhite@casabyte.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFAT Defragmentation under Linux
Message-ID: <20030607070403.GA1540@cancer>
References: <PEEPIDHAKMCGHDBJLHKGOELGCOAA.rwhite@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGOELGCOAA.rwhite@casabyte.com>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 08:00:57PM -0700, Robert White wrote:
> Do the VFAT drivers likewise defragment the VFAT partitions?

Not that I'm aware of, and I'd argue that it's probably not
a good idea to try and do it inside the FS.

> If not, is there a Linux-hosted defragment program for defragmenting an
> unmounted VFAT partition?

The closest would probably be how programs such as GNU parted resize
partitions.

There are many optimizations that you could do to the average FAT/VFAT
filesystem. From making files contiguous, grouping files that are in
the same directory, ordering the directory lists etc.

Although one would have to question the usefulness of this kind of software these days. The number of new VFAT filesystems is getting smaller by the month (except on CF cards in cameras and the like - and they'd be re mkfs'd pretty often so wouldn't suffer too much from the performance degredation of continuous use).

I'd argue that testing/bug fixing ntfsresize would be of more use - especially in converting eXtra Poo users. :)

> So far the only Linux-level defragment operation that I seem to have
> available for a VFAT partition is to mount the drive, cpio everything off of
> it, delete its contents, and then copy everything back.  That's a little
> drastic and has obvious issues if you want to then boot that partition
> separately/later.

This would not do a 'complete' optimization... but probably would help.
