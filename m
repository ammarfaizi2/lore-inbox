Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTJ3TBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 14:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJ3TBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 14:01:47 -0500
Received: from Soo.com ([199.202.113.33]:4616 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id S262760AbTJ3TBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 14:01:46 -0500
Date: Thu, 30 Oct 2003 07:46:40 -0500
From: really bensoo_at_soo_dot_com <lnx-kern@soo.com>
To: "linux-kernel @ vger . kernel . org Allen Martin" 
	<AMartin@nvidia.com>
Subject: Re: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
Message-ID: <20031030074640.A3992@Sophia.soo.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F79E@mail-sc-6.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F79E@mail-sc-6.nvidia.com>; from AMartin@nvidia.com on Wed, Oct 29, 2003 at 11:17:26AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just as a point of info; i have had these lockup
probs too.  Have a MSI K7N2 with nVidia TNT2
vidcard.  Using kernel 2.6.0-test9.

When i run mldonkey (file sharing) the box will
lock up solid after a random amount of time in
X no matter what combo of ACPI / no ACPI, PIO / UDMA.
Sometimes the mouse pointer keeps moving for up
to ~30 sec before it too freezes.  During this
interval there's no ATA activity and i can reboot
the box with SysReq key combos.  If i wait until
the mouse freezes then the box is completely
locked and the SysReq keys don't work anymore.

HOWEVER, if i adjust the process priority of
mldonkey to -20, then the box doesn't lock up
anymore with ACPI and local APIC enabled and will
keep running forever and even burn DVD or CD's
while playing a video rip while compiling something.
There's the sporatic ~1 sec freeze when mldonkey
grabs the whole CPU but it always comes back.

regards,


On Wed, Oct 29, 2003 at 11:17:26AM -0800, Allen Martin wrote:
> Hi Ross, can you post the contents of /proc/interrupts, /proc/ide/amd74xx
> and /proc/ide/ide*/config, and also the output of "hdparm -I /dev/hd*" for
> each of your ATA / ATAPI devices?
> 
> If the PIO and UDMA modes are setup correctly I can't think of anything
> inside the IDE driver that should be causing random lockups.  I'd be much
> more suspicious of ACPI / APIC / interrupt setup.
> 
> -Allen
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
