Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTBSU1M>; Wed, 19 Feb 2003 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTBSU1L>; Wed, 19 Feb 2003 15:27:11 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23045 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267278AbTBSU1J>; Wed, 19 Feb 2003 15:27:09 -0500
Date: Wed, 19 Feb 2003 15:33:39 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Patrick Mansfield <patmans@us.ibm.com>
cc: Thomas Molina <tmolina@cox.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
In-Reply-To: <20030219102308.A19911@beaverton.ibm.com>
Message-ID: <Pine.LNX.3.96.1030219152634.11297A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Patrick Mansfield wrote:

> On Wed, Feb 19, 2003 at 08:55:22AM -0500, Bill Davidsen wrote:

> > I don't think it matters, the idea is to avoid all the low-level SCSI
> > menus in one place, without disabling the ability to handle ATAPI devices.
> > Using the ide-scsi or not still uses SCSI drivers AFAIK.
> 
> But as far as linux scsi is concerned, ide-scsi is a low-level SCSI driver. 
>
> IDE and USB have there own Kconfig options that enable low-level SCSI
> driver emulation outside of drivers/scsi, pcmcia does not, and there are
> probably other exceptions.
> 
> The following is simpler, though I'm not suggesting anything like this be
> applied, since we don't have consitency. If all of the low-level scsi
> drivers and options were under drivers/scsi, and we could separate
> emulated versus real, something like this might be OK:

I think this is a very good idea. In the long run this is one of those
matrix things, is SCSI on USB an entry in a menu of USB or SCSI? And until
we can access the option from either place and still have exactly one
option, we (someone) must decide which it is.

Clearly unless we do it both way at some time, some portion of the users
will find either choice unintuitive. What you propose is a step forward,
and if extensions are made in 2.7 which suggest rethinking, so be it.

Thanks for the patch, it's goin in my tree.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

