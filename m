Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTKQNeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTKQNeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:34:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55556 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263513AbTKQNe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:34:27 -0500
Date: Mon, 17 Nov 2003 08:23:41 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <20031115134325.GV4441@suse.de>
Message-ID: <Pine.LNX.3.96.1031117080832.13362B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003, Jens Axboe wrote:

> On Sat, Nov 15 2003, Bill Davidsen wrote:

> > Sorry, as far as I can tell it's just the wrong direction. Devices mounted
> > by USB look like... SCSI. And ZIP drives and tapes mounted on parallel
> > (ppa) look like... SCSI. If Linux had one fully functional ide-scsi driver
> > it would then present a consistant all-SCSI interface to the applications.
> 
> Crap. 2.6 block layer can pass "looks like SCSI" commands through the
> plain queue just fine, why on earth would I need to go through two extra
> layers to send a command to ide-cd? Presenting all-SCSI interface to
> applications is bogus. The number of actual SCSI devices is going down
> by the minute. Basically all storage-like devices talk some packetized
> commands that looks like SCSI, but they are not.
> 
> What we do need is something that allows you to submit commands to a
> device, no matter where it's attached. You still don't seem to grasp
> that.

That's exactly why making ATAPI devices look like SCSI is desirable, so I
can use the cd, block, and tape drivers used for actual SCSI devices with
ATAPI devices, just as everyone already does with USB and parallel
devices.

> 
> > No more ide-floppy, ide-cd, ide-tape, just one driver. And that would
> > allow use of applications from BSD, Sun, and SysV.
> 
> One drive to manage different device types? What are you smoking.

I don't understand that sentence, if I assume you meant "driver" it still
doesn't seem to convey your meaning. Clearly the sd driver works with real
SCSI, USB flash devices, parallel attach ZIP and similar (ppa driver)
devices, and in 2.4 ATAPI ZIP drives and other similar devices. So I
assume I'm missing your meaning.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

