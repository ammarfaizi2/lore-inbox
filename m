Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316488AbSFDSpq>; Tue, 4 Jun 2002 14:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSFDSpo>; Tue, 4 Jun 2002 14:45:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12300 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316488AbSFDSpL>; Tue, 4 Jun 2002 14:45:11 -0400
Date: Tue, 4 Jun 2002 14:41:06 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
In-Reply-To: <000901c206f0$cfd42620$baefb0d4@nick>
Message-ID: <Pine.LNX.3.96.1020604143643.5024C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Nick Evgeniev wrote:

> Hi,
> 
> I wrote about ide problems with 2.4.19-pre8 a few days ago (it just trashed
> filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was a
> little bit better though every 5-8 hours I've got ide errors in log (at
> least it didn't crash my reiserfs volumes yet):

I see a lot of the 0x58 with taskfile enabled, are you doing that? I even
see it mounting an "IDE" compact flash! I ran out of time to try w/o
taskfile_io.

> >-----------------------------
> May 27 14:38:02 vzhik kernel: hdg: status error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> May 27 14:38:02 vzhik kernel:
> May 27 14:38:02 vzhik kernel: hdg: drive not ready for command
> May 27 14:38:02 vzhik kernel: hdg: status error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> May 27 14:38:02 vzhik kernel:
> May 27 14:38:02 vzhik kernel: hdg: drive not ready for command
> May 27 17:08:05 vzhik kernel: hdg: drive_cmd: status=0xd0 { Busy }
> May 27 17:08:05 vzhik kernel:
> May 27 17:08:05 vzhik kernel: hdg: status error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> >-----------------------------
> But now I've got even more bugs in log like:
> >-----------------------------
> May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713311 4
> May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713343 4
> May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713375 4
> May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713407 2
> May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 38161563 4
> May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 38161595 4
> May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 38161627 4
> May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 38161659 4
> May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
> across chunks or bigger than 16k 37713308 4
> >-----------------------------
> 
> I don't even think about trying 2.4.19-pre9 since it doesn't has any ide
> related issues in its changelist.
> The question is -- What I have to try to get WORKING ide driver under
> "STABLE" kernel?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

