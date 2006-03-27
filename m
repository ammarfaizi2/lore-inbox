Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWC0RZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWC0RZd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWC0RZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:25:33 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:53652 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1750743AbWC0RZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:25:32 -0500
Date: Mon, 27 Mar 2006 10:25:30 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Douglas Gilbert <dougg@torque.net>, Bodo Eggert <7eggert@gmx.de>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move SG_GET_SCSI_ID from sg to scsi
Message-ID: <20060327172530.GH3486@parisc-linux.org>
References: <Pine.LNX.4.58.0603262108500.13001@be1.lrz> <Pine.LNX.4.64.0603261424590.15714@g5.osdl.org> <4427FEC9.4010803@torque.net> <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603270854570.15714@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 09:15:35AM -0800, Linus Torvalds wrote:
> On Mon, 27 Mar 2006, Douglas Gilbert wrote:
> >
> > There are two things that really count:
> >   1) the identifier (preferably a world wide unique name)
> >      of the logical unit that is being addressed
> >   2) a topological description of how that logical unit
> >      is connected
> 
> And "SCSI ID" doesn't describe either.
> 
> > Linux's <hctl> may be a ham fisted way of describing
> > a path through a topology, but it easily beats /dev/sdabc
> > and /dev/sg4711 .
> 
> Sure, you can easily beat it by selecting what you compare it against.
> 
> But face it, /dev/sdabc or /dev/sg4711 simply isn't what you should 
> compare against. What you should compare against is
> 
> 	/dev/cdrom
> 	/sys/bus/ide/devices/0.0/block:hda/dev
> 	/dev/uuid/3d9e6e8dfaa3d116
> 	..
> 
> and a million OTHER ways to specify which device you're interested in.
> 
> The fact is, they can potentially all do the SCSI command set. And a "SCSI 
> ID" makes absolutely zero sense for them (those three devices may be the 
> same device, they may not be, they might be on another machine, who 
> knows..)

If this ioctl is generally supported, then you'll be able to find out if
they're all the same ;-)
