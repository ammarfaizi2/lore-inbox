Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262493AbSJIS4p>; Wed, 9 Oct 2002 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbSJIS4p>; Wed, 9 Oct 2002 14:56:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55502 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262493AbSJIS4o>;
	Wed, 9 Oct 2002 14:56:44 -0400
Date: Wed, 9 Oct 2002 15:02:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091138540.14464-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210091453160.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Linus Torvalds wrote:

> i
> On Wed, 9 Oct 2002, Alexander Viro wrote:
> > 
> > OK, call me dense, but what things are associated with partition aside of the
> > fact that it exists?
> 
> Filesystems can be associated with one or more partitions. MD devices are 
> associated with one or more partitions. 
> 

> Not disks. Partitions.

<groan>

Can you explain why "filesystem foo uses device bar" gives an object associated
with bar and "process baz has bar opened" doesn't?

"Associated with" is asymmetric in this case - just as for files and processes
holding them opened.  We do have objects for process->file (/proc/<pid>/fd/*)
and we certainly don't have anything like that for other direction.

That's what I'm asking about - do we want to have objects on the _partition_
side of things that would require per-partition directory?  Not on the
filesystem/swap/whatnot side...

