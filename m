Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282728AbRLBExh>; Sat, 1 Dec 2001 23:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282773AbRLBEx1>; Sat, 1 Dec 2001 23:53:27 -0500
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:19842
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S282772AbRLBExT>; Sat, 1 Dec 2001 23:53:19 -0500
Message-ID: <3C09B3FA.61777E84@ruault.com>
Date: Sat, 01 Dec 2001 20:54:18 -0800
From: Charles-Edouard Ruault <ce@ruault.com>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: stephane@tuxfinder.org
CC: Jeff Merkey <jmerkey@timpanogas.org>, J Sloan <jjs@pobox.com>,
        linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs> <20011202023145.A1628@emeraude.kwisatz.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The symlink problem you're reporting is exactly what i've been experiencing among
other things ...
on both systems i had multiple ext2 partitions and one reseirfs partition.
The problem showed up after a few days of uptime. Both machines where not heaviliy
loaded and had no memory shortage.
It looks like it also happened on my third system, which had only 2 ext2 partitions
. I was able to clean up this one with fsck and rebooted safely to 2.4.14 ....
Given the fact that i'm not the only one to see the problem with 2.4.16 i'll safely
backtrack all my machines to 2.4.14 ...
If i can be of any help to pinpoint the problem please let me know. But since i'm
not a kernel hacker i don't think i'll be pluging into the sources myself on my own
!
Thanks for the feedback !
Charles-Edouard Ruault

Stephane Jourdois wrote:

> On Sat, Dec 01, 2001 at 05:52:39PM -0700, Jeff Merkey wrote:
> > ----- Original Message ----- From: "J Sloan" <jjs@pobox.com>
> > > Just to be positive, can you reproduce the problem without nwfs?
> > Yes. The problem shows up on ext2 partitions only.
> I destroyed a  hard  disk  yesterday  with  2.4.16,  using  ext3.  A  heavy load
> (compiling The gimp and several other things)  and everything came bad, symlinks
> didn't work... (for exemple ln -s linux-2.4.17-pre2  linux did a link from linux
> to linux either using linux-2.4.17-pre2 and /usr/src/linux-2.4.17-pre2.
> > I see this lockup when I have more than  one file system mounted at a time. It
> > does not happen when only a single  volume (superblock) has been mounted, only
> > with multiples. Ditto the ext2 corruption. It only shows up when more than one
> > superblock is active.
> I had only one partition mounted at the moment (/dev/hda1 on / type ext3)
>
> Just in case : debian sid, gcc 2.95.4, everything up to date.
>
> We're living in a dangerous world, since 2.4.10...
>
> Ciao,
>
> --
>  ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
> (((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
>  \\\   6, av. de la Belle Image  X                         ///
>   \\\  94440 Marolles en Brie   / \    +33 6 8643 3085    ///

