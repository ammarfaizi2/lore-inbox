Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSGVNHc>; Mon, 22 Jul 2002 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSGVNHb>; Mon, 22 Jul 2002 09:07:31 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:6798 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316880AbSGVNHa>; Mon, 22 Jul 2002 09:07:30 -0400
Date: Mon, 22 Jul 2002 08:10:25 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200207221310.IAA10575@tomcat.admin.navo.hpc.mil>
To: georgn@somanetworks.com, yodaiken@fsmlabs.com
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
In-Reply-To: <1027174927.1702.11.camel@keller>
Cc: Larry McVoy <lm@work.bitmover.com>, Rob Landley <landley@trommello.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> --=-JpG6tr/3TXNgZxkgIDvS
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> On Fri, 2002-07-19 at 10:20, yodaiken@fsmlabs.com wrote:
> > On Thu, Jul 18, 2002 at 09:38:57PM -0700, Larry McVoy wrote:
> > > On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote:
> > > > I've been sitting on this question for years, hoping I'd come across =
> the=20
> > > > answer, and I STILL don't know what the "i" is short for.  Somebody h=
> ere has=20
> > > > got to know this. :)
> > >=20
> > > Incore node, I believe.  In the original Unix code there was dinode and
> > > inode if I remember correctly, for disk node and incore node.
> >=20
> > So what was that program that was used to fix file system errors called? =
> Started
> > with a "d". I remembered the name up until a few years ago when I said
> > something about fixing filesystems with whatever it was and adb in front =
> of Dave Miller
> > who seemed ready to rush me off to the museum to be exhibited in the pale=
> ology section.
> > Now I'm too old to even remember the name.
> 
> Sure you're not thinking of "fsdb"?

No - this was done before fsck - though fsdb did exist - for manual
interaction with the disk structure on a block by block basis.

I believe he is referring to

dcheck - which did directory traversals looking for lost files

Associated with this is:

ncheck - which checked the structure of each file.

The functions of fsck were combined from these two utilities (and added
some more) when bitmap allocation was being added to the file system.

Previous to this, all documentation I've seen for disk structure used a
"free list" chain of unused blocks, where deleted files were put. The
disk free list was used in a LIFO structure to minimise fragmentation, and
preserve the largest free disk segment for new file allocations.

You have to go back to UNIX release 6 or 7 for the last real uses of these
commands before fsck. They did exist in UNIX System V release 2, but only
as "depreciated" utilities not to be used anymore. They did work, but were
superceeded, and did not exist in the next release as I understand. (I had
release 1/2 but did not get 3).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
