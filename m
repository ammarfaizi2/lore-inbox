Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSJDFV2>; Fri, 4 Oct 2002 01:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJDFV2>; Fri, 4 Oct 2002 01:21:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:43907 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261457AbSJDFV1>;
	Fri, 4 Oct 2002 01:21:27 -0400
Date: Thu, 3 Oct 2002 22:26:21 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Scott Bronson <bronson@rinspin.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: FAT/VFAT and the sync flag
In-Reply-To: <1033707085.6359.113.camel@emma>
Message-ID: <Pine.LNX.4.33L2.0210032215020.18964-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Oct 2002, Scott Bronson wrote:

| Can anyone tell me if the VFAT filesystem actually recognizes the sync
| flag?  Early in 2.4, it appeared that it was ignoring it.
|
| However, now that a lot of USB devices are VFAT, this gets pretty
| important.
| -

USB devices (mostly) don't care what filesystem is on them.
I have used ext2 on USB floppies and USB Zip.
You should be able to put any supported filesystem on them.
The only case I know of that matters is MP3 players, which
do expect/require a VFAT filesystem (it's usually all they know),
so media that is used in MP3 players should be VFAT probably. :)

Now, for you first question, I hope that Ogawa or Al or Christoph
et al can answer it, but my guess is, No, VFAT doesn't
recognize the sync flag.  I base that on grepping for
s_sync and for MS_SYNCHRONOUS in linux/fs/{fat,vfat,msdos}
and finding s_sync a few times, but not finding MS_SYNCHRONOUS
at all.

'man mount' says that the sync flag is only honored by
ext2, ext3, and ufs.
I see it checked/used in ext2, ufs, and ntfs.

-- 
~Randy

