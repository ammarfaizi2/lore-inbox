Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281337AbRKQV4P>; Sat, 17 Nov 2001 16:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281719AbRKQVzy>; Sat, 17 Nov 2001 16:55:54 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39924
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281337AbRKQVzt>; Sat, 17 Nov 2001 16:55:49 -0500
Date: Sat, 17 Nov 2001 13:55:42 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: File server FS?
Message-ID: <20011117135542.H21354@mikef-linux.matchmail.com>
Mail-Followup-To: Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Theodore Ts'o <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>,
	Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117181253.B5003@kushida.jlokier.co.uk>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 06:12:53PM +0000, Jamie Lokier wrote:
> Mike Fedyk wrote:
> > >  * Resizing - See last point
> > 
> > There are two utilities to resize ext2, which ext3 is except for an
> > additional file (journal) after umount.
> 
> Two questions:
> 
>   1. Does the size of the "appropriately sized journal (given the size
>      of the filesystem)" vary with filesystem size?

Journal size has more to do with activity when you are in data journaling
mode.  Otherwise you will be hard pressed to fill a 32MB journal with
meta-data.

> 
>   2. If so, does resize2fs change the journal size properly?
>

As long as resize2fs doesn't change the inode of the journal file you should
be fine.

> When I have resized ext3 filesystems, I have removed then recreated the
> journal manually because it wasn't clear from the documentation whether
> resize2fs does the appropriate thing.
> 

I haven't actually resized any ext2/3 partitions.  Didn't need to.  I'll do
some tests though.

Andrew, Andreas, any official comments?

Mike
