Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbRG1QRd>; Sat, 28 Jul 2001 12:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266906AbRG1QRO>; Sat, 28 Jul 2001 12:17:14 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:4110 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266888AbRG1QRE>; Sat, 28 Jul 2001 12:17:04 -0400
Message-ID: <3B62E519.408D88B0@namesys.com>
Date: Sat, 28 Jul 2001 20:15:21 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <3B6180CD.9D68CC07@namesys.com> <01072901450000.02683@kiwiunixman.nodomain.nowhere>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Matthew Gardiner wrote:
> 
> On Saturday 28 July 2001 02:55, Hans Reiser wrote:
> > Joshua Schmidlkofer wrote:
> > > I've almost quit using reiser, because everytime I have a power outage,
> > > the last 2 or three files that I've editted, even ones that I haven't
> > > touched in a while, will usually be hopelessly corrupted.  The '<file>~'
> > > that Emacs makes is usually fine though.   It seems to be that any open
> > > file is in danger.  I don't know if this is normal, or not, but I
> > > switched to XFS on several machines.  I have nothing against reiser.  I
> > > assumed that these problems were due to immaturity....
> > >
> > >    One more thing - All my computers with Reiser as '/'  on them had a
> > > disturbingly long boot time.   From the time when the Redhat startup
> > > scripts began, it was.... hideously slow.   I thought nothing of it,
> > > blaming bash,
> >
> > Don't use RedHat with ReiserFS, they screw things up so many ways.....
> >
> > For instance, they compile it with the wrong options set, their boot
> > scripts are wrong, they just shovel software onto the CD.
> >
> > Use SuSE, and trust me, ReiserFS will boot faster than ext2.
> >
> > Actually, I am curious as to exactly how they manage to make ReiserFS boot
> > longer than ext2.  Do they run fsck or what?
> >
> > Hans
> 
> Regards to the ReiserFS. Something more spookie, OpenLinux (no boos and
> hisses please ;) ), they have ReiserFS as a module, yet, when I have the root
> partition as reiser I have no problems, voo doo magic perhaps? because when I
> compiled 2.4.7 w/ ReiserFS as a module, the boot forks up.

Perhaps there is a problem in which the reiserfs module does not get loaded
before you need to read the root partition?

If you isolate the problem to where you think it is a reiserfs bug, please let
me know.  It sounds like not.


> 
> Also, to speed it up, I have heard a urban myth (I am not too sure whether it
> is true), you add the tag notail. A little more disk space is used, however,
> apparently, it is meant to speed up access.

This is entirely correct.  Moving tails around costs performance, ReiserFS
cannot give you something for nothing in this respect.

Hans
