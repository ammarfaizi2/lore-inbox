Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUDOSWP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUDOSSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:18:36 -0400
Received: from emulex.emulex.com ([138.239.112.1]:18646 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S263365AbUDOSK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:10:29 -0400
Message-ID: <3356669BBE90C448AD4645C843E2BF2802C0168B@xbl.ma.emulex.com>
From: "Smart, James" <James.Smart@Emulex.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: persistence of kernel object attribute ??
Date: Thu, 15 Apr 2004 14:10:15 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes - I was well aware of this, and considered it an "automation" of the
user funciton.

Unfortunately, this won't work, as it doesn't address the case where the
driver is part of the boot process (e.g. it's the hba used to reach the boot
disk). I'm looking for something that addresses this too..

-- James

> -----Original Message-----
> From: Richard B. Johnson [mailto:root@chaos.analogic.com]
> Sent: Thursday, April 15, 2004 2:07 PM
> To: Smart, James
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: persistence of kernel object attribute ??
> 
> 
> On Thu, 15 Apr 2004, Smart, James wrote:
> 
> >
> > I've been looking at everything I can find, asked a few 
> questions, and don't
> > have an answer to the following issue.
> >
> > I have a driver that wants to export attributes per 
> instance. I'd like the
> > ability for the user to modify an attribute dynamically 
> (sysfs works well) -
> > but I'd like the new value to be persistent the next time the driver
> > unloads/loads or the system reboots.  I don't want to have to update
> > constants in source and recompile the driver.  I'm looking 
> for something
> > similar (cringe!) to the MS registry.  Is there a facility 
> available to
> > kernel objects to allow for persistent attributes to be 
> set/retrieved? If
> > not, any recommendations on how to implement this ?
> >
> > -- james
> >
> 
> Make a program that executes upon startup, using the Sys-V startup
> convention. That program interfaces with your driver using a standard
> ioctl() call. It can send or receive anything it wants, which it can
> get or put to any accessible file-system.
> 
> FYI this is the standard Unix/Linux way. You'd be surprised the
> large number of users who haven't got a clue about how Unix starts
> up. They vaguely remember something about "init" and that's it.
> To refresh your memory, look in /etc/rc.d and the sub-directories
> for each run-level. Believe me, you don't want or need a "registry".
> Just put a link to your startup-script in there.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.24 on an i686 machine (5596.77 BogoMips).
>             Note 96.31% of all statistics are fiction.
> 
> 
