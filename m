Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTHRPBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTHRPBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:01:16 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:39172 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S271740AbTHRPBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:01:14 -0400
To: jw schultz <jw@pegasys.ws>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ioctl vs xattr for the filesystem specific attributes
References: <8765l67rvc.fsf@devron.myhome.or.jp> <bhogm4$2gb$1@sea.gmane.org>
	<20030818001310.GA10453@pegasys.ws>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 19 Aug 2003 00:00:53 +0900
In-Reply-To: <20030818001310.GA10453@pegasys.ws>
Message-ID: <87n0e7xb6i.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jw schultz <jw@pegasys.ws> writes:

> > >This read/modify the file attributes of filesystem specific via xattr
> > >interface (in this case, ARCHIVE, SYSTEM, HIDDEN flags of fatfs).
> > >
> > >Yes, also we can provide it via ioctl like ext2/ext3 does now.
> > >
> > >But if those flags provides by xattr interfaces and via one namespace
> > >prefix, I guess the app can save/restore easy without dependency of
> > >one fs.
> > >
> > >Which interface would we use for attributes of filesystem specific?
> > >Also if we use xattr, what namepace prefix should be used?
> > >
> > >Any idea?

> I suggested something like this to Andreas Gruenbacher in
> March.  We dialoged briefly about it and I've heard nothing
> since.

> > I like the ideas that the patch seems to propose.
> > Infact I'd like to see the use of xattr used for non-standard attributes
> > applied to all fs.
> > Specifically, I want to backup all partitions, and attribs from one OS:
> > Linux. I do not want to loose fat attributes during backup.
> > This would also be useful for the Wine developers.

I think, at least we are agreed that xattr interface would be good for
the following operation.

    # ls /mnt
    resierfs_mnt ext2_mnt vfat_mnt foo_mnt bar_mnt
    # archiver --create --file /backup/file_has_all_data /mnt

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
