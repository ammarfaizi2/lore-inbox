Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312608AbSDFRJ4>; Sat, 6 Apr 2002 12:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312612AbSDFRJ4>; Sat, 6 Apr 2002 12:09:56 -0500
Received: from winds.org ([209.115.81.9]:27914 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S312608AbSDFRJz>;
	Sat, 6 Apr 2002 12:09:55 -0500
Date: Sat, 6 Apr 2002 12:04:59 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: Jeremy Jackson <jerj@coplanar.net>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        <linux-kernel@vger.kernel.org>, <ebiederm@xmission.com>
Subject: Re: Faster reboots - calling _start?
In-Reply-To: <003301c1dd16$855df1b0$7e0aa8c0@bridge>
Message-ID: <Pine.LNX.4.44.0204061201281.7190-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Jeremy Jackson wrote:

> ----- Original Message -----
> From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
> Sent: Friday, April 05, 2002 5:48 PM
> 
> > I need to avoid going through the BIOS ... this is a
> > multiquad NUMA machine, and it doesn't take kindly
> > to the reboot through the BIOS for various reasons.
> > It also takes about 4 minutes, which is a pain ;-)
> >
> > I have source code access to our BIOS if I really wanted,
> > I just want to avoid modifying it if possible.
> 
> well keep in mind that the fastest LinuxBIOS boot is 3 seconds...
> a large part of the boot time on most PCs is the BIOS setting up
> DOS support and painting silly logos on the screen, all of which
> can go away.  I'm guessing your NUMA system has a bit more
> to do at this stage due to the hardware, but still...

Wouldn't it be easier to just ljmp to the start address of the kernel in memory
(the address after the bootloader has done its thing), effectively restarting
the kernel from line 1? Or is tehre an issue with some hardware being in an
invalid state when doing this?

Maybe Eric Biederman can comment on this since he's adding new functionality to
the boot loader..

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com


