Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279986AbRKNByP>; Tue, 13 Nov 2001 20:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279988AbRKNByG>; Tue, 13 Nov 2001 20:54:06 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14074
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279986AbRKNBxy>; Tue, 13 Nov 2001 20:53:54 -0500
Date: Tue, 13 Nov 2001 17:53:48 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Brian <hiryuu@envisiongames.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File server FS?
Message-ID: <20011113175348.B24864@mikef-linux.matchmail.com>
Mail-Followup-To: Brian <hiryuu@envisiongames.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 05:03:34PM -0500, Brian wrote:
> We are about to build a fairly large (720GB) file server using Linux.  No 
> sane person would actually want to watch this thing fsck, but I've seen 
> mixed reports about the functionality of the journaled FSes.
>

Ext3!

> Specifically, I need support for
>  * KNFSD - it is a file server, afterall

Yep

>  * LVM - For snapshots and to add space later

Yep

>  * Resizing - See last point

There are two utilities to resize ext2, which ext3 is except for an
additional file (journal) after umount.

>  * Quotas - Eventually, but we don't need it just yet
>

A little tricky in Linus' kernel.  Should be sorted out soon.

> Which, if any, of the journaled FSes support these?
> Which one should I go with for a wide range of file and directory sizes?
>

How many files in a single dir?  Reiser is great for that, but not so good
for fragmentation after time on a 70% full or more FS...

There is indexing in development for ext2/3, but that'll be 2.5 work.

Mike
