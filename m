Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265012AbTIIW4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265005AbTIIWxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:53:52 -0400
Received: from smtp02.web.de ([217.72.192.151]:36113 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S264978AbTIIWxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:53:22 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: inode generation numbers
Date: Wed, 10 Sep 2003 00:53:22 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <200309092108.37805.bernd-schubert@web.de> <20030909140751.E18851@schatzie.adilger.int>
In-Reply-To: <20030909140751.E18851@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309100053.23352.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 22:07, Andreas Dilger wrote:
> On Sep 09, 2003  21:08 +0200, Bernd Schubert wrote:
> > for a user space nfs-daemon it would be helpful to get the inode
> > generation numbers. However it seems the fstat() from the glibc doesn't
> > support this, but refering to some google search fstat() from some (not
> > all) other unixes does.
> > Does anyone know how to read those numbers from userspace with linux?
>
> For ext2/ext3 filesystems you can use EXT2_GET_VERSION ioctl for this.

regarding to fs/ext2/ioctl.c it should be EXT2_IOC_GETVERSION, shouldn't it?

> Maybe reiserfs as well.
>

Hello,

thanks a lot, it seems to work pretty well.
Since I have never used the ioctl() call before I only want to be sure I don't 
do something wrong,  I think this is correct, isn't it?

int ret, igen;
ret = ioctl(fd, EXT2_IOC_GETVERSION, &igen);


It also works for reiserfs-partitions with the very same call, @reiserfs-team, 
this won't change in the future, will it?


Cheers,
	Bernd

