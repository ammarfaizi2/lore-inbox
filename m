Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129323AbRBVEDI>; Wed, 21 Feb 2001 23:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbRBVEC5>; Wed, 21 Feb 2001 23:02:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:8200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129323AbRBVECw>; Wed, 21 Feb 2001 23:02:52 -0500
Message-ID: <3A948F54.EE00BC07@transmeta.com>
Date: Wed, 21 Feb 2001 20:02:28 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net> <3A947C54.E4750E74@transmeta.com> <3A948ACB.7B55BEAE@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> "H. Peter Anvin" wrote:
> >
> > Andreas Dilger wrote:
> > >
> > > Basically (IMHO) we will not really get any noticable benefit with 1 level
> > > index blocks for a 1k filesystem - my estimates at least are that the break
> > > even point is about 5k files.  We _should_ be OK with 780k files in a single
> > > directory for a while.
> > >
> >
> > I've had a news server with 2000000 files in one directory.  Such a
> > filesystem is likely to use small blocks, too, because each file is
> > generally small.
> >
> > This is an important connection: filesystems which have lots and lots of
> > small files will have large directories and small block sizes.
> 
> I mentioned this earlier but it's worth repeating: the desire to use a
> small block size is purely an artifact of the fact that ext2 has no
> handling for tail block fragmentation.  That's a temporary situation -
> once we've dealt with it your 2,000,000 file directory will be happier
> with 4K filesystem blocks.  There will be a lot fewer metadata index
> blocks in your directory file, for one thing.  Another practical matter
> is that 4K filesystem blocks map directly to 4K PAGE_SIZE and are as a
> result friendlier to the page cache and memory manager.
> 

Well, that's something I really don't expect to see anymore -- this
"purely temporary situation" is now already 7 years old at least.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
