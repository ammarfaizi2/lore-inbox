Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312976AbSDBWLw>; Tue, 2 Apr 2002 17:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312975AbSDBWLl>; Tue, 2 Apr 2002 17:11:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53236
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312962AbSDBWLc>; Tue, 2 Apr 2002 17:11:32 -0500
Date: Tue, 2 Apr 2002 14:13:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [Q] FAT driver enhancement
Message-ID: <20020402221325.GC961@matchmail.com>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020328135555.U6796-100000@snail.stack.nl> <871ye479sz.fsf@devron.myhome.or.jp> <3CA97B1A.13E6765D@aitel.hist.no> <87663acjs7.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 10:27:52PM +0900, OGAWA Hirofumi wrote:
> Helge Hafting <helgehaf@aitel.hist.no> writes:
> 
> > OGAWA Hirofumi wrote:
> > > 
> > > Jos Hulzink <josh@stack.nl> writes:
> > > > Questions:
> > > >
> > > > 1) How do you think about the checking of the FAT tables ? It definitely
> > > >    will slow down the mount.
> > > 
> > > Unfortunately if FAT table has bad sector, FAT tables may not be the
> > > same.
> > 
> > And then you don't want to mount unless you know what you
> > are doing.  And those knowing what they are doing can be bothered
> > to use some kind of "force" option in this case.  Or perhaps an
> > option that selects which FAT to trust.
> 
> I mean I/O error, not data damage.

It is the block layer's responsibility to retry such soft errors and recover.

Probably the best you can do, is retry the read a few times if there is an error
reported, and then fail if it persists.
