Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbULNPz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbULNPz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 10:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbULNPz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 10:55:57 -0500
Received: from relay01.pair.com ([209.68.5.15]:51725 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S261527AbULNPzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 10:55:50 -0500
X-pair-Authenticated: 66.134.112.218
Subject: Re: [ACPI] [ACPI][2.6.10-rc3][SUSPEND] S3 mode - Cannot resume
	from PCI devices
From: Daniel Gryniewicz <dang@fprintf.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
In-Reply-To: <20041214110648.GA2291@elf.ucw.cz>
References: <200412100315.21725.shawn.starr@rogers.com>
	 <20041214110648.GA2291@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Dec 2004 10:55:17 -0500
Message-Id: <1103039717.10857.53.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 12:06 +0100, Pavel Machek wrote:
> Hi!
> 
> > I have netconsole configured I can see kernel messages on a remote machine, but when I suspend the laptop it goes into S3.
> > I am unable to capture the (oops) the laptop when bringing it out of S3. It remains in a half suspended-unsuspended state.
> > (the crescent moon LED is solidly on, video is back on (can see the 'Back to C!' string), cannot use sysctl key combos, 
> > netconsole doesn't display the output since no PCI devices resume (the video is AGP onboard).
> > 
> > Is there any way I can capture this output somehow? I don't think even serial would work (it would be a USB to serial converter which would be PCI)
> > or even trying to get this to print to lp0 since the laptop is totally unresponsive in its state.
> > 
> > I booted into single and sh for init, mounted /proc /sys and with no kernel modules it would fail to resume after suspending.
> > 
> > This isn't a nice regression.
> 
> So what was the last kernel where it worked?
> 										Pavel
> 

For me, 2.6.9-rc4.  I've tried every -rc and -mm since, and it cannot
resume.  (I get no video on resume, even with 2.6.9-rc4, until X
resumes, so I get no information what-so-ever, just a dead box.  That's
why I haven't reported this before.)

I have a Dell Inspiron 8600 (Centrino) with the nvidia card.

2.6.9-rc4 suspends and resumes fine, both to memory and disk.  Since
then, nothing has resumed from suspend-to-ram, but occasional versions
(such as 10-rc3-mm1) resumes from suspend-to-disk.

I can give any information that people want.

Daniel
