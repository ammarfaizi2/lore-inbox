Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRJKLrX>; Thu, 11 Oct 2001 07:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276138AbRJKLrD>; Thu, 11 Oct 2001 07:47:03 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:30626
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S276135AbRJKLq5>; Thu, 11 Oct 2001 07:46:57 -0400
Date: Thu, 11 Oct 2001 07:47:03 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>, Benjamin LaHaise <bcrl@redhat.com>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>,
        Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
Message-ID: <1223310000.1002800823@tiny>
In-Reply-To: <Pine.GSO.4.21.0110110027370.21168-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110027370.21168-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, October 11, 2001 12:29:03 AM -0400 Alexander Viro <viro@math.psu.edu> wrote:
> On Thu, 11 Oct 2001, Benjamin LaHaise wrote:
> 
>> On Wed, Oct 10, 2001 at 09:48:41PM -0400, Chris Mason wrote:
>> > The bug where dump could corrupt things was when getblk and the
>> > block device both used the buffer cache.  That issue hasn't changed.
>> 
>> Let me emphasize this: 2.4.11+ will still exhibit filesystem corruption if 
>> the block device is accessed.  The only way to avoid this is to use raw io, 
> 
> What?  Details, please.  If you are talking about read access I would
> really like to know which filesystem it is.  ext2 used to have a bug
> in that area, but it had been fixed months ago.

Sorry, I wasn't very clear.  As far as I know, the specific ext2 bug
(race on up to date flag of newly allocated metadata) was found/fixed
by Al.  

The issues left are just dump getting inconsistent backups from
a rw mounted disk.  We'll have this bug regardless of page cache vs buffer
cache vs raw io in dump.

Now, what's interesting is the raw io dump + ext3 case.

-chris

