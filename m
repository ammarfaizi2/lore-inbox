Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSBSLwt>; Tue, 19 Feb 2002 06:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291307AbSBSLwi>; Tue, 19 Feb 2002 06:52:38 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:29965 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S291306AbSBSLwU>; Tue, 19 Feb 2002 06:52:20 -0500
Subject: Re: VFS issues (was: Re: 2.5.5-pre1: mounting NTFS partitions -t
	VFAT)
From: Richard Russon <ntfs@flatcap.org>
To: Jos Hulzink <josh@stack.nl>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020219102539.J93925-100000@snail.stack.nl>
In-Reply-To: <20020219102539.J93925-100000@snail.stack.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Feb 2002 11:52:18 +0000
Message-Id: <1014119542.2788.10.camel@addlestones>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jos,

> The first question I want answered: Should I just call myself stupid for
> trying to mount NTFS as VFAT, or should we consider this a real issue that
> needs fixing ?

Stupid?  No.
Fixing?  Yes.

Whatever you throw at mount, you want it to fail_safe_.  i.e. in the
worst case, do nothing.

> While mounting a partition, the vfs layer tries to determine the partition
> type,

Without any help, mount (userspace) tries to determine the partition
type.  It understands the magics of a LOT of filesystems.

It looks for the NTFS magic before the DOS magic (or any of its variants).

> and passes that info to the filesystem driver

Which is passed to the VFS, and the to the driver which performs some
more rigid tests (hopefully :-)

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org


