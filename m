Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbREOXgC>; Tue, 15 May 2001 19:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbREOXfx>; Tue, 15 May 2001 19:35:53 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:18068 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261705AbREOXfj>; Tue, 15 May 2001 19:35:39 -0400
Date: Tue, 15 May 2001 16:35:02 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Message-id: <048801c0dd97$aa67bf60$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <200105152317.f4FNHsY3022099@webber.adilger.int>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Re why "physical" device IDs _should_ have a critical role in sysadmin ]

> I would have to agree that "stable" is critical to not driving people
> crazy.  In the case of AIX, once a device is enumerated, it will retain
> the same name across reboots.  Enough information is kept about each
> device to determine if it has already been enumerated (i.e. same I/O
> port address for serial devices, MAC address for ethernet cards, etc),
> or if it is a new device and should get a new name.

I caught those refs to how AIX does this ... sounds worth learning from.
Does it handle USB "port addresses" (which bus and hub)?


> > Given hotplugging, I think the best solution to such issues
> > does involve exposing topological IDs such as PCI slot names.
> > (What IDs the different applications use is a different issue.)
> 
> I disagree here.  In many cases you only have a very limited number of
> devices of each type (or only 1), so you don't want to be bogged down
> with physical device naming.

I'm not clear what you were disagreeing with.  Though I think you've
hit on an important stumbling block:  folk working with only one instance
of a given device type tend to come at this problem from a differerent
perspective.  A workable naming policy needs to not make such setups
become painful; they're the "start points" most systems will grow from.


>      If you have lots of a given type of device
> (e.g. disks), you _also_ don't want to be bogged down with physical
> device naming, because it will NOT be consistent across different physical
> access methods.  In both cases, you want a generic name PLUS a way to
> find out the physical characteristics (attributes) of the device to do
> INITIAL configuration.  If the device keeps a constant name across
> reboots, you don't care how it is accessed after the first configuration.

Sounds like you're actually agreeing with me that the ID used by
applications ("generic name") isn't necessarily the physical/topological ID
used to establish and maintain a stable non-"crazy" naming setup.

- Dave


