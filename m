Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280430AbRK1UzO>; Wed, 28 Nov 2001 15:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278120AbRK1UzF>; Wed, 28 Nov 2001 15:55:05 -0500
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:32646 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S280430AbRK1Uyv>; Wed, 28 Nov 2001 15:54:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Torrey Hoffman <torrey.hoffman@myrio.com>,
        "'Andrew Morton'" <akpm@zip.com.au>
Subject: Re: Unresponiveness of 2.4.16
Date: Wed, 28 Nov 2001 21:51:28 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CAE2@mail0.myrio.com>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CAE2@mail0.myrio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011128205501Z280430-17409+20355@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. November 2001 20:42 schrieb Torrey Hoffman:
> Yes, I just looked at the code in /fs/reiserfs/bitmap.c and
> the comment block above the warning message specifically mentions
> the low-latency patches.
>
> I feel better now, looks like my filesystem is safe...
>
> Torrey

So may I ask you to give 2.4.16 + preempt + lock-break (it is an additional 
one which do the same as Andrew's low-latency) a try?

Please run an MP3 or Ogg-Vorbis together with dbench. As you have a dual PIII 
I am very interested. I will buy a dual Athlon XP/MP, soon.

Thanks,
	Dieter

> Andrew Morton wrote:
> [...]
>
> > > fall over, and during the run I got the following error/
> > > warning message printed about 20 times on the console
> > > and in the kernel log:
> > >
> > > vs-4150: reiserfs_new_blocknrs, block not free<4>
> >
> > uh-oh.  I probably broke reiserfs in the low-latency patch.
> >
> > It's fairly harmless - we drop the big kernel lock, schedule
> > away.  Upon resumption, the block we had decided to allocate
> > has been allocated by someone else.  The filesystem emits a
> > warning and goes off to find a different block.
> >
> > Will fix.

