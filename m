Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbREOQCw>; Tue, 15 May 2001 12:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbREOQCm>; Tue, 15 May 2001 12:02:42 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:54285
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S261309AbREOQC3>; Tue, 15 May 2001 12:02:29 -0400
Date: Tue, 15 May 2001 12:00:43 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Chris Wedgwood <cw@f00f.org>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <1087040000.989942443@tiny>
In-Reply-To: <Pine.GSO.4.21.0105150424310.19333-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, May 15, 2001 04:33:57 AM -0400 Alexander Viro
<viro@math.psu.edu> wrote:

> 
> 
> On Tue, 15 May 2001, Linus Torvalds wrote:
> 
>> Looks like there are 19 filesystems that use the buffer cache right now:
>> 
>> 	grep -l bread fs/*/*.c | cut -d/ -f2 | sort -u | wc
>> 
>> So quite a bit of work involved.
> 
> Reiserfs... Dunno. They've got a private (slightly mutated) copy of
> ~60% of fs/buffer.c. 

But, putting the log and the metadata in the page cache makes memory
pressure and such cleaner, so this is one of my goals for 2.5.  reiserfs
will still have alias issues due to the packed tails (one copy in the
btree, another in the page), but it will be no worse than it is now.

-chris

