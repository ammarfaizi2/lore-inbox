Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSGCAKC>; Tue, 2 Jul 2002 20:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSGCAKB>; Tue, 2 Jul 2002 20:10:01 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:23690 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314243AbSGCAKB>;
	Tue, 2 Jul 2002 20:10:01 -0400
Date: Wed, 3 Jul 2002 02:09:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
Message-ID: <20020703020917.B7689@ucw.cz>
References: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Jul 01, 2002 at 01:48:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 01:48:55PM -0400, Bill Davidsen wrote:

> Having read some notes on the Ottawa Kernel Summit, I'd like to offer some
> comments on points raied.
> 
> The suggestion was made that kernel module removal be depreciated or
> removed. I'd like to note that there are two common uses for this
> capability, and the problems addressed by module removal should be kept in
> mind. These are in addition to the PCMCIA issue raised.
> 
> 1 - conversion between IDE-CD and IDE-SCSI. Some applications just work
> better (or usefully at all) with one or the other driver used to read CDs.
> I've noted that several programs for reading the image from an ISO CD
> (readcd and sdd) have end of data problems with the SCSI interface.

This will go away once the IDE rewrite is finished. There will be only
one way to access an IDE CD. And it'll be fixed so that all programs
work with it. Or the programs get fixed.

> 2 - restarting NICs when total reinitialization is needed. In server
> applications it's sometimes necessary to move or clear a NIC connection,
> force renegotiation because the blade on the switch was set wrong, etc.
> It's preferable to take down one NIC for a moment than suffer a full
> outage via reboot.

This can be solved without module unload as well. I think something
that'll fulfill the reset functionality will grow out of the hotplug/pm
system once it's fully implemented.

-- 
Vojtech Pavlik
SuSE Labs
