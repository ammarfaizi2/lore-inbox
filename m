Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268853AbRG0NpQ>; Fri, 27 Jul 2001 09:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268854AbRG0NpG>; Fri, 27 Jul 2001 09:45:06 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:5900 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S268853AbRG0Noy>; Fri, 27 Jul 2001 09:44:54 -0400
From: bvermeul@devel.blackstar.nl
Date: Fri, 27 Jul 2001 15:47:42 +0200 (CEST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hans Reiser <reiser@namesys.com>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Steve Kieu <haiquy@yahoo.com>,
        Sam Thompson <samuelt@cervantes.dabney.caltech.edu>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7q5-0005e9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0107271542331.10602-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Alan Cox wrote:

> > > Putting a sync just before the insmod when developing new drivers is a good
> > > idea btw
> >
> > I've been doing that most of the time. But I sometimes forget that.
> > But as I said, it's not something I expected from a journalled filesystem.
>
> You misunderstand journalling then

Yup, I guess I did.

> A journalling file system can offer different levels of guarantee. With
> metadata only journalling you don't take any real performance hit but your
> file system is always consistent on reboot (consistent as in fsck would pass
> it) but it makes no guarantee that data blocks got written.

I allways thought that it could/would roll back the changes that weren't
consistent. But I stand corrected. Thanks... :)

> Full data journalling will give you what you expect but at a performance hit
> for many applications.

Do any of the other journalled filesystems for linux do this? If not, I
guess I'll go back to ext2.

Bas Vermeulen

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

