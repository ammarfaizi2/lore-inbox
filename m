Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbRETAdP>; Sat, 19 May 2001 20:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261212AbRETAdF>; Sat, 19 May 2001 20:33:05 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:52741 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261247AbRETAdA>; Sat, 19 May 2001 20:33:00 -0400
Date: Sat, 19 May 2001 17:32:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Edgar Toernig <froese@gmx.de>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.GSO.4.21.0105192008290.7162-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105191728140.15174-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 19 May 2001, Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Edgar Toernig wrote:
> 
> > That assumption is totally bogus.  Even for regular files you have side
> > effects (atime); for anything else they're unpredictable.
> 
> That means only one thing: safe backups are possible only in single-user
> mode.

There are some strong arguments that we should have filesystem
"backdoors" for maintenance purposes, including backup. 

You can, of course, so parts of this on a LVM level, and doing backups
with "disk snapshots" may be a valid approach. However, even that is
debatable: there is very little that says that the disk image has to be
up-to-date at any particular point in time, so even with a disk snapshot
capability (which is not necessarily reasonable under all circumstances)
there are arguments for maintenance interfaces.

Thinks like "lazy fsck" (ie fsck while already running the filesystem) and
defragmentation simply is not feasible on a LVM level.

		Linus

