Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRIAG3l>; Sat, 1 Sep 2001 02:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRIAG3c>; Sat, 1 Sep 2001 02:29:32 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:32779 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S270132AbRIAG3X>; Sat, 1 Sep 2001 02:29:23 -0400
Date: Sat, 1 Sep 2001 07:29:40 +0100 (BST)
From: <mb/ext3@dcs.qmul.ac.uk>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>, <ext3-users@redhat.com>
Subject: Re: ext3 oops under moderate load
In-Reply-To: <3B904AC4.6A449086@zip.com.au>
Message-ID: <Pine.LNX.4.33.0109010724110.19444-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 31 Andrew Morton wrote:

>> kernel BUG at revoke.c:307!
>
>Yours is the third report of this - it's definitely a bug in
>ext3.  I still need to work out how you managed to get a page
>attached to the inode which has not had its buffers fed through
>journal_dirty_data().  There seem to be several ways in which
>this can happen.
>
>Is it possible that you ran out of disk space on the relevant
>partition shortly before it died?

I think I can safely rule that one out :)

alan:~$ df /export
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/ataraid/d0p1    240196512  29362544 210833968  13% /export

..that's about as full as it's got, well it may have got up to 50GB used.
[NB for now I've switched the partition to reiserfs (didn't fancy the
fsck), but I'll have a very similar box to play with soon.]

