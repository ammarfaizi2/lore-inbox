Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRCETR7>; Mon, 5 Mar 2001 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130333AbRCETRt>; Mon, 5 Mar 2001 14:17:49 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:41732 "EHLO
	nt1.antefacto.com") by vger.kernel.org with ESMTP
	id <S130329AbRCETRi>; Mon, 5 Mar 2001 14:17:38 -0500
Message-ID: <3AA3E63E.80101@AnteFacto.com>
Date: Mon, 05 Mar 2001 19:17:18 +0000
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: William Stearns <wstearns@pobox.com>
CC: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Hardlink utility - reclaim drive space
In-Reply-To: <Pine.LNX.4.30.0102191626090.29121-100000@sparrow.websense.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.. useful until you actually want to modify a linked file,
but then your modifying the file in all "merged" trees.
Wouldn't it be cool to have an extended attribute
for files called "Copy on Write", so then you could
hardlink all duplicate files together, but when a file is
modified a copy is transparently created.
Actually should it be called "Copy On Modify"? since if
you copied a file there would be no need to make an actual
copy until the file was modified.

The only problem I see with this is that you wouldn't have
enough space to store a copy of a file, what would you do
in this case, just return an error on write?

Is there any way this could be extended across filesystems?
I suppose you could add it on top of existing DFS'?

I could see many uses for this, like backup systems, but perhaps
a block level system is more appropriate in this case?
(like the just announced SnapFS).

Is there any filesystem that supports this @ present?

Padraig.

William Stearns wrote:

> Good day, all,
> 	Sorry for the offtopic post; I sincerely believe this will be
> useful to developers with multiple copies of, say, the linux kernel tree
> on their drives.  I'll be brief.  Please followup to private mail -
> thanks.
> 	Freedups scans the directories you give it for identical files and
> hardlinks them together to save drive space.  Please see
> ftp://ftp.stearns.org/pub/freedups .  V0.2.1 is up there; it has received
> some testing, but may yet contain bugs.
> 	I was able to recover ~676M by running it against 8 different
> 2.4.x kernel trees with different patches that originally contained ~948M
> of files.  YMMV.
> 	I do understand there are better ways to handle this problem (cp
> -av --link, cvs? Bitkeeper, deleting unneeded trees, tarring up trees,
> etc.).  See the readme for a little discussion on this.  This is just one
> approach that may be useful in some situations.
> 	Cheers,
> 	- Bill

