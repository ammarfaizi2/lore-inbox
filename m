Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbREPAZs>; Tue, 15 May 2001 20:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbREPAZi>; Tue, 15 May 2001 20:25:38 -0400
Received: from geos.coastside.net ([207.213.212.4]:57016 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261692AbREPAZX>; Tue, 15 May 2001 20:25:23 -0400
Mime-Version: 1.0
Message-Id: <p0510032bb7277177f2c0@[207.213.214.37]>
In-Reply-To: <048801c0dd97$aa67bf60$6800000a@brownell.org>
In-Reply-To: <200105152317.f4FNHsY3022099@webber.adilger.int>
 <048801c0dd97$aa67bf60$6800000a@brownell.org>
Date: Tue, 15 May 2001 16:55:08 -0700
To: David Brownell <david-b@pacbell.net>,
        Andreas Dilger <adilger@turbolinux.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:35 PM -0700 2001-05-15, David Brownell wrote:
>[ Re why "physical" device IDs _should_ have a critical role in sysadmin ]
>
>>  I would have to agree that "stable" is critical to not driving people
>>  crazy.  In the case of AIX, once a device is enumerated, it will retain
>>  the same name across reboots.  Enough information is kept about each
>>  device to determine if it has already been enumerated (i.e. same I/O
>>  port address for serial devices, MAC address for ethernet cards, etc),
>>  or if it is a new device and should get a new name.
>
>I caught those refs to how AIX does this ... sounds worth learning from.
>Does it handle USB "port addresses" (which bus and hub)?

Solaris has a scheme that addresses the issue at well. Device nodes 
live in /devices (/dev has soft links into /devices) and have 
system-global-geographic names. In Solaris talk, the 0-1-2 of 
eth0-1-2 i an instance. There's a file /etc/pathtoinst that records 
the connection of an device instance to its /devices geographical 
name.

It does keep naming stable, but can be a PITA at times when you're 
reconfiguring a system and *want* to renumber things. (There are 
magic ways to do it, though).

That's all Solaris 2.6; not sure about 2.8.
-- 
/Jonathan Lundell.
