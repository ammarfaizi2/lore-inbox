Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbSKVEcm>; Thu, 21 Nov 2002 23:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbSKVEcm>; Thu, 21 Nov 2002 23:32:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55311 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265179AbSKVEcl>;
	Thu, 21 Nov 2002 23:32:41 -0500
Message-ID: <3DDDB4EF.9090300@pobox.com>
Date: Thu, 21 Nov 2002 23:39:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: linux-kernel@vger.kernel.org, kentborg@borg.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
References: <200211220241.gAM2fEZ357378@saturn.cs.uml.edu>
In-Reply-To: <200211220241.gAM2fEZ357378@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

> Jeff Garzik writes:
>
> >Albert D. Cahalan wrote:
>
>
> >>Forget the shred program. It's less useful than having the
> >>filesystem simply zero the blocks, because it's slow and you
> >>can't be sure to hit the OS-visible blocks.
> >
> >Why not?
> >
> >Please name a filesystem that moves allocated blocks around on you.  And
> >point to code, too.
>
>
> Reiserfs tails
>   fs/reiserfs


inodes don't move

> ext3 with data journalling
>   fs/ext3


the allocated blocks don't change


> the journalling flash filesystems
>   fs/jffs
>   fs/jffs2


yep

> NTFS with compression
>   fs/ntfs


the allocated blocks don't change


> Multiple overwrites won't protect you from the disk manufacturer
> or the NSA. Only one is needed to protect against root & kernel.
> So it makes sense to have the filesystem zero the blocks when
> they are freed from a file.


if you need to protect against root, then zeroing the blocks isn't going 
to help for LVM or jffs or other journalling.

	Jeff


