Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSJQLMN>; Thu, 17 Oct 2002 07:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSJQLMN>; Thu, 17 Oct 2002 07:12:13 -0400
Received: from kim.it.uu.se ([130.238.12.178]:53437 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261360AbSJQLMM>;
	Thu, 17 Oct 2002 07:12:12 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15790.40045.655146.814922@kim.it.uu.se>
Date: Thu, 17 Oct 2002 13:18:05 +0200
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.42+ reboot kills Dell Latitude keyboard
In-Reply-To: <m1zntd1kdg.fsf@frodo.biederman.org>
References: <15790.30657.234936.840909@kim.it.uu.se>
	<m1zntd1kdg.fsf@frodo.biederman.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:
 > Mikael Pettersson <mikpe@csd.uu.se> writes:
 > 
 > > Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
 > > Shortly after the screen is blanked and the BIOS starts, it
 > > prints a "keyboard error" message and requests an F1 or F2
 > > response (continue or go into SETUP). Never happened with any
 > > other kernel on that machine.
 > > 
 > > Apparently the 2.5.42+ "let's shut everything down at reboot"
 > > change
 > 
 > There was no such change just a discussion of what the kernel
 > has been doing since 2.5.8 or so.
 > 
 > > put the keyboard controller in a state which is inconsistent
 > > with the BIOS' expections at a warm boot.
 > 
 > There is a bug in device_suspend.  device_shutdown, and device_suspend
 > where merged and the POWER_DOWN case now removes the drivers which
 > is a bug.  You may be getting hit with that.
 > 
 > Eric Blade has posed a patch fixing that.

I tried Eric Blade's patch
<http://marc.theaimsgroup.com/?l=linux-kernel&m=103477012517984&w=2>
but it didn't make any difference. Same keyboard error as before.

So either the patch doesn't change what actions are taken on reboot,
or the keyboard (std SERIO_I8042 + ATKBD PC stuff) driver was also
broken in the 2.5.41->2.5.42 step.

/Mikael
