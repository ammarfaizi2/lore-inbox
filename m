Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291343AbSBMEMT>; Tue, 12 Feb 2002 23:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291345AbSBMEMK>; Tue, 12 Feb 2002 23:12:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:30727 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291343AbSBMEL6>; Tue, 12 Feb 2002 23:11:58 -0500
Date: Tue, 12 Feb 2002 23:10:55 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Chabot <chabotc@reviewboard.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Quick question on Software RAID support.
In-Reply-To: <3C69C5A6.4020409@reviewboard.com>
Message-ID: <Pine.LNX.3.96.1020212230521.8017E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Chris Chabot wrote:

> Alan Cox wrote:
> >>1) Does the Software RAID-5 support automatic detection
> >>     of a drive failure? How?
> >>
> > 
> > It sees the commands failing on the underlying controller. Set up a software
> > raid 5 and just yank a drive out of a  bay if you want to test it
> 
> This is also why software raid 5 + IDE is a bad combo. It has a high 
> chance of locking up the IDE controller, and requiring you to power down 
> & fix the system before reconstruction can commence. However with SCSI 
> hot-swapable solutions, on-the-fly reconstruction after failure works 
> perfectly.

>From personal experience software RAID is quite fast, and very reliable
regarding failures while running. If a disk fails the system drops back to
recovery, and after a new drive is added and `raidhotadd' is run it is
rebuilt.

The dark side of the force is that is a drive fails on boot, I have had
problems getting the system to boot (even when not the boot drive). The
system doesn't always recognize that there is a failed drive, and I've had
to build a new raid config with "failed disk" entries to get the system
up. Later version may be better at that (comments, please), I have not had
to address this in over a year, since most of my system are not taken down
unless they fall down.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

