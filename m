Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVFVFhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVFVFhr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVFVFgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:36:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:15019 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262748AbVFVFTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:19:09 -0400
Message-ID: <42B8F4BC.5060100@pobox.com>
Date: Wed, 22 Jun 2005 01:18:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com>
In-Reply-To: <42B8E834.5030809@slaphack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:
> There's been sloppy code in the kernel before.  I remember one bit in
> particular which was commented "Fuck me gently with a chainsaw."  If I
> remember correctly, this had all of the PCI ids and the names and
> manufacturers of the corresponding devices -- in a data structure -- in
> C source code.  It was something like one massive array definition, or
> maybe it was a structure.  I don't remember exactly, but...
> 
> The point is, this was in the kernel for quite awhile, and it was so
> ugly that someone would rather be fucked with a chainsaw.  If something
> that bad can make it in the kernel and stay for awhile because it
> worked, and no one wanted to replace it -- nowdays, that database is
> kept in userland as some nice text format -- then I vote for putting
> Reiser4 in the kernel now, and ironing the sloppiness ("violation") out
> later.  It runs now.

Existence of ugly code is not an excuse to add more.

We have to maintain said ugly code for decades.  Maintainability is a 
big deal when you deal with the timeframes we deal with.


> So, Reiser4 may eventually take over VFS and be the only Linux
> filesystem, but if so, it will have to do it much more slowly.  Take the
> good ideas -- things like plugins -- and make them at least look like
> incremental updates to the current VFS, and make them available to all
> filesystems.

This is how all Linux development is done.

The code evolves over time.

You have just described the path ReiserFS needs to take, in order to get 
this stuff into the kernel, in fact.


> And here is the crucial point.  Reiser4 is usable and useful NOW, not
> after it has undergone massive surgery, and Namesys is bankrupt, and
> users have given up and moved on to XFS.  But the massive surgery should
> happen eventually, partly to make all filesystems better (see below),
> and partly to make the transition easier and more palatable for those
> who don't work for Namesys.

We care about technical merit, not some random company's financial 
solvancy.  Reiser4 has layering violations, and doesn't work with the 
current security layer.  Those are two biggies.

There is no entitlement to be merged in the upstream kernel.  If people 
don't like how the Linux kernel is managed, they are free to maintain 
their own fork.  If its better, people will use that instead.


> I would imagine that it wouldn't be too long after this before an
> uber-fs rose, something which combined enough of the strong points of
> all the existing Linux filesystems that no one would use anything else.
>  But, Linux still needs support for FAT32, ISO9660, UDF, and all the
> other filesystems which won't go away as easily as XFS and ext3, and it
> would be nice if these could all share as much code as possible.
> 
> 
> I don't know if storage plugins really work that way, but they should.

No, they shouldn't.


> I think.  I don't work here.

Obviously.

	Jeff


