Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286670AbRL1Bmw>; Thu, 27 Dec 2001 20:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286655AbRL1Bmf>; Thu, 27 Dec 2001 20:42:35 -0500
Received: from ns2.q-station.net ([202.66.128.35]:30982 "HELO
	smtp.q-station.net") by vger.kernel.org with SMTP
	id <S286679AbRL1BmO>; Thu, 27 Dec 2001 20:42:14 -0500
Date: Fri, 28 Dec 2001 09:42:07 +0800 (CST)
From: Leung Yau Wai <chris@gist.q-station.net>
To: Douglas Gilbert <dougg@torque.net>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: dd cdrom error
In-Reply-To: <3C2BA1B4.EB853055@torque.net>
Message-ID: <Pine.LNX.4.10.10112280937570.6257-100000@gist.q-station.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Douglas Gilbert wrote:

> Leung Yau Wai <chris@gist.q-station.net> wrote:
> > I come across a problem which seem exist in kernel 
> > 2.4.x but not in 2.2.x.
> >
> > The problem is that, when I try to using dd to create 
> > a ISO image of a cdrom then around dumping the end of 
> > the disc it will give out the following error message:
> >
> > e.g. dd if=/dev/cdrom of=n.iso
> 
> If dd is used like that, it is surprising you do not get
> more errors. An iso9660 image does not necessarily fill
> the track. So the IDE equivalent of the SCSI READ CAPACITY 
> command will often report a size that includes unwritten 
> sectors at the end. Those unwritten sectors can/will cause
> IO errors when an attempt is made to read them.
> 
> A very useful program called "isosize" has made a return to
> util-linux-2.10s (and later). Execute:
>   isosize -x /dev/cdrom
> to find the number of sectors and the sector size of the iso9660
> fs held _within_ the first track. Then use those numbers as the 
> "count=" and "bs=" arguments to dd respectively.
> 
> 
> If you still have problems try turning DMA off via hdparm
> or set the DMA mode back to 33 MHz (-X34).

	So, why problem will be happened when using DMA?

	Do you mean when not using DMA then the sectors at the end of the
disc will be auto-filled (padded)? ( I think it is impossible )

	BTW, why kernel 2.2.X will success create the ISO image of the
same disc with the same command?

	Thx your reply!



