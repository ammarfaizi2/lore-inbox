Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSJ1OIc>; Mon, 28 Oct 2002 09:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261187AbSJ1OIc>; Mon, 28 Oct 2002 09:08:32 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:64667 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261173AbSJ1OIa>; Mon, 28 Oct 2002 09:08:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
References: <20021025103631.GA588@giantx.co.uk>
	<20021025103938.GN4153@suse.de> <87adl2is1u.fsf@gitteundmarkus.de>
	<20021025144224.GW4153@suse.de> <87pttyh3r5.fsf@gitteundmarkus.de>
	<20021025165354.GG4153@suse.de> <874rb71xfc.fsf@gitteundmarkus.de>
	<20021027185636.GJ3966@suse.de> <20021028121433.GA872@suse.de>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Mon, 28 Oct 2002 16:14:35 +0100
In-Reply-To: <20021028121433.GA872@suse.de> (Jens Axboe's message of "Mon,
 28 Oct 2002 13:14:33 +0100")
Message-ID: <87lm4iegtg.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jens Axboe writes:
>On Sun, Oct 27 2002, Jens Axboe wrote:
>>> Now if C2 scans would work that'd be great ;-)
>>> 
>>> [plail@plailis_lfs:plail]$ readcd dev=/dev/hdc -c2scan
>>> Read  speed:  7056 kB/s (CD  40x, DVD  5x).
>>> Write speed:     0 kB/s (CD   0x, DVD  0x).
>>> Capacity: 4116432 Blocks = 8232864 kBytes = 8039 MBytes = 8430 prMB
>>> Sectorsize: 2048 Bytes
>>> Copy from SCSI (0,0,0) disk to file '/dev/null'
>>> end:   4116432
>>> addr:        0 cnt: 99^Mreadcd: Operation not permitted. Cannot send SCSI cmd vi
>>> readcd: Operation not permitted. Cannot send SCSI cmd via ioctl
>>
>>Interesting, have no tried readcd at all myself. Will give it a spin and
>>fix this tomorrow.

>It uses SCSI_IOCTL_SEND_COMMAND ioctl, an old piece of crap interface
>instead of libscg. I can add the 50 lines or so to emulate that ioctl,
>but it would probably be better if readcd just got converted to use
>libscg instead.

OK. Can you get in touch with Jörg to get that sorted out? Or should I
post to cdwrite ML?

regards
Markus

