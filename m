Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136497AbREDUJi>; Fri, 4 May 2001 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136499AbREDUJ2>; Fri, 4 May 2001 16:09:28 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:45318
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136497AbREDUJP>; Fri, 4 May 2001 16:09:15 -0400
Date: Fri, 04 May 2001 16:08:22 -0400
From: Chris Mason <mason@suse.com>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Maximum files per Directory
Message-ID: <392230000.989006902@tiny>
In-Reply-To: <200105041915.f44JFNeM024068@webber.adilger.int>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, May 04, 2001 01:15:22 PM -0600 Andreas Dilger
<adilger@turbolinux.com> wrote:

> Chris writes:
>> On Tuesday, May 01, 2001 04:57:02 PM -0600 Andreas Dilger
>> <adilger@turbolinux.com> wrote:
>> > I see that reiserfs plays some tricks with the directory i_nlink count.
>> > If you exceed 64536 links in a directory, it reverts to "1" and no
>> > longer tracks the link count.
>> 
>> Correct.  The link count isn't used at all when deciding if the directory
>> is empty (we use the size instead), so we can just lie to VFS if someone
>> tries to make tons of subdirs.
> 
> For that matter, ext2 doesn't use the link count on directories to
> determine if they are empty either, so it shouldn't be too hard to do the
> same with the ext2 indexed-directory code.  Is there a reason that
> reiserfs chose to have "large number of directories" represented by "1"
> and not "LINK_MAX+1"?
> 

find and a few others consider a link count of 1 to mean there is no link
count tracking being done.

-chris

