Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSDCLz3>; Wed, 3 Apr 2002 06:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311320AbSDCLzT>; Wed, 3 Apr 2002 06:55:19 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:12045 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S311670AbSDCLzI>; Wed, 3 Apr 2002 06:55:08 -0500
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl>
	<871ye479sz.fsf@devron.myhome.or.jp> <3CA97B1A.13E6765D@aitel.hist.no>
	<87663acjs7.fsf@devron.myhome.or.jp>
	<20020402221325.GC961@matchmail.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 03 Apr 2002 20:54:31 +0900
Message-ID: <87y9g5m1zc.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> writes:

> On Tue, Apr 02, 2002 at 10:27:52PM +0900, OGAWA Hirofumi wrote:
> > Helge Hafting <helgehaf@aitel.hist.no> writes:
> > 
> > > OGAWA Hirofumi wrote:
> > > > 
> > > > Jos Hulzink <josh@stack.nl> writes:
> > > > > Questions:
> > > > >
> > > > > 1) How do you think about the checking of the FAT tables ? It definitely
> > > > >    will slow down the mount.
> > > > 
> > > > Unfortunately if FAT table has bad sector, FAT tables may not be the
> > > > same.
> > > 
> > > And then you don't want to mount unless you know what you
> > > are doing.  And those knowing what they are doing can be bothered
> > > to use some kind of "force" option in this case.  Or perhaps an
> > > option that selects which FAT to trust.
> > 
> > I mean I/O error, not data damage.
> 
> It is the block layer's responsibility to retry such soft errors and recover.

Yes.

> Probably the best you can do, is retry the read a few times if there
> is an error reported, and then fail if it persists.

Umm, there is a `copy of FAT table' for this kind of error. If the I/O
error occurs, the FAT driver should use the other FAT table.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
