Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315614AbSENLgj>; Tue, 14 May 2002 07:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315617AbSENLgj>; Tue, 14 May 2002 07:36:39 -0400
Received: from dsl-213-023-062-041.arcor-ip.net ([213.23.62.41]:34322 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S315614AbSENLgh>;
	Tue, 14 May 2002 07:36:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmx.net>
To: Neil Conway <nconway.list@ukaea.org.uk>, reality@delusion.de,
        linux-kernel@vger.kernel.org
Subject: Re: Ext3 errors with 2.4.18
Date: Tue, 14 May 2002 13:37:58 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <3CE0EDF6.621AB9D0@ukaea.org.uk>
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205141337.58202.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 May 2002 12:59, Neil Conway wrote:
> Your errors are just like the ones I experienced due to an IDE bug.

It's a slightly older P3B-F board with Intel IDE. It's not my system, but it 
has been running fine as long as I can remember.

>
> Are you:
> a) using a hard-disk on the same cable as a CD/DVD

The IDE disk layout is:

IDE pri: HD + HD
IDE sec: CD + HD

The RAID is constructed from IDE primary master + secondary slave. (40 + 30 GB 
disks)

>
> b) seeing any "hdX: status error: status=0x58 {DriveReady SeekComplete
> DataRequest}" errors in your log
>
> c) seeing (b) in close proximity to ATAPI module init messages like:
> "hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)"
>
> ?
>
> If yes to all/most of the above, you may be suffering from the same
> bug.

b) and c) are no, no.

>  If not, your inodes in RAM are probably being trashed by a
> different bug :-))

Hm, wherever. ;)  The problem manifested itself right after a reboot. Postfix 
complained at boot about dirs in spool/postfix not owned by postfix and at 
some point the fs was remounted ro. I dunno where to look, maybe it's indeed 
MD RAID + ext3 like Andreas pointed out?

Bye,
Oliver

-- 
Oliver Feiler  <kiza@(gmx.net|lionking.org|claws-and-paws.com|spot.dtip.de)> /
http://www.lionking.org/~kiza/      (http://spot.dtip.de/)                  /
___________________________________________________________________________/
