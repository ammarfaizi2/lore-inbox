Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130381AbRCETZT>; Mon, 5 Mar 2001 14:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRCETZJ>; Mon, 5 Mar 2001 14:25:09 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:23286 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130381AbRCETYt>; Mon, 5 Mar 2001 14:24:49 -0500
Message-ID: <3AA3E6D0.806D81B5@coplanar.net>
Date: Mon, 05 Mar 2001 14:19:44 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Padraig Brady <Padraig@AnteFacto.com>
CC: William Stearns <wstearns@pobox.com>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Hardlink utility - reclaim drive space
In-Reply-To: <Pine.LNX.4.30.0102191626090.29121-100000@sparrow.websense.net> <3AA3E63E.80101@AnteFacto.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady wrote:

> Hmm.. useful until you actually want to modify a linked file,
> but then your modifying the file in all "merged" trees.
> Wouldn't it be cool to have an extended attribute
> for files called "Copy on Write", so then you could
> hardlink all duplicate files together, but when a file is
> modified a copy is transparently created.
> Actually should it be called "Copy On Modify"? since if
> you copied a file there would be no need to make an actual
> copy until the file was modified.
>
> The only problem I see with this is that you wouldn't have
> enough space to store a copy of a file, what would you do
> in this case, just return an error on write?
>
> Is there any way this could be extended across filesystems?
> I suppose you could add it on top of existing DFS'?
>
> I could see many uses for this, like backup systems, but perhaps
> a block level system is more appropriate in this case?
> (like the just announced SnapFS).
>
> Is there any filesystem that supports this @ present?
>
> Padraig.
>
> William Stearns wrote:
>
> > Good day, all,
> >       Sorry for the offtopic post; I sincerely believe this will be
> > useful to developers with multiple copies of, say, the linux kernel tree
> > on their drives.  I'll be brief.  Please followup to private mail -
> > thanks.
> >       Freedups scans the directories you give it for identical files and
> > hardlinks them together to save drive space.  Please see
> > ftp://ftp.stearns.org/pub/freedups .  V0.2.1 is up there; it has received
> > some testing, but may yet contain bugs.
> >       I was able to recover ~676M by running it against 8 different
> > 2.4.x kernel trees with different patches that originally contained ~948M
> > of files.  YMMV.
> >       I do understand there are better ways to handle this problem (cp
> > -av --link, cvs? Bitkeeper, deleting unneeded trees, tarring up trees,
> > etc.).  See the readme for a little discussion on this.  This is just one
> > approach that may be useful in some situations.
> >       Cheers,
> >       - Bill

snapFS might handle this - versioning, copy-on-write disk file
clones... even finer grained: only modified blocks of a file are
duplicated, not the entire file, and it does this in real-time.

in the case of kernel, why not get the whole repository?
CVS stores versions as diffs internally, saving space.

