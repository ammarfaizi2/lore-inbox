Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278364AbRJMTGr>; Sat, 13 Oct 2001 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278366AbRJMTG3>; Sat, 13 Oct 2001 15:06:29 -0400
Received: from waste.org ([209.173.204.2]:7996 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S278364AbRJMTGS>;
	Sat, 13 Oct 2001 15:06:18 -0400
Date: Sat, 13 Oct 2001 14:09:32 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Corrupt ext2/ext3 directory entries not recovered by e2fsck 
In-Reply-To: <18096.1002985353@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.30.0110131407220.6512-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001, Keith Owens wrote:

> On Sat, 13 Oct 2001 16:06:35 +0200,
> Manfred Spraul <manfred@colorfullife.com> wrote:
> >> I forgot to mention that both fsck.ext2 and fsck.ext3 report
> >>
> >> 1: Entry 'sendmail.pid' in /var/run (686849) has
> >>		deleted/unused inode 688415.  CLEARED.
> >> /1: Entry 'crond.pid' in /var/run (686849) has
> >>		deleted/unused inode 688416.  CLEARED.
> >> /1: Entry 'xfs.pid' in /var/run (686849) has
> >>		deleted/unused inode 688417.  CLEARED.
> >> /1: Entry 'atd.pid' in /var/run (686849) has
> >>		deleted/unused inode 688418.  CLEARED.
> >>
> >All inodes are in the same sector.
> >Could you try out if that sector is destroyed?
>
> It should not matter which sector the inode is in, the directory entry
> should have been cleared, independent of the inode.  But I checked
> anyway, dd of the entire partition to /dev/null succeeded, no disk
> error messages anywhere in the logs at any time.

Is this your root partition perhaps? Fsck of a mounted device might act a
little differently with the new blockdev-in-pagecache approach.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

