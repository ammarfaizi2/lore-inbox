Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUIUMpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUIUMpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUIUMp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:45:28 -0400
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:32131 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267648AbUIUMpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:45:19 -0400
Date: Tue, 21 Sep 2004 14:45:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
Message-ID: <20040921124507.GC2383@elf.ucw.cz>
References: <9e47339104091811431fb44254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339104091811431fb44254@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 1) user owns graphics devices
> 2) user sets mode with string (or similar) format using ioctl common to
> all drivers.
> 3) driver is locked to prevent multiple mode sets
> 4) common code takes this string and does a hotplug event with it.

I though this was

"Driver decides to either do it itself in kernel, or call userspace
helper if that would be too complex".

> How are errors going to be communicated in this scheme? I can cat the
> sysfs mode variable to get a status. Is there a good way to do this
> without polling?

I'd say that write() to that sysfs file can simply return error. See
echo disk > /sys/power/state, it returns error if transition failed.


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
