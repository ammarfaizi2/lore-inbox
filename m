Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293249AbSDCMW2>; Wed, 3 Apr 2002 07:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293276AbSDCMWS>; Wed, 3 Apr 2002 07:22:18 -0500
Received: from insgate.stack.nl ([131.155.140.2]:31239 "HELO skynet.stack.nl")
	by vger.kernel.org with SMTP id <S293249AbSDCMWB>;
	Wed, 3 Apr 2002 07:22:01 -0500
Date: Wed, 3 Apr 2002 14:21:56 +0200 (CEST)
From: Jos Hulzink <josh@stack.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <87y9g5m1zc.fsf@devron.myhome.or.jp>
Message-ID: <20020403140516.C38235-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, OGAWA Hirofumi wrote:

> Mike Fedyk <mfedyk@matchmail.com> writes:
>
> > > I mean I/O error, not data damage.
> >
> > It is the block layer's responsibility to retry such soft errors and recover.
>
> Yes.

But what about the data damage errors ?

> > Probably the best you can do, is retry the read a few times if there
> > is an error reported, and then fail if it persists.
>
> Umm, there is a `copy of FAT table' for this kind of error. If the I/O
> error occurs, the FAT driver should use the other FAT table.

How should the FAT driver know that the first FAT is bad if it doesn't
scan the FAT ? You don't want the second FAT to be used, you want the
mount to fail, and fsck.xxx to fix the mess. Who tells you that the second
copy of the FAT is the correct one, and not the first ?

Jos


