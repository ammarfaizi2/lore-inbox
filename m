Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbTABBuM>; Wed, 1 Jan 2003 20:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTABBuM>; Wed, 1 Jan 2003 20:50:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:30644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265320AbTABBuL>;
	Wed, 1 Jan 2003 20:50:11 -0500
Date: Wed, 1 Jan 2003 17:55:53 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Tomas Szepe <szepe@pinerecords.com>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: observations on 2.5 config screens
In-Reply-To: <20030101200717.GA17053@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33L2.0301011750010.21149-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Tomas Szepe wrote:

[snippage]
| >     It seems that the final option, "Preemptible kernel", does
| >   not belong there.  In fact, there seem to be a number of
| >   kernel-related, kind of hacking/debugging options, that
| >   could be collected in one place, like preemption, sysctl,
| >   hacking, executable file formats, etc.  "Low-level kernel
| >   options", perhaps?

So long as they come after the processor selection or whatever
dependencies they have.

| Should go to "General config" IMHO.

But is General Config still above processor selection?
I made a patch for a second "More general config" at the end
of the main menu so that dependencies can be used.
Andrew Morton has it queued in -mm now.

| > Bus options (PCI, PCMCIA, EISA, MCA, ISA)
| >
| >     First, there's no hint from that heading that hot-pluggable
| >   settings are hidden under there as well.
|
| Well, PCMCIA pretty much suggests that, doesn't it?
|
| >     In addition, why does "Bus options" not include the USB bus,
| >   the I2C bus, FireWire, etc?  A bus is a bus, isn't it?
|
| Yes, this is a valid comment.  Placing USB under "Bus options"
| should be totally straightforward, but that one's for Greg KH
| to decide.

USB needs to follow the Input subsystem unless there's something
else going on regarding dependencies.

| > Multimedia devices
| >
| >     How come "Sound" is not here?  And (as we've already
| >   established), Radio Adapters is not a sub-entry of Video for
| >   Linux. :-)  (And is there a reason why Amateur Radio Support
| >   and Radio Adapters are so far apart in the config menus?

I agree.

Greg Banks has (had) a real nice program for checking
dependency ordering using Config.in files.  It would be
very nice if it now worked with Kconfig files.  :)
It could be used for this type of config reordering to
verify that things weren't screwed up.  I used it when
I moved Network Devices to just under/after Network Options
to show that no dependency ordering was mangled by that patch.

-- 
~Randy

