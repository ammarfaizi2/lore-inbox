Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131311AbRCHLKV>; Thu, 8 Mar 2001 06:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131318AbRCHLKL>; Thu, 8 Mar 2001 06:10:11 -0500
Received: from zeus.kernel.org ([209.10.41.242]:232 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131311AbRCHLKB>;
	Thu, 8 Mar 2001 06:10:01 -0500
Date: Thu, 8 Mar 2001 11:06:20 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeremy Hansen <jeremy@xxedgexx.com>, Mike Black <mblack@csihq.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010308110620.A14121@redhat.com>
In-Reply-To: <Pine.LNX.4.33L2.0103071302140.30803-100000@srv2.ecropolis.com> <Pine.LNX.4.10.10103071034210.2784-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103071034210.2784-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Mar 07, 2001 at 10:36:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 07, 2001 at 10:36:38AM -0800, Linus Torvalds wrote:
> On Wed, 7 Mar 2001, Jeremy Hansen wrote:
> > 
> > So in the meantime as this gets worked out on a lower level, we've decided
> > to take the fsync() out of berkeley db for mysql transaction logs and
> > mount the filesystem -o sync.
> > 
> > Can anyone perhaps tell me why this may be a bad idea?
> 
>  - it doesn't help. The disk will _still_ do write buffering. It's the
>    DISK, not the OS. It doesn't matter what you do.
>  - your performance will suck.

Added to which, "-o sync" only enables sync metadata updates.  It
still doesn't force an fsync on data writes.

--Stephen
