Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUAERI6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 12:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbUAERI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 12:08:58 -0500
Received: from cibs9.sns.it ([192.167.206.29]:62993 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S265178AbUAERIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 12:08:16 -0500
Date: Mon, 5 Jan 2004 18:08:09 +0100 (CET)
From: venom@sns.it
To: Hans Reiser <reiser@namesys.com>
cc: Steve Glines <sglines@is-cs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: file system technical comparisons
In-Reply-To: <3FF944DA.4070405@namesys.com>
Message-ID: <Pine.LNX.4.43.0401051759210.3505-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I already gave a look to reiser4, but I have some difficoultis with dancing
tree structure.

But definitelly I was waiting for an extent based FS
as we talked about this more than one year and a half ago,
when you described me
your plans for reiser in an interview on Linux&C.

Now, will have to find some time to set up a test, possibly on a 64 bit CPU.

bests

Luigi



On Mon, 5 Jan 2004, Hans Reiser wrote:

> Date: Mon, 05 Jan 2004 14:04:58 +0300
> From: Hans Reiser <reiser@namesys.com>
> To: venom@sns.it
> Cc: Steve Glines <sglines@is-cs.com>, linux-kernel@vger.kernel.org
> Subject: Re: file system technical comparisons
>
> You can read www.namesys.com for a description of reiser4, and
> www.namesys.com/benchmarks.html for some benchmarks.
>
> There are no well done independent benchmarks unfortunately.
>
> Of my competitors, and not considering ReiserFS (about which I am not
> objective), I would say that if you don't have really large files and
> don't have any large directories, ext3 offers the best performance.
>
> If you have large streaming files, look at XFS.   Don't use XFS for
> files smaller than 100k, as the last time I tested against it its
> metadata updates tended to be slow, and that starts to matter at <100k
> file sizes.
>
> JFS has never done very well in the benchmarks I run, which is why I
> tend to compare us mostly to ext3.
>
> If you are willing to consider ReiserFS, V3 is the journaling filesystem
> that has been out for the longest, and receives the least updates (we
> are all working on V4), so it is the most stable.  I'll let others
> comment on its performance.
>
> V4 is far higher performance than V3, but not quite fully stable yet.
> Some brave people are using it though.  Hopefully we will ship something
> stable this month.
>
> Hans
>
> venom@sns.it wrote:
>
> >http://www.linux-mag.com/2002-10/jfs_01.html
> >
> >On some point it could be discussed, but it is a good starting point.
> >
> >if you know italian, I will send you another article published in three part
> >on Linux&C (http://www.oltrelinux.com) about journaled filesystems available in
> >Linux kernel.
> >
> >bests
> >
> >Luigi
> >
> >On Fri, 2 Jan 2004, Steve Glines wrote:
> >
> >
> >
> >>Date: Fri, 02 Jan 2004 16:38:22 -0500
> >>From: Steve Glines <sglines@is-cs.com>
> >>To: linux-kernel@vger.kernel.org
> >>Subject: file system technical comparisons
> >>
> >>I'm looking for a technical comparison between the major file systems.
> >>At a minimum I'd like to see a comparison between ext3, reiserfs, xfs
> >>and jfs. In the oh so perfect world I'd like to see detailed info on all
> >>supported file systems.
> >>
> >>Please CC or mail me directly as I am not a subscriber to this list.
> >>
> >>Thanks
> >>--
> >>Steve Glines
> >>
> >>In theory, there's no difference between theory and practice, but in
> >>practice there is.
> >>
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> >
>
>
> --
> Hans
>
>

