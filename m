Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbTGEHGI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 03:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbTGEHGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 03:06:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:41410 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266291AbTGEHGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 03:06:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 ServerWorks DMA Bugs
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Sat, 05 Jul 2003 09:21:13 +0200
In-Reply-To: <Pine.LNX.4.53.0307042325430.3837@mackman.net> (Ryan Mack's
 message of "Fri, 4 Jul 2003 23:45:29 -0700 (PDT)")
Message-ID: <87fzllh21i.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Ryan Mack wrote:

> I've real the other threads but nothing touches on my specific issue.
> I have a dual P4 Xeon Dell PowerEdge 1600SC with a Fusion MPT SCSI
> controller and a ServerWorks CSB5 IDE chipset.  All the HDs are on the
> SCSI bus, and only my CD reader and my DVD writer are on the IDE bus
> (one on each channel).  Hyperthreading is enabled (4 logical
> processors).  I am using GCC 3.2.2.
> 
> The CD readers is the blacklisted 'SAMSUNG CD-ROM SC-148C' and I never
> use it so I can remove it if needed.  The DVD writer is a 'SONY DVD RW
> DRU-500A'.  Both are going through the ide-scsi driver.  Whenever I
> read/write CDs in the DVD writer, I get very high system load (50% on
> one CPU), even though DMA seems to be enabled.

If you are writing CDs with unusual block sizes (audio CDs, (S)VCDs,
RAW mode -> blocksize != 2048) you won't get DMA with ide-scsi, no
matter what you do. It's simply not supported.

regards
Markus

