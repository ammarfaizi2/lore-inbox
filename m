Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280220AbRJaQTt>; Wed, 31 Oct 2001 11:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280285AbRJaQTj>; Wed, 31 Oct 2001 11:19:39 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:63360 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S280220AbRJaQTZ>;
	Wed, 31 Oct 2001 11:19:25 -0500
Date: Wed, 31 Oct 2001 08:19:59 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Cc: m.schimschak@gmx.de
Subject: Re: [Danger] 2.4.14pre3-pre5: Queueing changes broken? [Re: [2.4.14-pre3] kernel: attempt to access beyond end of device]
Message-ID: <20011031081959.A30992@netnation.com>
In-Reply-To: <87pu76fd2l.fsf@hobbes.masch.org> <20011030205858.A571@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030205858.A571@netnation.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 08:58:59PM -0800, Simon Kirby wrote:

> Something is definitely broken with the kernel here.  My box was up and
> running fine with 2.4.14pre5 until I just decided to remove hdb from the
> box to move it to another box.  I had:
> 
> Oct 29 21:17:19 oof kernel: hda: ST360021A, ATA DISK drive
> Oct 29 21:17:19 oof kernel: hdb: IBM-DTLA-307045, ATA DISK drive
> Oct 29 21:17:19 oof kernel: hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 010, ATAPI CD/DVD-ROM drive
> Oct 29 21:17:19 oof kernel: hdd: LITE-ON LTR-24102B, ATAPI CD/DVD-ROM drive
> 
> I took out hdb, and I got the looping "Attempt to access beyond end of
> device" message, followed by fsck saying the filesystem had errors on the
> next boot (in which I entered single-user mode in and tried to fsck
> manually).  Every normal bootup had the looping failure message.
> 
> My fallback, 2.4.10pre10, boots fine with hdb missing.

Confirmed that reattaching the hdb drive makes the kernel boot up fine,
and removing it again makes it blow up.  I left my null modem cable at
work so I wasn't able to get a serial console log, but I will get one
tonight.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
