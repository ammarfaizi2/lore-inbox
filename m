Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143372AbREKUBp>; Fri, 11 May 2001 16:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143380AbREKUBL>; Fri, 11 May 2001 16:01:11 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:21001
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S143372AbREKT6Z>; Fri, 11 May 2001 15:58:25 -0400
Date: Fri, 11 May 2001 15:17:14 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: reiserfs, xfs, ext2, ext3
Message-ID: <248420000.989608634@tiny>
In-Reply-To: <3AFC385C.CE9BD596@namesys.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, May 11, 2001 12:07:08 PM -0700 Hans Reiser <reiser@namesys.com>
wrote:

> "Albert D. Cahalan" wrote:
> 
>> Hans Reiser writes:
>> 
>> > Tell us what to code for, and so long as it doesn't involve looking
>> > up files by their 32 bit inode numbers we'll probably be happy to
>> > code to it.  The Neil Brown stuff is already coded for though.
>> 
>> Next time around, when you update the on-disk format, how about
>> allowing for such a thing?
>> 
>> You could have a tree that maps from inode number to whatever
>> you need to find a file. This shouldn't affect much more than
>> file creation and deletion. Maybe it will allow for a more
>> robust fsck as well, helping to justify the cost.
>> 
>> It would be really nice to be able to find all filenames that
>> refer to a given inode number.
> 
> It would have a significant performance impact and use disk space.

inode numbers have in the past been enough to find the object in the
filesystem, and more than a few applications have counted on this.  In my
mind, the difference between an interesting research project and a real
professional grade product is compatibility with these kinds of traditional
expectations.

I think reiserfs has been lucky that we've managed to work around the inode
number problem so far (with help from Neil, Andi and others), but the
number of hours wasted on cramming the 64bit key into various applications
has been huge.

It only makes a speed difference because the original format relies on it.
When redoing the format for v4, this kind of thing should at least be
considered. </soapbox>

-chris

