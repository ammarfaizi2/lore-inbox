Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAICjU>; Mon, 8 Jan 2001 21:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAICjK>; Mon, 8 Jan 2001 21:39:10 -0500
Received: from 209.102.21.2 ([209.102.21.2]:52490 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129226AbRAICjF>;
	Mon, 8 Jan 2001 21:39:05 -0500
Message-ID: <3A5A4958.CE11C79B@goingware.com>
Date: Mon, 08 Jan 2001 23:12:24 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding notification when there's a change to the filesystem:

This is one of the most significant things about the BeOS BFS filesystem, and
something I'd dearly love to see Linux adopt.  It makes an app very efficient,
you just get notified when a directory changes and you never waste time polling.

I think it would require changes to the VFS layer, not just to the filesystems,
because this is a concept POSIX filesystems do not presently possess.

The other is indexed filesystem attributes, for example a file can have its
mimetype in the filesystem, and any application can add an attribute and have it
indexed.

There's a method to do boolean queries on indexed attributes, and you can find
files in an entire filesystem that match a query in a blazingly short time, much
faster than walking the directory tree.

If you want to try out the BeOS, there's a free-as-in-beer version at
http://free.be.com for Pentium PC's.  You can also purchase a version that comes
for both PC's and certain PowerPC macs.

There are read-only versions of this for Linux which I believe are under the
GPL.  The original author is here:

http://hp.vector.co.jp/authors/VA008030/bfs/

He refers you to here to get a version that works under 2.2.16:

http://milosch.net/beos/

The author's intention was to take it read-write, but it's complex because it is
a journaling filesystem.

Daniel Berlin, a BeOS developer modified the Linux BFS driver so it works with
2.4.0-test1.  I don't know if it works with 2.4.0.  The web site where it used
to be posted isn't there anymore, and the laptop where I had it is in for
repair.  I may have it on a backup, and I'll see if I can track Daniel down.

While Be, Inc.'s implementation is closed-source, the design of the BFS (_not_
"befs" as it is sometimes called) is explained in Practical File System Design
with the Be File System by Dominic Giampolo, ISBN 1-55860-497-9.  Dominic has
since left Be and I understand works at Google now.


-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
