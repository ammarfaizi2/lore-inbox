Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317421AbSFHUV1>; Sat, 8 Jun 2002 16:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSFHUV0>; Sat, 8 Jun 2002 16:21:26 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58637
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317421AbSFHUVZ>; Sat, 8 Jun 2002 16:21:25 -0400
Date: Sat, 8 Jun 2002 13:06:22 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Nick Evgeniev <nick@octet.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
In-Reply-To: <Pine.LNX.3.96.1020604143643.5024C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.10.10206081305390.1190-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because there is an entire set of new calls to deal with cfa or flash.
It really takes a new subdriver.

On Tue, 4 Jun 2002, Bill Davidsen wrote:

> On Wed, 29 May 2002, Nick Evgeniev wrote:
> 
> > Hi,
> > 
> > I wrote about ide problems with 2.4.19-pre8 a few days ago (it just trashed
> > filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was a
> > little bit better though every 5-8 hours I've got ide errors in log (at
> > least it didn't crash my reiserfs volumes yet):
> 
> I see a lot of the 0x58 with taskfile enabled, are you doing that? I even
> see it mounting an "IDE" compact flash! I ran out of time to try w/o
> taskfile_io.
> 
> > >-----------------------------
> > May 27 14:38:02 vzhik kernel: hdg: status error: status=0x58 { DriveReady
> > SeekComplete DataRequest }
> > May 27 14:38:02 vzhik kernel:
> > May 27 14:38:02 vzhik kernel: hdg: drive not ready for command
> > May 27 14:38:02 vzhik kernel: hdg: status error: status=0x58 { DriveReady
> > SeekComplete DataRequest }
> > May 27 14:38:02 vzhik kernel:
> > May 27 14:38:02 vzhik kernel: hdg: drive not ready for command
> > May 27 17:08:05 vzhik kernel: hdg: drive_cmd: status=0xd0 { Busy }
> > May 27 17:08:05 vzhik kernel:
> > May 27 17:08:05 vzhik kernel: hdg: status error: status=0x58 { DriveReady
> > SeekComplete DataRequest }
> > >-----------------------------
> > But now I've got even more bugs in log like:
> > >-----------------------------
> > May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 37713311 4
> > May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 37713343 4
> > May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 37713375 4
> > May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 37713407 2
> > May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 38161563 4
> > May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 38161595 4
> > May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 38161627 4
> > May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 38161659 4
> > May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> > across chunks or bigger than 16k 37713308 4
> > >-----------------------------
> > 
> > I don't even think about trying 2.4.19-pre9 since it doesn't has any ide
> > related issues in its changelist.
> > The question is -- What I have to try to get WORKING ide driver under
> > "STABLE" kernel?
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

