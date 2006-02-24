Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWBXKe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWBXKe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 05:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBXKe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 05:34:26 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:26499 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932178AbWBXKeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 05:34:25 -0500
Date: Fri, 24 Feb 2006 11:34:32 +0100
From: Sander <sander@humilis.net>
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: sander@humilis.net, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.16-rc3 - sata_mv - Assertion failed!
Message-ID: <20060224103432.GA29847@favonius>
Reply-To: sander@humilis.net
References: <20060217093705.GA20320@favonius> <311601c90602230922i3a429d5cp98a4f4142a37ba1a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311601c90602230922i3a429d5cp98a4f4142a37ba1a@mail.gmail.com>
X-Uptime: 07:38:31 up 23 days, 23:51, 26 users,  load average: 3.59, 3.02, 2.83
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, thank you for your thoughts.

Eric D. Mudama wrote (ao):
> 50/01 is the reset signature FIS. Is it possible that under load you
> aren't supplying enough power to the drives, your 5V or 12V droops too
> much, and the voltage protection circuitry on the drive causes it to
> power cycle?

Good you mention this, but I doubt it for several reasons.

The nine disks are used in a chassis which can hold 26 disks, and the
chassis comes with a 950W PSU.

Right now the system uses 1.4A, which is 322W. I know one needs enough
juice on the 5V and 12V, and thus cannot simple state that if a PSU has
a high rating, it can cope with the load. But it only has nine out of 26
possible disks.

The system has 4GB ram and two Opteron 244 cpu's. So that doesn't cause
much power load either (compared to 16GB ram and two Opteron 280 cpu's,
which is also should be able to handle).

The disks run fine when connected to a Promise SX8 (albeit _very_ slow).

I also connected the nine disk to the onboard nVidia, the SX8 and the
Marvell, each sporting three disks. The errors always and only come from
sata_mv.

So I guess that the beta driver is indeed beta :-)

I'll just wait for someone with more skills than me to have a look at
the driver, and test any patches which result from that. I have a second
system which can be used for that. The one we're talking about is in
production right now.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
